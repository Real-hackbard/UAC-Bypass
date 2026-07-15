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

| Mode | Description |
| :----------- | :----------- |
| off     | Never notify (Least secure): Disables all UAC prompts, allowing administrator-level changes without confirmation.     |
| quiet     | Notify me only when apps try to make changes (Do not dim my desktop): Same as above, but without switching to the secure desktop.     |
| on     | Fordert jedes Mal eine Zustimmung an, wenn Apps Software installieren oder Änderungen an Windows vornehmen.     |

* ```Administrator UAC```
* When an administrator account triggers the User Account Control (UAC) Admin Approval Mode, Windows silently strips administrative rights and runs the process as a standard user. If an app requests full system access, UAC halts execution and displays a prompt requiring the admin to explicitly approve the elevation of privileges.

| Überschrift 1 | Überschrift 2 |
| :-----------: | :-----------: |
| Zelle 1,1     | Zelle 1,2     |
| Zelle 2,1     | Zelle 2,2     |
