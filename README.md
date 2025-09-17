# UAC-Bypass:

</br>

```ruby
Compiler    : Delphi10 Seattle, 10.1 Berlin, 10.2 Tokyo, 10.3 Rio, 10.4 Sydney, 11 Alexandria, 12 Athens
Components  : None
Discription : To disbale the User Account Control (UAC) n Registry with Privilegs
Last Update : 09/2025
License     : Freeware
```

</br>

User Account Control (UAC) is a key part of Windows security. UAC reduces the risk of malware by limiting the ability of malicious code to execute with administrator privileges. This article describes how UAC works and how it interacts with the end-users.

</br>

![UAC Bypass](https://github.com/user-attachments/assets/cb7b3df6-9676-483c-befe-a71bbc73bea6)

</br>

User Account Control (UAC) is a [mandatory access control](https://en.wikipedia.org/wiki/Mandatory_access_control) enforcement feature introduced with Microsoft's Windows Vista[1] and Windows Server 2008 operating systems, with a more relaxed[2] version also present in the versions after Vista, being Windows 7, Windows Server 2008 R2, Windows 8, Windows Server 2012, Windows 8.1, Windows Server 2012 R2, Windows 10, and Windows 11. It aims to improve the security of Microsoft Windows by limiting application software to standard [user privileges](https://en.wikipedia.org/wiki/Privilege_(computing)) until an administrator authorises an increase or elevation. In this way, only applications trusted by the user may receive administrative privileges and [malware](https://en.wikipedia.org/wiki/Malware) are kept from compromising the operating system. In other words, a user account may have [administrator privileges](https://en.wikipedia.org/wiki/System_administrator) assigned to it, but applications that the user runs do not inherit those privileges unless they are approved beforehand or the user explicitly authorises it.

### UAC process and interactions:
With UAC, each application that requires the administrator access token must prompt the end user for consent. The only exception is the relationship that exists between parent and child processes. Child processes inherit the user's access token from the parent process. Both the parent and child processes, however, must have the same integrity level.

Windows protects processes by marking their integrity levels. Integrity levels are measurements of trust:

* A high integrity application is one that performs tasks that modify system data, such as a disk partitioning application
* A low integrity application is one that performs tasks that could potentially compromise the operating system, like as a Web browser

Applications with lower integrity levels can't modify data in applications with higher integrity levels. When a standard user attempts to run an app that requires an administrator access token, UAC requires that the user provides valid administrator credentials.

To better understand how this process works, let's take a closer look at the Windows sign in process.

### Sign in process:
The following diagram shows how the sign in process for an administrator differs from the sign in process for a standard user.
By default, both standard and administrator users access resources and execute apps in the security context of a standard user.
When a user signs in, the system creates an access token for that user. The access token contains information about the level of access that the user is granted, including specific security identifiers (SIDs) and Windows privileges.

![uac-windows-logon-process](https://github.com/user-attachments/assets/6625eae8-458e-470b-9a5b-0a23e13fd008)

When an administrator logs on, two separate access tokens are created for the user: a standard user access token and an administrator access token. The standard user access token:

* Contains the same user-specific information as the administrator access token, but the administrative Windows privileges and SIDs are removed
* Is used to start applications that don't perform administrative tasks (standard user apps)
* Is used to display the desktop by executing the process explorer.exe. Explorer.exe is the parent process from which all other user-initiated processes inherit their access token. As a result, all apps run as a standard user unless a user provides consent or credentials to approve an app to use a full administrative access token.

A user that is a member of the Administrators group can sign in, browse the Web, and read e-mail while using a standard user access token. When the administrator needs to perform a task that requires the administrator access token, Windows automatically prompts the user for approval. This prompt is called an elevation prompt, and its behavior can be configured via policy or registry.

### Tasks that trigger a UAC prompt:
Tasks that require administrator privileges will trigger a UAC prompt (if UAC is enabled); they are typically marked by a security shield icon with the 4 colors of the Windows logo (in Vista and Windows Server 2008) or with two panels yellow and two blue (Windows 7, Windows Server 2008 R2 and later). In the case of executable files, the icon will have a security shield overlay. The following tasks require administrator privileges:

* Running an Application as an Administrator
* Changes to system-wide settings
* Changes to files in folders that standard users don't have permissions for (such as %SystemRoot% or %ProgramFiles% in most cases)
* Changes to an [access control list](https://en.wikipedia.org/wiki/Access-control_list) (ACL), commonly referred to as file or folder permissions
* Installing and uninstalling applications outside of:
    * The [%USERPROFILE%](https://en.wikipedia.org/wiki/Environment_variable#USERPROFILE) (e.g. C:\Users\{logged in user}) folder and its sub-folders.
      * Most of the time this is in %APPDATA%. (e.g. C:\Users\{logged in user}\AppData), by default, this is a [hidden folder](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#DOS_and_MS_Windows).
        * Chrome's and Firefox's installer ask for admin rights during install, if given, Chrome will install in the Program Files folder and be usable for all users, if     denied, Chrome will install in the %APPDATA% folder instead and only be usable by the current user.
* The [Microsoft Store](https://en.wikipedia.org/wiki/Microsoft_Store).
* The folder of the installer and its sub-folders.
  * [Steam](https://en.wikipedia.org/wiki/Steam_(service)) installs its games in the /steamapps/ sub-folder, thus not prompting UAC. Some games require prerequisites to be installed, which may prompt UAC.
* Installing device drivers
* Installing [ActiveX](https://en.wikipedia.org/wiki/ActiveX) controls
* Changing settings for [Windows Firewall](https://en.wikipedia.org/wiki/Windows_Firewall)
* Changing UAC settings
* Configuring [Windows Update](https://en.wikipedia.org/wiki/Windows_Update)
* Adding or removing user accounts
* Changing a user's account name or type
* Turning on Guest account (Windows 7 to 8.1)
* Turning on network discovery, file and printer sharing, Public folder sharing, turning off password protected sharing or turning on media streaming
* Configuring Parental Controls (in Windows 7) or Family Safety (Windows 8.1)
* Running [Task Scheduler](https://en.wikipedia.org/wiki/Windows_Task_Scheduler)
* Backing up and restoring folders and files
* Merging and deleting network locations
* Turning on or cleaning logging in Remote Access Preferences
* Running Color Calibration
* Changing remote, system protection or advanced system settings
* Restoring backed-up system files
* Viewing or changing another user's folders and files
* Running [Disk Defragmenter](https://en.wikipedia.org/wiki/Microsoft_Drive_Optimizer), [System Restore](https://en.wikipedia.org/wiki/System_Restore) or [Windows Easy Transfer](https://en.wikipedia.org/wiki/Windows_Easy_Transfer) (Windows 7 to 8.1)
* Running [Registry Editor](https://en.wikipedia.org/wiki/Windows_Registry#Manual_editing)
* Running the Windows Experience Index assessment
* Troubleshoot audio recording and playing, hardware / devices and power use
* Change power settings, turning off Windows features, uninstall, change or repair a program
* Change date and time and synchronizing with an Internet time server
* Installing and uninstalling display languages
* Change [Ease of Access](https://en.wikipedia.org/wiki/Ease_of_Access) administrative settings



