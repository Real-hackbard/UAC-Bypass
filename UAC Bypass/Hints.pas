unit Hints;

interface

uses
  WinApi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Shell.ShellCtrls, jpeg, Vcl.ExtCtrls;

  { Private-Deklarationen}
    procedure ShowHints(SW : boolean);

implementation

uses
  Unit1;

procedure ShowHints(SW : boolean);
begin
  Form1.RadioButton1.Hint :=  'UAC is disabled (administrator programs' +#13#10+
                              'always run with full privileges).';
  Form1.RadioButton2.Hint :=  'Mute UAC notifications.';
  Form1.RadioButton3.Hint :=  '(Default) UAC operates using a system' +#13#10+
                              'of user notifications and permission levels.';
  Form1.RadioButton4.Hint :=  'Administrator tasks run automatically with' +#13#10+
                              'elevated rights without any warning or' +#13#10+
                              'confirmation dialog.';
  Form1.RadioButton5.Hint :=  'The administrator must manually enter their' +#13#10+
                              'username and password to proceed.';
  Form1.RadioButton6.Hint :=  'The administrator just clicks "Yes" to' +#13#10+
                              'confirm the elevation request.';
  Form1.RadioButton7.Hint :=  'Legacy setting; superseded by Value 1.';
  Form1.RadioButton8.Hint :=  'Legacy setting; superseded by Value 5.';
  Form1.RadioButton9.Hint :=  '(Default) Requires the administrator to manually' +#13#10+
                              'click "Yes" on the dimmed, secure desktop.' +#13#10+
                              'prompt. Standard default behavior';
  Form1.RadioButton12.Hint := 'Automatic rejection (standard users cannot' +#13#10+
                              'run programs with administrator rights).';
  Form1.RadioButton13.Hint := 'The user must enter administrator credentials.';
  Form1.RadioButton26.Hint := '(Default) Windows blocks the operation' +#13#10+
                              'because standard users are not permitted' +#13#10+
                              'to perform administrative actions.';
  Form1.RadioButton10.Hint := '(Default) User Account Control is not' +#13#10+
                              'enforced for the built-in administrator' +#13#10+
                              'account. The account behaves as it does' +#13#10+
                              'in Windows and automatically runs all' +#13#10+
                              'applications with full privileges.';
  Form1.RadioButton11.Hint := 'User Account Control is also enforced' +#13#10+
                              'for the built-in administrator account.' +#13#10+
                              'As a result, actions and programs require' +#13#10+
                              'manual confirmation ("Admin Approval Mode").';
  Form1.RadioButton14.Hint := '(Default) Automatic detection of installation files' +#13#10+
                              'is disabled. As a result, users with standard' +#13#10+
                              'privileges may no longer be able to launch' +#13#10+
                              'installations without issues.';
  Form1.RadioButton15.Hint := 'Windows detects installers and automatically' +#13#10+
                              'prompts for confirmation or a password.';
  Form1.RadioButton16.Hint := '(Default) Signature checking is not enforced.' +#13#10+
                              'Unsigned elevated apps will run.';
  Form1.RadioButton17.Hint := 'Only elevates and executes signed and' +#13#10+
                              'validated applications';
  Form1.RadioButton24.Hint := 'Disables the virtualization feature' +#13#10+
                              'globally. Programs attempting to write' + #13#10+
                              'to restricted areas will fail outright.';
  Form1.RadioButton25.Hint := '(Default) Automatically virtualizes failed registry' +#13#10+
                              'and file system write operations by' + #13#10+
                              'unprivileged, interactive 32-bit processes.';
  Form1.RadioButton18.Hint := 'Allows UIAccess apps to run from any' +#13#10+
                              'location on your system.';
  Form1.RadioButton19.Hint := '(Default) Forces UIAccess apps to run' +#13#10+
                              'only from secure, write-protected paths.';
  Form1.RadioButton20.Hint := '(Default) The secure desktop is being used.';
  Form1.RadioButton21.Hint := 'Accessibility features can bypass the secure desktop.';
  Form1.RadioButton22.Hint := 'Disables the Secure Desktop (stops screen dimming).';
  Form1.RadioButton23.Hint := '(Default) Enables the Secure Desktop (screen dims).';
end;

end.
