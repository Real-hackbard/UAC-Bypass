unit Unit1;

interface

uses
  Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Shell.ShellCtrls, jpeg, Vcl.ExtCtrls, System.Win.Registry, Vcl.StdCtrls,
  Vcl.Buttons, ShellApi, Vcl.Menus, ShlObj;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    StatusBar1: TStatusBar;
    Bevel1: TBevel;
    Image3: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure JumpToKey(Key: string);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R 'admin.res'}
function SetTokenPrivilege(const APrivilege: string; const AEnable: Boolean): Boolean;
var
  LToken: THandle;
  LTokenPriv: TOKEN_PRIVILEGES;
  LPrevTokenPriv: TOKEN_PRIVILEGES;
  LLength: Cardinal;
  LErrval: Cardinal;
begin
  Result := False;
  if OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, LToken) then
  try
    // Get the locally unique identifier (LUID) .
    if LookupPrivilegeValue(nil, PChar(APrivilege), LTokenPriv.Privileges[0].Luid) then
    begin
      LTokenPriv.PrivilegeCount := 1; // one privilege to set
      case AEnable of
        True: LTokenPriv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        False: LTokenPriv.Privileges[0].Attributes := 0;
      end;
      LPrevTokenPriv := LTokenPriv;
      // Enable or disable the privilege
      Result := AdjustTokenPrivileges(LToken, False, LTokenPriv, SizeOf(LPrevTokenPriv), LPrevTokenPriv, LLength);
    end;
  finally
    CloseHandle(LToken);
  end;
end;

procedure DisableUAC(bTF: Boolean);
var  reg: TRegistry;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('SOFTWARE', True);
  reg.OpenKey('Microsoft', True);
  reg.OpenKey('Windows', True);
  reg.OpenKey('CurrentVersion', True);
  reg.OpenKey('Policies', True);
  reg.OpenKey('System', True);
  if bTF = True then
  begin
    reg.WriteInteger('EnableLUA', 0);
  end else if bTF = False then
  begin reg.WriteInteger('EnableLUA', 1); end;
  reg.CloseKey; reg.Free;
end;

procedure TForm1.JumpToKey(Key: string);
var i, n: Integer; hWin: HWND; ExecInfo: ShellExecuteInfoA;
begin
  hWin := FindWindowA(PAnsiChar('RegEdit_RegEdit'), nil);
  if hWin = 0 then
  {if Regedit doesn't run then we launch it}
  begin
    FillChar(ExecInfo, 60, #0);
    with ExecInfo do
    begin
      cbSize := 60;
      fMask  := SEE_MASK_NOCLOSEPROCESS;
      lpVerb := PAnsiChar('open');
      lpFile := PAnsiChar('regedit.exe');
      nShow  := 1;
    end;
    ShellExecuteExA(@ExecInfo);
    WaitForInputIdle(ExecInfo.hProcess, 200);
    hWin := FindWindowA(PAnsiChar('RegEdit_RegEdit'), nil);
  end;
  ShowWindow(hWin, SW_SHOWNORMAL);
  hWin := FindWindowExA(hWin, 0, PAnsiChar('SysTreeView32'), nil);
  SetForegroundWindow(hWin);
  i := 30;
  repeat
    SendMessageA(hWin, WM_KEYDOWN, VK_LEFT, 0);
    Dec(i);
  until i = 0;
  Sleep(500);
  SendMessageA(hWin, WM_KEYDOWN, VK_RIGHT, 0);
  Sleep(500);
  i := 1;
  n := Length(Key);
  repeat
    if Key[i] = '\' then
    begin
      SendMessageA(hWin, WM_KEYDOWN, VK_RIGHT, 0);
      Sleep(500);
    end
    else
      SendMessageA(hWin, WM_CHAR, Integer(Key[i]), 0);
    i := i + 1;
  until i = n;
end;

function GetAdminSid: PSID;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;  
begin  
  Result := nil;  
  AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,  
    SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,  
    0, 0, 0, 0, 0, 0, Result);  
end;

function IsAdmin: LongBool;
var  
  TokenHandle: THandle;  
  ReturnLength: DWORD;  
  TokenInformation: PTokenGroups;  
  AdminSid: PSID;  
  Loop: Integer;  
begin  
  Result := False;  
  TokenHandle := 0;  
  if OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, TokenHandle) then  
  try  
    ReturnLength := 0;  
    GetTokenInformation(TokenHandle, TokenGroups, nil, 0, ReturnLength);  
    TokenInformation := GetMemory(ReturnLength);  
    if Assigned(TokenInformation) then  
    try  
      if GetTokenInformation(TokenHandle, TokenGroups, TokenInformation,  
        ReturnLength, ReturnLength) then  
      begin  
        AdminSid := GetAdminSid;  
        for Loop := 0 to TokenInformation^.GroupCount - 1 do  
        begin
          // Not Compatible with new VCL
          //if EqualSid(TokenInformation^.Groups[Loop].Sid, AdminSid) then
          //begin
           // Result := True;
            //Break;
          //end;
        end;  
        FreeSid(AdminSid);  
      end;  
    finally  
      FreeMemory(TokenInformation);  
    end;  
  finally  
    CloseHandle(TokenHandle); 
 end;
end;

function GetUsername: String;
var Buffer: array[0..255] of Char; Size: DWord;
begin
  Size := SizeOf(Buffer);
  if not Windows.GetUserName(Buffer, Size) then
    RaiseLastOSError; 
  SetString(Result, Buffer, Size - 1);
end;

function MyExitWindows(RebootParam: Longword): Boolean;
var
  TTokenHd: THandle;
  TTokenPvg: TTokenPrivileges;
  cbtpPrevious: DWORD;
  rTTokenPvg: TTokenPrivileges;
  pcbtpPreviousRequired: DWORD;
  tpResult: Boolean;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    tpResult := OpenProcessToken(GetCurrentProcess(),
      TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
      TTokenHd);
    if tpResult then
    begin
      tpResult := LookupPrivilegeValue(nil,
                                       SE_SHUTDOWN_NAME,
                                       TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;
      TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      cbtpPrevious := SizeOf(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if tpResult then
        Windows.AdjustTokenPrivileges(TTokenHd,
                                      False,
                                      TTokenPvg,
                                      cbtpPrevious,
                                      rTTokenPvg,
                                      pcbtpPreviousRequired);
    end;
  end;
  Result := ExitWindowsEx(RebootParam, 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
var reg : TRegistry;
begin
   Caption:= 'UAC Bypass - User : ' +  GetUsername;
   if IsUserAnAdmin then begin
   StatusBar1.Panels[2].Text := 'You are Administrator';
   end else begin
   StatusBar1.Panels[2].Text := 'You are not Administrator'; end;
   
   begin reg:= TRegistry.Create(KEY_ALL_ACCESS); reg.RootKey:= HKEY_LOCAL_MACHINE;    // uac
    if reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System', false) then
    begin
      if reg.ReadInteger('EnableLUA') = 0 then begin
          Image3.Picture := Image1.Picture;
          //RadioButton1.Checked := true;
          StatusBar1.Panels[0].Text := 'System UAC is off..';
          end;
      if reg.ReadInteger('EnableLUA') = 1 then begin
          Image3.Picture := Image2.Picture;
          //RadioButton3.Checked := true;
          StatusBar1.Panels[0].Text := 'System UAC is on..';
          end;
    end; reg.CloseKey; reg.Free; end;

    if CheckBox2.Checked = true then begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    end;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
   DisableUAC(false);
   Image3.Picture := Image2.Picture;
   StatusBar1.Panels[0].Text := 'System must be Reboot..';
   ShowMessage('Reboot System to Enable functions !');
   StatusBar1.SetFocus; 
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  DisableUAC(false);
  Image3.Picture := Image2.Picture;
   StatusBar1.Panels[0].Text := 'System must be Reboot..';
   ShowMessage('Reboot System to Enable functions !');
   StatusBar1.SetFocus; 
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  DisableUAC(true);
   Image3.Picture := Image1.Picture;
   StatusBar1.Panels[0].Text := 'System must be Reboot..';
   ShowMessage('Reboot System to Enable functions !');
   StatusBar1.SetFocus; 
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then begin
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
  SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end; StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
   StatusBar1.SetFocus;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Beep;
  IF MessageDlg('ATTENTION !'+#13+ 'System Reboot close all Programs,'+#13+'are you sure ? !',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes THEN
    BEGIN MyExitWindows(EWX_REBOOT);
      // type want you want
    END;
    StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  JumpToKey('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System');
  StatusBar1.SetFocus;
end;

end.
