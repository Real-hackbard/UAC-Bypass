unit Unit1;

interface

uses
  Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Shell.ShellCtrls, jpeg, Vcl.ExtCtrls, System.Win.Registry, Vcl.StdCtrls,
  Vcl.Buttons, ShellApi, Vcl.Menus, ShlObj;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    Bevel1: TBevel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
{$R 'request.res'}  // Requesting elevation
{$R 'admin.res'}    // execute current process with admin rights

// Check the UAC status in the registry.
procedure CheckRegistryUAC;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    { in case only the master key is to be checked.
    // Check if the Registry Key exists
    if Reg.KeyExists('Software\MyCompany\MyApp') then
      WriteLn('Key exists!')
    else
      WriteLn('Key does not exist.');
    }

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('EnableLUA') then
        begin
          Form1.Label1.Font.Color := clGreen;
          Form1.Label1.Caption := ('UAC Value exists!');
        end else begin
          Form1.Label1.Font.Color := clMaroon;
          Form1.Label1.Caption := ('UAC Value not exists!');
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Check the  Admninistrators (Behavior) status in the registry.
procedure CheckRegistryAdminUAC;
var
  reg: TRegistry;
  i : integer;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    { in case only the master key is to be checked.
    // Check if the Registry Key exists
    if Reg.KeyExists('Software\MyCompany\MyApp') then
      WriteLn('Key exists!')
    else
      WriteLn('Key does not exist.');
    }

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('ConsentPromptBehaviorAdmin') then
        begin
          Form1.Label2.Font.Color := clGreen;
          Form1.Label2.Caption := ('Administrator Behavior Value exists!');
        end else begin
          Form1.Label2.Font.Color := clMaroon;
          Form1.Label2.Caption := ('Administrator Behavior Value not exists!');

          for i := 4 to 9 do
          begin
            TRadioButton(Form1.findcomponent('RadioButton' + inttostr(i))).Enabled := false;
          end;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

{ a complete, ready-to-use method that retrieves all privileges of the
  current process and writes them—along with their current status
  (enabled, disabled, or enabled by default)—into a list of strings. }
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
      // one privilege to set
      LTokenPriv.PrivilegeCount := 1;
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

// Set the administrator (behavior) status.
procedure DisableAdministrators(bTF: Boolean);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    // open the registry key
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE', True);
    reg.OpenKey('Microsoft', True);
    reg.OpenKey('Windows', True);
    reg.OpenKey('CurrentVersion', True);
    reg.OpenKey('Policies', True);
    reg.OpenKey('System', True);

    if Form1.RadioButton4.Checked = True then
    begin
      { Elevate without prompt. The prompt is disabled, and administrative
        rights are granted silently. }
      reg.WriteInteger('ConsentPromptBehaviorAdmin', 0);
    end;

    if Form1.RadioButton5.Checked = True then
    begin
      { Prompt for credentials. Administrators must type their username
        and password on the secure desktop to authorize. }
      reg.WriteInteger('ConsentPromptBehaviorAdmin', 1);
    end;

    if Form1.RadioButton6.Checked = True then
    begin
      { Prompt for consent. Administrators must manually click "Yes" to
        permit the action. }
      reg.WriteInteger('ConsentPromptBehaviorAdmin', 2);
    end;

    if Form1.RadioButton7.Checked = True then
    begin
      { Prompt for credentials on the secure desktop. (Usually for
        non-Administrators). }
      reg.WriteInteger('ConsentPromptBehaviorAdmin', 3);
    end;

    if Form1.RadioButton8.Checked = True then
    begin
      { Prompt for consent on the secure desktop. (Usually for non-Administrators). }
      reg.WriteInteger('ConsentPromptBehaviorAdmin', 4);
    end;

    if Form1.RadioButton9.Checked = True then
    begin
      { Prompt for consent for non-Windows binaries. (Default) The prompt
        appears asking for consent, but only if the requesting app is not
        verified as a core Windows application. }
      reg.WriteInteger('ConsentPromptBehaviorAdmin', 5);
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// Set the uac status.
procedure DisableUAC(bTF: Boolean);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
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
    end else
      if bTF = False then
      begin
        reg.WriteInteger('EnableLUA', 1);
      end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

{ In Delphi, you can force the Windows Registry Editor (regedit.exe)
  to automatically jump directly to a specific registry key by modifying
  the LastKey value inside the Regedit applet registry before launching it. }
procedure TForm1.JumpToKey(Key: string);
var
  i, n: Integer;
  hWin: HWND;
  ExecInfo: ShellExecuteInfoA;
begin
  hWin := FindWindowA(PAnsiChar('RegEdit_RegEdit'), nil);
  if hWin = 0 then
  {if Regedit doesn't run then we launch it}
  begin
    // transmit information
    FillChar(ExecInfo, 60, #0);
    with ExecInfo do
    begin
      cbSize := 60;
      { informs the Windows operating system that the process handle of
        the launched application should be kept open in the hProcess field
        of the TShellExecuteInfo structure. }
      fMask  := SEE_MASK_NOCLOSEPROCESS;
      lpVerb := PAnsiChar('open');
      lpFile := PAnsiChar('regedit.exe');
      nShow  := 1;
    end;

    // execute process
    ShellExecuteExA(@ExecInfo);

    { pauses the execution of the current thread until a newly started
      process has completed its initialization }
    WaitForInputIdle(ExecInfo.hProcess, 200);
    hWin := FindWindowA(PAnsiChar('RegEdit_RegEdit'), nil);
  end;

  // show the windows regitsry
  ShowWindow(hWin, SW_SHOWNORMAL);
  // find the registry gui
  hWin := FindWindowExA(hWin, 0, PAnsiChar('SysTreeView32'), nil);
  // set windows registry top
  SetForegroundWindow(hWin);
  i := 30;

  repeat
    // simulate on key down
    SendMessageA(hWin, WM_KEYDOWN, VK_LEFT, 0);
    Dec(i);
  until i = 0;

  // the waiting time (ms) for switching the path in the registry (can be changed)
  Sleep(150);
  SendMessageA(hWin, WM_KEYDOWN, VK_RIGHT, 0);
  Sleep(150);
  i := 1;
  n := Length(Key);
  repeat
    if Key[i] = '\' then
    begin
      SendMessageA(hWin, WM_KEYDOWN, VK_RIGHT, 0);
      Sleep(150);
    end
    else
      SendMessageA(hWin, WM_CHAR, Integer(Key[i]), 0);
    i := i + 1;
  until i = n;
end;

{ Creates the SID for the local Administrators group (S-1-5-32-544).
  The returned SID MUST be manually released using FreeSid(). }
function GetAdminSid: PSID;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;  
begin
  Result := nil;
  // To assign a Security ID (SID) with up to 8 sub-authorities (RIDs)
  AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
    SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS,  
    0, 0, 0, 0, 0, 0, Result);  
end;

// Check whether the local Windows account has administrator rights.
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
    // Retrieve details about a process's access token
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

// Determine the current user.
function GetUsername: String;
var
  Buffer: array[0..255] of Char;
  Size: DWord;
begin
  Size := SizeOf(Buffer);
  if not Windows.GetUserName(Buffer, Size) then
    RaiseLastOSError;
  // transferring information
  SetString(Result, Buffer, Size - 1);
end;

// system reboot function
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
    // Open the access token of the current process
    tpResult := OpenProcessToken(GetCurrentProcess(),
      TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
      TTokenHd);
    if tpResult then
    begin
      // Retrieve the LUID for the privilege name (e.g., 'SeDebugPrivilege')
      tpResult := LookupPrivilegeValue(nil,
                                       SE_SHUTDOWN_NAME,
                                       TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;
      // enable the Privileges
      TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      cbtpPrevious := SizeOf(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if tpResult then
        // Adjust privilege in the token
        Windows.AdjustTokenPrivileges(TTokenHd,
                                      False,
                                      TTokenPvg,
                                      cbtpPrevious,
                                      rTTokenPvg,
                                      pcbtpPreviousRequired);
    end;
  end;
  // Check whether the change was successful.
  Result := ExitWindowsEx(RebootParam, 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  reg : TRegistry;
begin
{$R-}            // Disable range checking
{$F-}            // Force Far Calls
{$I-}            // Switch off I/O error checking
{$B-}            // Complete Boolean Evaluation Off
{$Q-}            // Overflow Checking Off
{$WARNINGS OFF}
{$WARN SYMBOL_PLATFORM OFF}

  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  // get user name
  Caption:= 'UAC Bypass - User : ' +  GetUsername;

  // get windows version TOS
  Label3.Caption := TOSVersion.ToString;

  // check the UAC status
  CheckRegistryUAC;

  // check then  Admninistrators (Behavior) status
  CheckRegistryAdminUAC;

  // check the local account for admin privilegs
  if IsUserAnAdmin then
  begin
    StatusBar1.Panels[2].Text := 'You are Administrator';
  end else begin
    StatusBar1.Panels[2].Text := 'You are not Administrator';
  end;

  try
    // Load a specific logo for the UAC status.
    reg:= TRegistry.Create(KEY_ALL_ACCESS);
    reg.RootKey:= HKEY_LOCAL_MACHINE;
    if reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System', false) then
    begin
      if reg.ReadInteger('EnableLUA') = 0 then
      begin
        Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                    'Data\grau.bmp');
        StatusBar1.Panels[0].Text := 'System UAC is off.';
      end;

      if reg.ReadInteger('EnableLUA') = 1 then
      begin
        Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                    'Data\uac.bmp');
        StatusBar1.Panels[0].Text := 'System UAC is on.';
      end;
     end;
  finally
    reg.CloseKey;
    reg.Free;
  end;

  if CheckBox2.Checked = true then
  begin
      SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
              SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;

  RadioButton4.Hint := 'Administrator tasks run automatically with' +#13#10+
                       'elevated rights without any warning or' +#13#10+
                       'confirmation dialog.';
  RadioButton5.Hint := 'The administrator must manually enter their' +#13#10+
                       'username and password to proceed.';
  RadioButton6.Hint := 'The administrator just clicks "Yes" to' +#13#10+
                       'confirm the elevation request.';
  RadioButton7.Hint := 'Legacy setting; superseded by Value 1.';
  RadioButton8.Hint := 'Legacy setting; superseded by Value 5.';
  RadioButton9.Hint := 'Requires the administrator to manually' +#13#10+
                       'click "Yes" on the dimmed, secure desktop.' +#13#10+
                       'prompt. Standard default behavior';

{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 22}   // It's better if the correct compiler version is listed here; in my case it was version 22.
    {$DEFINE STRING_IS_UNICODESTRING}
  {$IFEND}
{$ENDIF}
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
   DisableUAC(false);
   try
    Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\uac.bmp');
    RadioButton4.Checked := true;
    RadioButton4.OnClick(sender);
   except
    on E: Exception do
      ShowMessage(E.Message);
   end;
   StatusBar1.Panels[0].Text := 'System must be Reboot..';
   ShowMessage('Reboot System to Enable functions !');
   StatusBar1.SetFocus;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  DisableUAC(false);
  try
    Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\uac.bmp');
  except
    on E: Exception do
      ShowMessage(E.Message);
   end;

  StatusBar1.Panels[0].Text := 'System must be Reboot..';
  ShowMessage('Reboot System to Enable functions !');
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  DisableUAC(true);
  try
    Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\grau.bmp');
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  StatusBar1.Panels[0].Text := 'System must be Reboot..';
  ShowMessage('Reboot System to Enable functions !');
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
               SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
               SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
   StatusBar1.SetFocus;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Beep;
  IF MessageDlg('ATTENTION !'+#13+ 'System Reboot close all Programs,'+#13+'are you sure ? !',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    BEGIN
      MyExitWindows(EWX_REBOOT);
      // type want you want
    END;
    StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // Jump to the UAC value in the registry.
  JumpToKey('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System');
  StatusBar1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close();
end;

end.
