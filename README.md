# :computer: UAC Bypass

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) <img src="https://github.com/user-attachments/assets/42d98116-b65b-40e0-9a54-e2534879c9e2" />  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) <img src="https://github.com/user-attachments/assets/451d650e-869a-4ec6-909e-05d6f6d303a1" />  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

User Account Control (UAC) is a [mandatory access control](https://en.wikipedia.org/wiki/Mandatory_access_control) enforcement feature introduced with [Microsoft's Windows Vista](https://en.wikipedia.org/wiki/Windows_Vista) and Windows Server 2008 operating systems, with a more relaxed[2] version also present in the versions after Vista, being Windows 7, Windows Server 2008 R2, Windows 8, Windows Server 2012, Windows 8.1, Windows Server 2012 R2, Windows 10, and Windows 11. It aims to improve the security of Microsoft Windows by limiting application software to standard [user privileges](https://en.wikipedia.org/wiki/Privilege_(computing)) until an administrator authorises an increase or elevation. In this way, only applications trusted by the user may receive [administrative privileges](https://en.wikipedia.org/wiki/System_administrator) and malware are kept from compromising the operating system. In other words, a user account may have administrator privileges assigned to it, but applications that the user runs do not inherit those privileges unless they are approved beforehand or the user explicitly authorises it.

</br>

<img src="https://github.com/user-attachments/assets/7c5086cb-d186-4744-8831-9aad98e8f76b" />

</br>
</br>

UAC uses [Mandatory Integrity Control](https://en.wikipedia.org/wiki/Mandatory_Integrity_Control) to isolate running processes with different privileges. To reduce the possibility of lower-privilege applications communicating with higher-privilege ones, another new technology, User Interface Privilege Isolation, is used in conjunction with User Account Control to isolate these processes from each other. One prominent use of this is Internet Explorer 7's "Protected Mode".

Operating systems on mainframes and on servers have differentiated between [superusers](https://en.wikipedia.org/wiki/Superuser) and [userland](https://en.wikipedia.org/wiki/User_space_and_kernel_space#USERLAND) for decades. This had an obvious security component, but also an administrative component, in that it prevented users from accidentally changing system settings.

</br>

# :wrench: Functions:

* ```User UAC```
  * UAC (User Account Control) settings in Windows are primarily controlled via the following registry key:
  * RegKey : ```HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA```

| Mode | Description |
| :----------- | :----------- |
| off     | Never notify (Least secure): Disables all UAC prompts, allowing administrator-level changes without confirmation.     |
| quiet     | Notify me only when apps try to make changes (Do not dim my desktop): Same as above, but without switching to the secure desktop.     |
| on     | Fordert jedes Mal eine Zustimmung an, wenn Apps Software installieren oder Änderungen an Windows vornehmen.     |

</br>

* ```Administrator UAC behavior```
   * When an administrator account triggers the User Account Control (UAC) Admin Approval Mode, Windows silently strips administrative rights and runs the process as a standard user. If an app requests full system access, UAC halts execution and displays a prompt requiring the admin to explicitly approve the elevation of privileges.
   * RegKey : ```HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin```

| Value | Description |
| :----------- | :----------- |
| 0     | No prompt. The system automatically elevates privileges without asking the user.     |
| 1     | Prompt for credentials on the secure desktop. The administrator must type their username and password.     |
| 2     | Prompt for consent on the secure desktop. The administrator clicks "Yes" or "No".     |
| 3     | Prompt for credentials (legacy).     |
| 4     | Prompt for consent (legacy).     |
| 5     |  Prompt for consent for non-Windows applications only.     |

</br>

# Registry privileges:
Windows registry privileges control access to creating, reading, and modifying registry keys. Standard users can read most keys and write to ```HKEY_CURRENT_USER```, but modifying system-wide settings in ```HKEY_LOCAL_MACHINE``` requires administrator privileges and elevated execution permissions.

Grant these permissions to the program.

### :speech_balloon: Code example
```pascal
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
```

</br>

### Admin execute:
Running a program with administrator privileges  
In addition, the program includes two different resources.

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
  <assemblyIdentity version="1.0.0.0" processorArchitecture="*" name="MyAppAssemblyNameHere" type="win32"/>
  <description>My App Description</description>
  <!-- uncomment this to enable ComCtl v6 Visual Styles...
  <dependency>
    <dependentAssembly>
      <assemblyIdentity type="win32" name="Microsoft.Windows.Common-Controls" version="6.0.0.0" processorArchitecture="*" publicKeyToken="6595b64144ccf1df" language="*"/>
    </dependentAssembly>
  </dependency>
  -->
  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v2">
    <security>
      <requestedPrivileges>
        <requestedExecutionLevel level="requireAdministrator" uiAccess="false"/>
      </requestedPrivileges>
    </security>
  </trustInfo>
</assembly>
```

### Requesting elevation:
A program can request elevation in a number of different ways. One way for program developers is to add a requestedPrivileges section to an XML document, known as the manifest, that is then embedded into the application. A manifest can specify dependencies, visual styles, and now the appropriate security context:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v2">
    <security>
      <requestedPrivileges>
        <requestedExecutionLevel level="highestAvailable" />
      </requestedPrivileges>
    </security>
  </trustInfo>
</assembly>
```

Setting the level attribute for requestedExecutionLevel to "asInvoker" will make the application run with the token that started it, "highestAvailable" will present a UAC prompt for administrators and run with the usual reduced privileges for standard users, and "requireAdministrator" will require elevation. In both highestAvailable and requireAdministrator modes, failure to provide confirmation results in the program not being launched.

</br>

# Jump to Registry Key:
To jump directly to a specific registry key, copy the full path and paste it into the address bar located directly below the menu bar in the Registry Editor (regedit). Alternatively, use the following code...

### :speech_balloon: Code example

```pascal
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
```

# Manual disable UAC:
To manually disable User Account Control (UAC) on Windows, open the Start menu, search for UAC, and select Change User Account Control settings. Drag the slider down to Never notify and click OK. Restart your PC to apply the changes.

If you need to completely disable UAC deep in the system, you can edit the Windows Registry:
* Press ```Win + R```, type ```regedit```, and hit Enter.
* Navigate to: ```HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System.Locate```
* Locate the ```EnableLUA``` value on the right side and double-click it.
* Change the value data to ```0``` and click OK.
* Restart your computer.
