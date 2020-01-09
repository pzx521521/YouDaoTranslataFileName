{******************************************************}
{ #### 批量对文件名  翻译 并 重命名
  ##### 说明:
    + 使用有道接口
      ```
      http://fanyi.youdao.com/translate?&doctype=json&version&i=  + word
      ```
    + 翻译是进行批量翻译 为了防止过多翻译导致接口被封

  ##### todo:
    + 添加语言转换, 由特定语言转为特定语言
    + 不进行批量翻译 进行单个翻译
    + 目前不支持拖入多个文件/文件夹, 目前多个取最后一个

}
{******************************************************}

unit ufrmYouDaoTranslataFileName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxCustomData, cxStyles, cxTL, cxTextEdit, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, StdCtrls, ExtCtrls, Generics.Collections, ufrmdrag;

type
  TfrmTranslataFileName = class(Tfrmdrag)
    lst1: TcxTreeList;
    pnlTop: TPanel;
    edt1: TEdit;
    lbl1: TLabel;
    edt2: TEdit;
    lbl2: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    lst1Column1: TcxTreeListColumn;
    lst1Column2: TcxTreeListColumn;
    lst1Column3: TcxTreeListColumn;
    lst1Column4: TcxTreeListColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDic: TDictionary<string,string>;
    procedure InitUI;
    procedure GetAllFile;
    procedure YouDaoTranslate;
    procedure WriteToTreeList;
    function ReName: Integer;
    { Private declarations }
  public
    procedure DoDragDropFile(sPath: string); override;
  end;

var
  frmTranslataFileName: TfrmTranslataFileName;

implementation
uses
  uMyHttp, HTTPApp, Types, IOUtils, superobject;
{$R *.dfm}

procedure TfrmTranslataFileName.FormDestroy(Sender: TObject);
begin
  FDic.Free;
  inherited;
end;

procedure TfrmTranslataFileName.FormCreate(Sender: TObject);
begin
  inherited;
  FDic:= TDictionary<string,string>.Create;
end;

procedure TfrmTranslataFileName.btn1Click(Sender: TObject);
begin
  lst1.Clear;
  GetAllFile();
end;

procedure TfrmTranslataFileName.btn2Click(Sender: TObject);
begin
  YouDaoTranslate();
  WriteToTreeList();
end;

procedure TfrmTranslataFileName.btn3Click(Sender: TObject);
begin
  if MessageDlg('确定要重命名嘛?', mtWarning, [mbOK, mbCancel], 0) = mrOk then
    ShowMessage('成功重命名' + inttostr(ReName()) + '个文件!');
end;

procedure TfrmTranslataFileName.DoDragDropFile(sPath: string);
begin
  if FileExists(sPath) then
  begin
    edt1.Text := ExtractFilePath(sPath);
    edt2.Text := ExtractFileExt(sPath);
  end else if DirectoryExists(sPath) then
  begin
    edt1.Text := sPath;
    edt2.Text := '*';
  end;
end;

procedure TfrmTranslataFileName.InitUI();
begin
  edt1.Text := ExtractFilePath(ParamStr(0));
end;

procedure TfrmTranslataFileName.YouDaoTranslate();
var
  sl: TStringList;
  I: Integer;
  aNode: TcxTreeListNode;
  sJson: string;
  aJsonObj, aJsonObjResult: ISuperObject;
  aJsonArr: TSuperArray;
  aJsonArrResult: TSuperArray;
  J: Integer;
begin
  sl := TStringList.Create;
  try
    aNode := lst1.Root.GetNext;
    while aNode <> nil do
    begin
      sl.Add(Trim(aNode.Texts[1]));
      aNode := aNode.GetNext;
    end;
    sJson := XMLHTTPRequest('http://fanyi.youdao.com/translate?&doctype=json&version&i=' + HTTPEncode(sl.Text));
    sJson := Trim(sJson);
    aJsonObj := SO(sJson);
    aJsonArr := aJsonObj.A['translateResult'];
    for I := 0 to aJsonArr.Length - 1 do
    begin
      aJsonArrResult := aJsonArr.o[I].AsArray;
      for J := 0 to aJsonArrResult.Length - 1 do
      begin
        aJsonObjResult := aJsonArrResult.O[J];
        FDic.AddOrSetValue(aJsonObjResult.S['src'], aJsonObjResult.S['tgt']);
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TfrmTranslataFileName.WriteToTreeList();
var
  aNode: TcxTreeListNode;
  sTrans: string;
begin
  aNode := lst1.Root.GetNext;
  while aNode <> nil do
  begin
    sTrans := aNode.Texts[1];
    if FDic.ContainsKey(sTrans) then
       aNode.Texts[3] := FDic.Items[sTrans];
    aNode := aNode.GetNext;
  end;
end;

function TfrmTranslataFileName.ReName: Integer;
var
  aNode: TcxTreeListNode;
  sOldName, sNewName: string;
begin
  Result := 0;
  aNode := lst1.Root.GetNext;
  while aNode <> nil do
  begin
    sOldName := aNode.Texts[0] + aNode.Texts[1] + aNode.Texts[2];
    sNewName := aNode.Texts[0] + aNode.Texts[3] + aNode.Texts[2];
    if sOldName <> sNewName then
    begin
      RenameFile(sOldName, sNewName);
      Inc(Result);
    end;
    aNode := aNode.GetNext;
  end;
end;

procedure TfrmTranslataFileName.GetAllFile();
var
  files: TStringDynArray;
  str: string;
  aNode: TcxTreeListNode;
  sName, sExt: string;
begin
  files := TDirectory.GetFiles(edt1.Text, '*.' + edt2.Text, TSearchOption.soAllDirectories);
  for str in files do
  begin
    aNode := lst1.Add;
    aNode.Texts[0] := ExtractFilePath(str);
    sName := ExtractFileName(str);
    sExt := ExtractFileExt(str);
    aNode.Texts[1] := Copy(sName,1 , Length(sName) - Length(sExt));
    aNode.Texts[2] := sExt;
  end;
end;

procedure TfrmTranslataFileName.FormShow(Sender: TObject);
begin
  InitUI();
end;

end.
