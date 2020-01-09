unit ufrmdrag;

interface
//��win8���޷�ʹ����ק���� ����Ϊûע����ק���� ���Բ�����
//win8��ϵͳ�������������Ѿ������ˣ��������ͨ�Ż���ʧЧ��
//�������ע��һ�� �Ϳ�����
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellAPI;

type
  TfrmDrag = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    function AllowMeesageForVistaAbove(uMessageID:UINT;bAllow:Boolean):Boolean ;
  protected
    procedure DragDropFile(var message:TMessage);  message WM_DROPFILES;
    procedure DoDragDropFile(sPath: string); virtual;
  public
    ChangeWindowMessageFilter:function(msg: UINT; dwFlag: DWORD): BOOL; stdcall;

  end;

var
  frmDrag: TfrmDrag;
  const
    MSGFLT_ADD= 1 ;
    MSGFLT_REMOVE= 2 ;
implementation

{$R *.dfm}

//register global messages for vista win7.
function TfrmDrag.AllowMeesageForVistaAbove(uMessageID:UINT;bAllow:Boolean):Boolean ;
var
   bResult:Boolean;
   hUserMod:HMODULE;
begin
  bResult:=False;
   hUserMod := 0;
  //vista and later
  hUserMod := LoadLibrary(PChar('user32.dll'));
  if( NULL=hUserMod ) then
  begin
    Result:=FALSE;
    Exit;
  end;
  ChangeWindowMessageFilter:=GetProcAddress(hUserMod,'ChangeWindowMessageFilter');
  if not Assigned(ChangeWindowMessageFilter) then
  begin
      Result:= FALSE;
      Exit;
  end;
  if bAllow then
    bResult:= ChangeWindowMessageFilter(uMessageID,  1  )
  else
    bResult:=ChangeWindowMessageFilter(uMessageID, 2);//MSGFLT_ADD: 1, MSGFLT_REMOVE: 2
  if( NULL <> hUserMod )   then
  begin
    FreeLibrary( hUserMod );
  end;
  result:= bResult;
end;

procedure TfrmDrag.DoDragDropFile(sPath: string);
begin
  ShowMessage(sPath);
end;

procedure TfrmDrag.DragDropFile(var message: TMessage);
var
  FileNum: Word;
  p: array[0..254] of char;
begin
  if Message.Msg = WM_DropFiles then
  begin
    FileNum := DragQueryFile(Message.WParam, $FFFFFFFF, nil, 0);
    // ȡ���Ϸ��ļ�����
    for FileNum := 0 to FileNum - 1 do
    begin
      DragQueryFile(Message.WParam, FileNum, p, 255);
      // ȡ���Ϸ��ļ���
      DoDragDropFile(StrPas(p));
    end;
  end;
end;

procedure TfrmDrag.FormCreate(Sender: TObject);
begin
 DragAcceptFiles(Handle,true);
 AllowMeesageForVistaAbove(SPI_SETANIMATION,True);
  //allow drop files
 AllowMeesageForVistaAbove(WM_DROPFILES, True);

end;

end.
