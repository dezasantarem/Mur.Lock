unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  IBX.IBCustomDataSet, IBX.IBQuery, Datasnap.Provider, Data.DB,
  Datasnap.DBClient, Vcl.DBCtrls, Vcl.Imaging.pngimage, MMSystem, Vcl.MPlayer,
  Vcl.Buttons;

type
  TfrmMain = class(TForm)
    pnBase: TPanel;
    imgLogo: TImage;
    cbxPersonagem: TDBLookupComboBox;
    lbPersonagem: TLabel;
    btNovoPers: TBitBtn;
    btNovaIns: TBitBtn;
    btVerIns: TBitBtn;
    btTabIns: TBitBtn;
    qryPerso: TIBQuery;
    qryPersoPRS_CODIGO: TIntegerField;
    qryPersoCLS_CODIGO: TIntegerField;
    dtsPerso: TDataSource;
    qryPersoPRS_NOME: TIBStringField;

    procedure FormShow(Sender: TObject);
    procedure imgLogoClick(Sender: TObject);
    procedure cbxPersonagemClick(Sender: TObject);
    procedure btNovoPersClick(Sender: TObject);
    procedure btNovaInsClick(Sender: TObject);
    procedure btVerInsClick(Sender: TObject);
    procedure btTabInsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure loadPersonagens();
    procedure mudaCores();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses CadPersonagem, CadInstancia, DM, TabInstancias, unFuncoes, VerInstancias;

procedure TfrmMain.loadPersonagens;
begin
  qryPerso.Close;
  qryPerso.Open;
  qryPerso.FetchAll;
end;

procedure TfrmMain.mudaCores;
begin
  if codPerso > 0 then
  begin
    cbxPersonagem.Font.Color := corPerso;
    btNovoPers.Font.Color := corPerso;
    btNovaIns.Font.Color := corPerso;
    btVerIns.Font.Color := corPerso;
    btTabIns.Font.Color := corPerso;
  end
  else
  begin
    cbxPersonagem.Font.Color := clBlack;
    btNovoPers.Font.Color := clBlack;
    btNovaIns.Font.Color := clBlack;
    btVerIns.Font.Color := clBlack;
    btTabIns.Font.Color := clBlack;
  end;
end;

procedure TfrmMain.btNovaInsClick(Sender: TObject);
begin
  if cbxPersonagem.KeyValue = null then
  begin
    ShowMessage('Selecione um personagem!');
    cbxPersonagem.SetFocus;
    exit;
  end;

  try
    Application.CreateForm(TfrmCadInstancia, frmCadInstancia);

    frmCadInstancia.ShowModal;

    loadPersonagens;
  finally
    frmCadInstancia := nil;
  end;
end;

procedure TfrmMain.btNovoPersClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadPersonagem, frmCadPersonagem);

    frmCadPersonagem.ShowModal;

    loadPersonagens;

    if codPerso > 0 then
    begin
      cbxPersonagem.Keyvalue := codPerso;
      cbxPersonagemClick(nil);
    end;
  finally
    frmCadPersonagem := nil;
  end;
end;

procedure TfrmMain.btTabInsClick(Sender: TObject);
begin
  if cbxPersonagem.KeyValue = null then
  begin
    ShowMessage('Selecione um personagem!');
    cbxPersonagem.SetFocus;
    exit;
  end;

  try
    Application.CreateForm(TfrmTabInstancias, frmTabInstancias);

    frmTabInstancias.ShowModal;

    loadPersonagens;
  finally
    frmTabInstancias := nil;
  end;
end;


procedure TfrmMain.btVerInsClick(Sender: TObject);
begin
  if cbxPersonagem.KeyValue = null then
  begin
    ShowMessage('Selecione um personagem!');
    cbxPersonagem.SetFocus;
    exit;
  end;

  try
    Application.CreateForm(TfrmVerInstancias, frmVerInstancias);

    frmVerInstancias.ShowModal;

    loadPersonagens;
  finally
    frmVerInstancias := nil;
  end;
end;

procedure TfrmMain.cbxPersonagemClick(Sender: TObject);
begin
  if cbxPersonagem.keyvalue <> null then
  begin
    codPerso  := cbxPersonagem.keyvalue;
    nomePerso := cbxPersonagem.Text;
    corPerso  := corClasse(qryPersoCLS_CODIGO.AsString, 'C');
  end;
  mudaCores;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  codPerso := -1;
  nomePerso := '';
  corPerso := clBlack;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  loadPersonagens;

  //somMurloc;
end;

procedure TfrmMain.imgLogoClick(Sender: TObject);
begin
  //somMurloc;
end;

end.
