unit Unit1;

interface

uses
  WinApi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Shell.ShellCtrls, jpeg, Vcl.ExtCtrls, System.Win.Registry, Vcl.StdCtrls,
  Vcl.Buttons, WinApi.ShellApi, Vcl.Menus, WinApi.ShlObj;

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
    Label3: TLabel;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    Button3: TButton;
    GroupBox3: TGroupBox;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    GroupBox4: TGroupBox;
    RadioButton12: TRadioButton;
    RadioButton13: TRadioButton;
    GroupBox5: TGroupBox;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    GroupBox6: TGroupBox;
    RadioButton16: TRadioButton;
    RadioButton17: TRadioButton;
    GroupBox7: TGroupBox;
    RadioButton18: TRadioButton;
    RadioButton19: TRadioButton;
    GroupBox8: TGroupBox;
    RadioButton20: TRadioButton;
    RadioButton21: TRadioButton;
    GroupBox9: TGroupBox;
    RadioButton22: TRadioButton;
    RadioButton23: TRadioButton;
    GroupBox10: TGroupBox;
    RadioButton24: TRadioButton;
    RadioButton25: TRadioButton;
    RadioButton26: TRadioButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    CheckBox3: TCheckBox;
    Button4: TButton;
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
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure RadioButton8Click(Sender: TObject);
    procedure RadioButton9Click(Sender: TObject);
    procedure RadioButton10Click(Sender: TObject);
    procedure RadioButton11Click(Sender: TObject);
    procedure RadioButton12Click(Sender: TObject);
    procedure RadioButton13Click(Sender: TObject);
    procedure RadioButton26Click(Sender: TObject);
    procedure RadioButton14Click(Sender: TObject);
    procedure RadioButton15Click(Sender: TObject);
    procedure RadioButton16Click(Sender: TObject);
    procedure RadioButton17Click(Sender: TObject);
    procedure RadioButton18Click(Sender: TObject);
    procedure RadioButton19Click(Sender: TObject);
    procedure RadioButton20Click(Sender: TObject);
    procedure RadioButton21Click(Sender: TObject);
    procedure RadioButton22Click(Sender: TObject);
    procedure RadioButton23Click(Sender: TObject);
    procedure RadioButton24Click(Sender: TObject);
    procedure RadioButton25Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure JumpToKey(Key: string);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  Hints;

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
          // Check if UAC is disabled.
          if reg.ReadInteger('EnableLUA') = 0 then
          begin
            Form1.Shape3.Brush.Color := clRed;
            Form1.Label1.Font.Color := clGreen;
            Form1.Label1.Caption := ('UAC Value exists!');
          end;

          // Check if UAC is enabled.
          if reg.ReadInteger('EnableLUA') = 1 then
          begin
            Form1.Shape3.Brush.Color := clRed;
            Form1.Label1.Font.Color := clGreen;
            Form1.Label1.Caption := ('UAC Value exists!');
          end;

          // This checks whether uac quiet mode is off.
          if (reg.ReadInteger('EnableLUA') = 1) and
             (reg.ReadInteger('ConsentPromptBehaviorAdmin') = 5) then
          begin
            Form1.Shape3.Brush.Color := clLime;
            Form1.Label1.Font.Color := clGreen;
            Form1.Label1.Caption := ('UAC Value exists!');
          end;

          // This checks whether uac quiet mode is on.
          if (reg.ReadInteger('EnableLUA') = 1) and
             (reg.ReadInteger('ConsentPromptBehaviorAdmin') = 0) then
          begin
            Form1.Shape3.Brush.Color := clGray;
            Form1.Label1.Font.Color := clGreen;
            Form1.Label1.Caption := ('UAC Value exists!');
          end;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user uac Enable Virtualization
procedure DisableVirtualization(bTF: Boolean);
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

    { To enable virtualization, you need to turn it on in your computer's
      BIOS or UEFI settings (the deep-level menu that controls your computer's
      hardware). This allows your PC to run virtual machines, emulators,
      or Windows Subsystem for Android. }

    if Form1.RadioButton24.Checked = True then
    begin
      reg.WriteInteger('EnableVirtualization', 0);
      Form1.Shape7.Brush.Color := clRed;
    end;

    if Form1.RadioButton25.Checked = True then
    begin
      reg.WriteInteger('EnableVirtualization', 1);
      Form1.Shape7.Brush.Color := clLime;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check user uac Virtualization
procedure CheckVirtualization;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('EnableVirtualization') then
        begin
          Form1.RadioButton24.Enabled := true;
          Form1.RadioButton25.Enabled := true;
        end else begin
          Form1.RadioButton24.Enabled := false;
          Form1.RadioButton25.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user uac Prompt On Secure Desktop
procedure DisablePromptOnSecureDesktop(bTF: Boolean);
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

    { PromptOnSecureDesktop is a Windows Registry setting that controls
      how the User Account Control (UAC) displays prompts for administrative
      changes. When activated, it locks and dims your screen, forcing
      you to answer an elevation request before doing anything else.
      This prevents rogue programs from clicking the prompt for you. }

    if Form1.RadioButton22.Checked = True then
    begin
      reg.WriteInteger('PromptOnSecureDesktop', 0);
      Form1.Shape10.Brush.Color := clRed;
    end;

    if Form1.RadioButton23.Checked = True then
    begin
      reg.WriteInteger('PromptOnSecureDesktop', 1);
      Form1.Shape10.Brush.Color := clLime;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check user uac Prompt On Secure Desktop
procedure CheckPromptOnSecureDesktop;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('PromptOnSecureDesktop') then
        begin
          Form1.RadioButton22.Enabled := true;
          Form1.RadioButton23.Enabled := true;
        end else begin
          Form1.RadioButton22.Enabled := false;
          Form1.RadioButton23.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user uac UIA Desktop Toggle
procedure DisableUIADesktopToggle(bTF: Boolean);
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

    { The EnableUIADesktopToggle is a Windows Registry setting that
      controls how User Account Control (UAC) prompts behave. Specifically,
      it dictates whether certain accessibility programs (like Remote Assistance)
      can bypass the darkened "Secure Desktop" to display permission
      prompts directly on your normal screen. }

    if Form1.RadioButton20.Checked = True then
    begin
      reg.WriteInteger('EnableUIADesktopToggle', 0);
      Form1.Shape9.Brush.Color := clRed;
    end;

    if Form1.RadioButton21.Checked = True then
    begin
      reg.WriteInteger('EnableUIADesktopToggle', 1);
      Form1.Shape9.Brush.Color := clLime;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check user uac UIA Desktop Toggle
procedure CheckUIADesktopToggle;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('EnableUIADesktopToggle') then
        begin
          Form1.RadioButton20.Enabled := true;
          Form1.RadioButton21.Enabled := true;
        end else begin
          Form1.RadioButton20.Enabled := false;
          Form1.RadioButton21.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user uac UI Access
procedure DisableUIAccess(bTF: Boolean);
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

    { The EnableSecureUIAPaths registry key is a core User Account
      Control (UAC) policy that restricts how specialized apps
      request system privileges. }

    if Form1.RadioButton18.Checked = True then
    begin
      reg.WriteInteger('EnableSecureUIAPaths', 0);
      Form1.Shape8.Brush.Color := clRed;
    end;

    if Form1.RadioButton19.Checked = True then
    begin
      reg.WriteInteger('EnableSecureUIAPaths', 1);
      Form1.Shape8.Brush.Color := clLime;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check user uac UI Access
procedure CheckUIAccess;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('EnableSecureUIAPaths') then
        begin
          Form1.RadioButton18.Enabled := true;
          Form1.RadioButton19.Enabled := true;
        end else begin
          Form1.RadioButton18.Enabled := false;
          Form1.RadioButton19.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user uac execution block
procedure DisableExecutionBlock(bTF: Boolean);
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

    { The ValidateAdminCodeSignatures registry key controls how Windows
      handles security for programs that need special admin rights.
      Setting it to 1 forces Windows to only run programs with admin
      rights if their security signature is officially validated.
      Setting it to 0 turns this security check off. }

    if Form1.RadioButton16.Checked = True then
    begin
      reg.WriteInteger('ValidateAdminCodeSignatures', 0);
      Form1.Shape6.Brush.Color := clRed;
    end;

    if Form1.RadioButton17.Checked = True then
    begin
      reg.WriteInteger('ValidateAdminCodeSignatures', 1);
      Form1.Shape6.Brush.Color := clLime;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check user execution block
procedure CheckExecutionBlock;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('ValidateAdminCodeSignatures') then
        begin
          Form1.RadioButton16.Enabled := true;
          Form1.RadioButton17.Enabled := true;
        end else begin
          Form1.RadioButton16.Enabled := false;
          Form1.RadioButton17.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user uac installer detection
procedure DisableInstallerDetection(bTF: Boolean);
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

    { The EnableInstallerDetection registry entry controls the automatic
      detection of installers in Windows. When this feature is enabled,
      the system looks for keywords such as "Install" or "Setup" in file
      names and automatically requests the administrator privileges
      required for installation upon execution. }

    if Form1.RadioButton14.Checked = True then
    begin
      reg.WriteInteger('EnableInstallerDetection', 0);
      Form1.Shape2.Brush.Color := clRed;
    end;

    if Form1.RadioButton15.Checked = True then
    begin
      reg.WriteInteger('EnableInstallerDetection', 1);
      Form1.Shape2.Brush.Color := clLime;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check installer detection
procedure CheckInstallerDetection;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('EnableInstallerDetection') then
        begin
          Form1.RadioButton14.Enabled := true;
          Form1.RadioButton15.Enabled := true;
        end else begin
          Form1.RadioButton14.Enabled := false;
          Form1.RadioButton15.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Set the user (behavior) uac status.
procedure DisableUserBehavior(bTF: Boolean);
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

    { The ConsentPromptBehaviorUser registry key dictates how Windows
      handles administrative permission requests for Standard Users. }

    if Form1.RadioButton12.Checked = True then
    begin
      // Elevated privileges
      reg.WriteInteger('ConsentPromptBehaviorUser', 0);
      Form1.Shape4.Brush.Color := clLime;
    end;

    if Form1.RadioButton13.Checked = True then
    begin
      // Standard privileges
      reg.WriteInteger('ConsentPromptBehaviorUser', 1);
      Form1.Shape4.Brush.Color := clGray;
    end;

    if Form1.RadioButton26.Checked = True then
    begin
      // Disable privileges
      reg.WriteInteger('ConsentPromptBehaviorUser', 3);
      Form1.Shape4.Brush.Color := clRed;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// Set the uac filter admin token status.
procedure FilterAdminUAC(bTF: Boolean);
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

    { The FilterAdministratorToken registry key controls how Windows
      manages permissions for the built-in, default Administrator account.
      Setting it to 1 enables UAC (User Account Control) for this account,
      requiring you to approve administrative actions. Setting it to
      0 (default) disables UAC, granting full, unrestricted rights at
      all times. }

    if bTF = True then
    begin
      reg.WriteInteger('FilterAdministratorToken', 0);
      Form1.Shape1.Brush.Color := clLime;
    end else
      if bTF = False then
      begin
        reg.WriteInteger('FilterAdministratorToken', 1);
        Form1.Shape1.Brush.Color := clRed;
      end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
end;

// check uac filter admin token status
procedure CheckFilterAdmin;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('FilterAdministratorToken') then
        begin
          Form1.RadioButton10.Enabled := true;
          Form1.RadioButton11.Enabled := true;
        end else begin
          Form1.RadioButton10.Enabled := false;
          Form1.RadioButton11.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

procedure CheckUserBehavior;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_ALL_ACCESS);
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check if a specific value exists within that key
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') then
      try
        if Reg.ValueExists('ConsentPromptBehaviorUser') then
        begin
          Form1.RadioButton12.Enabled := true;
          Form1.RadioButton13.Enabled := true;
          Form1.RadioButton26.Enabled := true;
        end else begin
          Form1.RadioButton12.Enabled := false;
          Form1.RadioButton13.Enabled := false;
          Form1.RadioButton26.Enabled := false;
        end;
      finally
        Reg.CloseKey;
      end;
  finally
    Reg.Free;
  end;
end;

// Check the uac Admninistrators (Behavior) status in the registry.
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

// Set the uac administrator (behavior) status.
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

    if bTF = True then
    begin

      if Form1.RadioButton4.Checked = True then
      begin
        { The ConsentPromptBehaviorAdmin registry key controls how Windows
          handles UAC (User Account Control) prompts for
          administrative accounts. }
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 0);
        Form1.Shape5.Brush.Color := clLime;
      end;

      if Form1.RadioButton5.Checked = True then
      begin
        { Prompt for credentials. Administrators must type their username
          and password on the secure desktop to authorize. }
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 1);
        Form1.Shape5.Brush.Color := clGray;
      end;

      if Form1.RadioButton6.Checked = True then
      begin
        { Prompt for consent. Administrators must manually click "Yes" to
          permit the action. }
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 2);
        Form1.Shape5.Brush.Color := clGray;
      end;

      if Form1.RadioButton7.Checked = True then
      begin
        { Prompt for credentials on the secure desktop. (Usually for
          non-Administrators). }
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 3);
        Form1.Shape5.Brush.Color := clGray;
      end;

      if Form1.RadioButton8.Checked = True then
      begin
        { Prompt for consent on the secure desktop. (Usually for non-Administrators). }
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 4);
        Form1.Shape5.Brush.Color := clGray;
      end;

      if Form1.RadioButton9.Checked = True then
      begin
        { Prompt for consent for non-Windows binaries. (Default) The prompt
          appears asking for consent, but only if the requesting app is not
          verified as a core Windows application. }
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 5);
        Form1.Shape5.Brush.Color := clGray;
      end;
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
      // set the uac is off
      if Form1.RadioButton1.Checked = true then
      begin
        reg.WriteInteger('EnableLUA', 0);
      end;

      // set the uac quiet mode is on
      if Form1.RadioButton2.Checked = true then
      begin
        reg.WriteInteger('EnableLUA', 1);
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 0);
      end;

      // set the uac quiet mode is off
      if Form1.RadioButton3.Checked = true then
      begin
        reg.WriteInteger('EnableLUA', 1);
        reg.WriteInteger('ConsentPromptBehaviorAdmin', 5);
      end;
    end;
  finally
    reg.CloseKey;
    reg.Free;
  end;
  Form1.StatusBar1.Panels[4].Text := 'System must be reboot..';
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
  if not WinApi.Windows.GetUserName(Buffer, Size) then
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
        WinApi.Windows.AdjustTokenPrivileges(TTokenHd,
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
{$WARNINGS OFF}  // disable warnings
{$WARN SYMBOL_PLATFORM OFF}  // disables the specific compiler warning W1002 ("Symbol is platform-specific") for the current unit.

  ShowHints(true);
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

  // check FilterAdministratorToken status
  CheckFilterAdmin;

  // check ConsentPromptBehaviorUser status
  CheckUserbehavior;

  // check EnableInstallerDetection status
  CheckInstallerDetection;

  // check ValidateAdminCodeSignatures status
  CheckExecutionBlock;

  // check EnableSecureUIAPaths status
  CheckUIAccess;

  // check EnableUIADesktopToggle status
  CheckUIADesktopToggle;

  // check PromptOnSecureDesktop status
  CheckPromptOnSecureDesktop;

  // check EnableVirtualization status
  CheckVirtualization;

  // check the local account for admin privilegs
  if IsUserAnAdmin then
  begin
    StatusBar1.Panels[2].Text := 'You are Administrator';
  end else begin
    StatusBar1.Panels[2].Text := 'You are not Administrator';
  end;

  try
    reg:= TRegistry.Create(KEY_ALL_ACCESS);
    reg.RootKey:= HKEY_LOCAL_MACHINE;

    { This section serves to check for the existence of the respective
      keys and activate the corresponding boxes. If a key is missing in
      the registry, the box remains deactivated. }

    if reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System', false) then
    begin
      try
        // check UAC adminstrator behavior
        if Reg.ValueExists('ConsentPromptBehaviorAdmin') then
        begin
          // No Prompt (Quiet Mode -Elevate Automatically)
          if reg.ReadInteger('ConsentPromptBehaviorAdmin') = 0 then
          begin
            RadioButton4.Checked := true;
          end;
          // Prompt for Credentials
          if reg.ReadInteger('ConsentPromptBehaviorAdmin') = 1 then
          begin
            RadioButton5.Checked := true;
          end;
          // Prompt for Consent
          if reg.ReadInteger('ConsentPromptBehaviorAdmin') = 2 then
          begin
            RadioButton6.Checked := true;
          end;
          // Prompt for Credentials (Secure Desktop)
          if reg.ReadInteger('ConsentPromptBehaviorAdmin') = 3 then
          begin
            RadioButton7.Checked := true;
          end;
          // Prompt for Consent (Secure Desktop)
          if reg.ReadInteger('ConsentPromptBehaviorAdmin') = 4 then
          begin
            RadioButton8.Checked := true;
          end;
          // Prompt for Consent (Secure Desktop, Standard Default)
          if reg.ReadInteger('ConsentPromptBehaviorAdmin') = 5 then
          begin
            RadioButton9.Checked := true;
          end;
        end;

        // Check the UAC and load the corresponding logo. GRAY for off, RGB for on.
        if Reg.ValueExists('EnableLUA') then
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

          if (reg.ReadInteger('EnableLUA') = 1) and
             (reg.ReadInteger('ConsentPromptBehaviorAdmin') = 0) then
          begin
            Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                        'Data\uac.bmp');
            StatusBar1.Panels[0].Text := 'System UAC is on.';
          end;
        end;

        // read the FilterAdministratorToken registry key
        if Reg.ValueExists('FilterAdministratorToken') then
        begin
          if reg.ReadInteger('FilterAdministratorToken') = 0 then
          begin
            RadioButton10.Checked := true;
          end;

          if reg.ReadInteger('FilterAdministratorToken') = 1 then
          begin
            RadioButton11.Checked := true;
          end;
        end;

        // read the ConsentPromptBehaviorUser registry key
        if Reg.ValueExists('ConsentPromptBehaviorUser') then
        begin
          if reg.ReadInteger('ConsentPromptBehaviorUser') = 0 then
          begin
            RadioButton12.Checked := true;
          end;

          if reg.ReadInteger('ConsentPromptBehaviorUser') = 1 then
          begin
            RadioButton13.Checked := true;
          end;

          if reg.ReadInteger('ConsentPromptBehaviorUser') = 3 then
          begin
            RadioButton26.Checked := true;
          end;
        end;

        // read the EnableInstallerDetection registry key
        if Reg.ValueExists('EnableInstallerDetection') then
        begin
          if reg.ReadInteger('EnableInstallerDetection') = 0 then
          begin
            RadioButton14.Checked := true;
            Shape2.Brush.Color := clRed;
          end;

          if reg.ReadInteger('EnableInstallerDetection') = 1 then
          begin
            RadioButton15.Checked := true;
            Shape2.Brush.Color := clLime;
          end;
        end;

        // read the ValidateAdminCodeSignatures registry key
        if Reg.ValueExists('ValidateAdminCodeSignatures') then
        begin
          if reg.ReadInteger('ValidateAdminCodeSignatures') = 0 then
          begin
            RadioButton16.Checked := true;
          end;

          if reg.ReadInteger('ValidateAdminCodeSignatures') = 1 then
          begin
            RadioButton17.Checked := true;
          end;
        end;

        // read the EnableSecureUIAPaths registry key
        if Reg.ValueExists('EnableSecureUIAPaths') then
        begin
          if reg.ReadInteger('EnableSecureUIAPaths') = 0 then
          begin
            RadioButton18.Checked := true;
          end;

          if reg.ReadInteger('EnableSecureUIAPaths') = 1 then
          begin
            RadioButton19.Checked := true;
          end;
        end;

        // read the EnableUIADesktopToggle registry key
        if Reg.ValueExists('EnableUIADesktopToggle') then
        begin
          if reg.ReadInteger('EnableUIADesktopToggle') = 0 then
          begin
            RadioButton20.Checked := true;
          end;

          if reg.ReadInteger('EnableUIADesktopToggle') = 1 then
          begin
            RadioButton21.Checked := true;
          end;
        end;

        // read the PromptOnSecureDesktop registry key
        if Reg.ValueExists('PromptOnSecureDesktop') then
        begin
          if reg.ReadInteger('PromptOnSecureDesktop') = 0 then
          begin
            RadioButton22.Checked := true;
          end;

          if reg.ReadInteger('PromptOnSecureDesktop') = 1 then
          begin
            RadioButton23.Checked := true;
          end;
        end;

        // read the EnableVirtualization registry key
        if Reg.ValueExists('EnableVirtualization') then
        begin
          if reg.ReadInteger('EnableVirtualization') = 0 then
          begin
            RadioButton24.Checked := true;
          end;

          if reg.ReadInteger('EnableVirtualization') = 1 then
          begin
            RadioButton25.Checked := true;
          end;
        end;
      except
        Exit;
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


{$IFDEF CONDITIONALEXPRESSIONS} // The compiler directive {$IFDEF CONDITIONALEXPRESSIONS} is used in Delphi to check whether the compiler supports extended conditional expressions (such as {$IF ...}).
  {$IF CompilerVersion >= 22}   // It's better if the correct compiler version is listed here; in my case it was version 22.
    {$DEFINE STRING_IS_UNICODESTRING} // In modern Delphi (Delphi 2009 and newer), string is automatically a UnicodeString by default. The line {$DEFINE STRING_IS_UNICODESTRING} is not a built-in command.
  {$IFEND}
{$ENDIF}
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.RadioButton20Click(Sender: TObject);
begin
  DisableUIADesktopToggle(true);
end;

procedure TForm1.RadioButton21Click(Sender: TObject);
begin
  DisableUIADesktopToggle(true);
end;

procedure TForm1.RadioButton22Click(Sender: TObject);
begin
  DisablePromptOnSecureDesktop(true);
end;

procedure TForm1.RadioButton23Click(Sender: TObject);
begin
  DisablePromptOnSecureDesktop(true);
end;

procedure TForm1.RadioButton24Click(Sender: TObject);
begin
  DisableVirtualization(true);
end;

procedure TForm1.RadioButton25Click(Sender: TObject);
begin
  DisableVirtualization(true);
end;

procedure TForm1.RadioButton26Click(Sender: TObject);
begin
  DisableUserBehavior(true);
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
   DisableUAC(true);
   RadioButton4.Checked := true;
   try
    Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\uac.bmp');
   except
    on E: Exception do
      ShowMessage(E.Message);
   end;
   Shape3.Brush.Color := clGray;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  DisableUAC(true);
  try
    Image1.Picture.Bitmap.LoadFromFile(ExtractFilePath(Application.ExeName) +
                                                  'Data\uac.bmp');
  except
    on E: Exception do
      ShowMessage(E.Message);
   end;
  Shape3.Brush.Color := clLime;
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton5Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton6Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton7Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton8Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton9Click(Sender: TObject);
begin
  DisableAdministrators(true);
end;

procedure TForm1.RadioButton10Click(Sender: TObject);
begin
  FilterAdminUAC(true);
end;

procedure TForm1.RadioButton11Click(Sender: TObject);
begin
  FilterAdminUAC(false);
end;

procedure TForm1.RadioButton12Click(Sender: TObject);
begin
  DisableUserBehavior(true);
end;

procedure TForm1.RadioButton13Click(Sender: TObject);
begin
  DisableUserBehavior(true);
end;

procedure TForm1.RadioButton14Click(Sender: TObject);
begin
  DisableInstallerDetection(true);
end;

procedure TForm1.RadioButton15Click(Sender: TObject);
begin
  DisableInstallerDetection(true);
end;

procedure TForm1.RadioButton16Click(Sender: TObject);
begin
  DisableExecutionBlock(true);
end;

procedure TForm1.RadioButton17Click(Sender: TObject);
begin
  DisableExecutionBlock(true);
end;

procedure TForm1.RadioButton18Click(Sender: TObject);
begin
  DisableUIAccess(true);
end;

procedure TForm1.RadioButton19Click(Sender: TObject);
begin
  DisableUIAccess(true);
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
  Shape3.Brush.Color := clRed;
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

// turn hints on/off
procedure TForm1.CheckBox3Click(Sender: TObject);
var
  i : integer;
begin
  if CheckBox3.Checked = true then
  begin
  {$HINTS ON}
    ShowHints(true);
    for i := 1 to 26 do
     begin
        TRadioButton(findcomponent('RadioButton' + inttostr(i))).ShowHint := true;
     end;
  end else begin
  {$HINTS OFF}
    ShowHints(false);
    for i := 1 to 26 do
     begin
        TRadioButton(findcomponent('RadioButton' + inttostr(i))).ShowHint := false;
     end;
  end;
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

// set default registry settings
procedure TForm1.Button4Click(Sender: TObject);
begin
  Beep;
  if MessageBox(Handle,'The standard Windows UAC settings will be applied; are you sure?','Confirm default UAC settings',MB_YESNO) = IDYES then
    BEGIN
      RadioButton3.Checked := true;
      RadioButton4.Checked := true;
      RadioButton26.Checked := true;
      RadioButton10.Checked := true;
      RadioButton15.Checked := true;
      RadioButton16.Checked := true;
      RadioButton25.Checked := true;
      RadioButton19.Checked := true;
      RadioButton20.Checked := true;
      RadioButton23.Checked := true;
    END;

end;

end.
