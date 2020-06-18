# Maîtrise de poste

## Host OS

Alors, connaisons nous la config de notre pc ? Bah oui mais la connaissons nous en ligne de commande ? Bah oui aussi :

```powershell
PS C:\Users\marsl> systeminfo

Nom de l’hôte:                              VINNY
Nom du système d’exploitation:              Microsoft Windows 10 Professionnel
Version du système:                         10.0.18363 N/A version 18363
Fabricant du système d’exploitation:        Microsoft Corporation
Configuration du système d’exploitation:    Station de travail autonome
Type de version du système d’exploitation:  Multiprocessor Free
Propriétaire enregistré:                    marsleouf@gmail.com
Organisation enregistrée:
Identificateur de produit:                  00330-80000-00000-AA300
Date d’installation originale:              01/05/2020, 17:26:55
Heure de démarrage du système:              12/06/2020, 23:00:26
Fabricant du système:                       Micro-Star International Co., Ltd.
Modèle du système:                          GE72 2QF
Type du système:                            x64-based PC
Processeur(s):                              1 processeur(s) installé(s).
                                            [01] : Intel64 Family 6 Model 60 Stepping 3 GenuineIntel ~2901 MHz
Version du BIOS:                            American Megatrends Inc. E1791IMS.10F, 09/08/2015
Répertoire Windows:                         C:\Windows
Répertoire système:                         C:\Windows\system32
Périphérique d’amorçage:                    \Device\HarddiskVolume2
Option régionale du système:                fr;Français (France)
Paramètres régionaux d’entrée:              fr;Français (France)
Fuseau horaire:                             (UTC+01:00) Bruxelles, Copenhague, Madrid, Paris
Mémoire physique totale:                    16 305 Mo
Mémoire physique disponible:                10 937 Mo
Mémoire virtuelle : taille maximale:        18 737 Mo
Mémoire virtuelle : disponible:             12 652 Mo
Mémoire virtuelle : en cours d’utilisation: 6 085 Mo
Emplacements des fichiers d’échange:        C:\pagefile.sys
Domaine:                                    WORKGROUP
Serveur d’ouverture de session:             \\VINNY
Correctif(s):                               10 Corrections installées.
                                            [01]: KB4552931
                                            [02]: KB4513661
                                            [03]: KB4516115
                                            [04]: KB4517245
                                            [05]: KB4528759
                                            [06]: KB4537759
                                            [07]: KB4552152
                                            [08]: KB4560959
                                            [09]: KB4561600
                                            [10]: KB4560960
Carte(s) réseau:                            6 carte(s) réseau installée(s).
                                            [01]: Intel(R) Dual Band Wireless-AC 3160
                                                  Nom de la connexion : Wi-Fi
                                                  État :                Support déconnecté
                                            [02]: Killer E2200 Gigabit Ethernet Controller
                                                  Nom de la connexion : Ethernet
                                                  DHCP activé :         Oui
                                                  Serveur DHCP :        192.168.1.1
                                                  Adresse(s) IP
                                                  [01]: 192.168.1.12
                                                  [02]: fe80::b585:d3c6:e729:3562
                                            [03]: Bluetooth Device (Personal Area Network)
                                                  Nom de la connexion : Connexion réseau Bluetooth
                                                  État :                Support déconnecté
                                            [04]: Microsoft KM-TEST Loopback Adapter
                                                  Nom de la connexion : Npcap Loopback Adapter
                                                  DHCP activé :         Oui
                                                  Serveur DHCP :        255.255.255.255
                                                  Adresse(s) IP
                                                  [01]: 169.254.140.252
                                                  [02]: fe80::9ccc:f58e:29d8:8cfc
                                            [05]: VirtualBox Host-Only Ethernet Adapter
                                                  Nom de la connexion : VirtualBox Host-Only Network
                                                  DHCP activé :         Non
                                                  Adresse(s) IP
                                                  [01]: 192.168.56.1
                                                  [02]: fe80::2d2c:fae6:95b7:8ce0
                                            [06]: VirtualBox Host-Only Ethernet Adapter
                                                  Nom de la connexion : VirtualBox Host-Only Network #2
                                                  DHCP activé :         Non
                                                  Adresse(s) IP
                                                  [01]: 10.2.1.1
                                                  [02]: fe80::a490:4aa4:2138:43a
Configuration requise pour Hyper-V:         Extensions de mode du moniteur d’ordinateur virtuel : Oui
                                            Virtualisation activée dans le microprogramme : Oui
                                            Traduction d’adresse de second niveau : Oui
                                            Prévention de l’exécution des données disponible : Oui
```
Tu peux aussi chopper la config de ton PC en GUI avec la commande `msinfo32`.

## Device

Quelle est la marque et le modèle du processeur ?

```powershell
PS C:\Users\marsl> wmic cpu get caption
Caption
Intel64 Family 6 Model 60 Stepping 3
```

Mmmmmmh... bonne référence.

Combien ai-je de processeur ?

```powershell
PS C:\Users\marsl> wmic cpu get NumberOfLogicalProcessors
NumberOfLogicalProcessors
4
```

Mmmmmmmmmmmmmmmmmh... de plus en plus intéressant dîtes donc...

Combien ai-je de coeurs ?

```powershell
PS C:\Users\marsl> wmic cpu get NumberOfCores
NumberOfCores
2
```

2 coeurs ? Mais que voilà un beau processeur de merde !

Qu'en est-il de mes partitions ?

```powershell
PS C:\Users\marsl> wmic partition
Access  Availability  BlockSize  Bootable  BootPartition  Caption                      ConfigManagerErrorCode  ConfigManagerUserConfig  CreationClassName    Description                      DeviceID               DiskIndex  ErrorCleared  ErrorDescription  ErrorMethodology  HiddenSectors  Index  InstallDate  LastErrorCode  Name                         NumberOfBlocks  PNPDeviceID  PowerManagementCapabilities  PowerManagementSupported  PrimaryPartition  Purpose  RewritePartition  Size          StartingOffset  Status  StatusInfo  SystemCreationClassName  SystemName  Type
                      512        TRUE      TRUE           Disque n° 0, partition n° 0                                                   Win32_DiskPartition  Système de fichiers installable  Disk #0, Partition #0  0                                                                           0                                  Disque n° 0, partition n° 0  488390656                                                                           TRUE                                         250056015872  1048576                             Win32_ComputerSystem     VINNY       Installable File System
                      512        TRUE      TRUE           Disque n° 1, partition n° 0                                                   Win32_DiskPartition  Système de fichiers installable  Disk #1, Partition #0  1                                                                           0                                  Disque n° 1, partition n° 0  204800                                                                              TRUE                                         104857600     1048576                             Win32_ComputerSystem     VINNY       Installable File System
                      512        FALSE     FALSE          Disque n° 1, partition n° 1                                                   Win32_DiskPartition  Système de fichiers installable  Disk #1, Partition #1  1                                                                           1                                  Disque n° 1, partition n° 1  1932343296                                                                          TRUE                                         989359767552  105906176                           Win32_ComputerSystem     VINNY       Installable File System
                      512        FALSE     FALSE          Disque n° 1, partition n° 2                                                   Win32_DiskPartition  Système de fichiers installable  Disk #1, Partition #2  1                                                                           2                                  Disque n° 1, partition n° 2  20971520                                                                            TRUE                                         10737418240   989467467776                        Win32_ComputerSystem     VINNY       Installable File System
```

Oui.

## Network

Le classique ipconfig (qui te donner le grade de hacker du collège quand tu l'éxécutait sur un cmd fond noir `color 0a`):

```powershell
PS C:\Users\marsl> ipconfig

Configuration IP de Windows


Carte Ethernet Npcap Loopback Adapter :

   Suffixe DNS propre à la connexion. . . :
   Adresse IPv6 de liaison locale. . . . .: fe80::9ccc:f58e:29d8:8cfc%20
   Adresse d’autoconfiguration IPv4 . . . : 169.254.140.252
   Masque de sous-réseau. . . . . . . . . : 255.255.0.0
   Passerelle par défaut. . . . . . . . . :

Carte Ethernet VirtualBox Host-Only Network :

   Suffixe DNS propre à la connexion. . . :
   Adresse IPv6 de liaison locale. . . . .: fe80::2d2c:fae6:95b7:8ce0%3
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.56.1
   Masque de sous-réseau. . . . . . . . . : 255.255.255.0
   Passerelle par défaut. . . . . . . . . :

Carte Ethernet VirtualBox Host-Only Network #2 :

   Suffixe DNS propre à la connexion. . . :
   Adresse IPv6 de liaison locale. . . . .: fe80::a490:4aa4:2138:43a%12
   Adresse IPv4. . . . . . . . . . . . . .: 10.2.1.1
   Masque de sous-réseau. . . . . . . . . : 255.255.255.0
   Passerelle par défaut. . . . . . . . . :

Carte réseau sans fil Connexion au réseau local* 1 :

   Statut du média. . . . . . . . . . . . : Média déconnecté
   Suffixe DNS propre à la connexion. . . :

Carte réseau sans fil Connexion au réseau local* 10 :

   Statut du média. . . . . . . . . . . . : Média déconnecté
   Suffixe DNS propre à la connexion. . . :

Carte Ethernet Ethernet :

   Suffixe DNS propre à la connexion. . . : home
   Adresse IPv6 de liaison locale. . . . .: fe80::b585:d3c6:e729:3562%9
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.1.12
   Masque de sous-réseau. . . . . . . . . : 255.255.255.0
   Passerelle par défaut. . . . . . . . . : 192.168.1.1

Carte réseau sans fil Wi-Fi :

   Statut du média. . . . . . . . . . . . : Média déconnecté
   Suffixe DNS propre à la connexion. . . :

Carte Ethernet Connexion réseau Bluetooth :

   Statut du média. . . . . . . . . . . . : Média déconnecté
   Suffixe DNS propre à la connexion. . . :
```

Y'a des cartes pour les VM et les cartes narmols : cartes ethernet, réseau sans fil, sans fil connexion au réseau local (pour partage de co celle là).

Tu vois quelque chose Jack ? (t'as la ref ? (si tu l'as pas je te laisse aller cherhcer dan le TP 2 Léal. (ça parle du sujet de la prochaine commande (tu me déçois (mais genre vraiment (mais genre vraiment beaucoup)))))):

```powershell
PS C:\Users\marsl> netstat -n

Connexions actives

  Proto  Adresse locale         Adresse distante       État
  TCP    127.0.0.1:50382        127.0.0.1:65001        ESTABLISHED
  TCP    127.0.0.1:65001        127.0.0.1:50382        ESTABLISHED
  TCP    192.168.1.12:50388     40.67.254.36:443       ESTABLISHED
  TCP    192.168.1.12:50401     162.159.136.234:443    ESTABLISHED
  TCP    192.168.1.12:50540     52.210.165.47:443      ESTABLISHED
  TCP    192.168.1.12:50558     34.204.122.36:443      ESTABLISHED
  TCP    192.168.1.12:50585     173.194.76.188:5228    ESTABLISHED
  TCP    192.168.1.12:50598     5.62.53.18:80          ESTABLISHED
  TCP    192.168.1.12:50621     5.45.62.116:80         ESTABLISHED
  TCP    192.168.1.12:50712     140.82.114.25:443      ESTABLISHED
  TCP    192.168.1.12:50724     140.82.114.25:443      ESTABLISHED
  TCP    192.168.1.12:50734     140.82.112.26:443      ESTABLISHED
  TCP    192.168.1.12:50743     152.199.19.161:443     CLOSE_WAIT
  TCP    192.168.1.12:50752     152.199.19.161:443     CLOSE_WAIT
  TCP    192.168.1.12:50811     52.157.234.37:443      ESTABLISHED
  TCP    192.168.1.12:50820     77.234.45.233:80       TIME_WAIT
```

![](./images/longue.jpg)
(c'est bon tu l'as cette fois ?)

## Users

Je me demande bien qui contrôle mon Personnal Computer :

```powershell
PS C:\Users\marsl> net users

comptes d’utilisateurs de \\VINNY

-------------------------------------------------------------------------------
Administrateur           DefaultAccount           Invité
marsl                    WDAGUtilityAccount
La commande s’est terminée correctement.
```

![](./images/lama.png)

Je suis le seul et unique pocesseur/user de mon pc nyéhéhéhéhéhé, personne ne m'espionne NYAHAHAHAHAHAHAHAHHAHAHAHA.

**MEANWHILE AT GOOGLE**

![](./images/windu.jpg)

## Processus

```powershell
PS C:\Users\marsl> tasklist

Nom de l’image                 PID Nom de la sessio Numéro de s Utilisation
========================= ======== ================ =========== ============
System Idle Process              0 Services                   0         8 Ko
System                           4 Services                   0     7 896 Ko
Registry                        96 Services                   0    70 884 Ko
smss.exe                       420 Services                   0     1 124 Ko
csrss.exe                      576 Services                   0     6 136 Ko
wininit.exe                    704 Services                   0     7 156 Ko
services.exe                   776 Services                   0    11 016 Ko
lsass.exe                      784 Services                   0    21 844 Ko
svchost.exe                    916 Services                   0     3 756 Ko
svchost.exe                    940 Services                   0    35 328 Ko
fontdrvhost.exe                960 Services                   0     3 468 Ko
WUDFHost.exe                   980 Services                   0     5 876 Ko
svchost.exe                    600 Services                   0    19 208 Ko
svchost.exe                    772 Services                   0     8 780 Ko
svchost.exe                   1396 Services                   0     6 084 Ko
svchost.exe                   1432 Services                   0    10 460 Ko
svchost.exe                   1440 Services                   0    11 088 Ko
svchost.exe                   1456 Services                   0    19 948 Ko
svchost.exe                   1472 Services                   0    16 100 Ko
svchost.exe                   1556 Services                   0    12 828 Ko
svchost.exe                   1600 Services                   0     8 644 Ko
svchost.exe                   1696 Services                   0    10 328 Ko
svchost.exe                   1736 Services                   0     5 924 Ko
svchost.exe                   1764 Services                   0     7 640 Ko
svchost.exe                   1808 Services                   0     6 916 Ko
svchost.exe                   1820 Services                   0    10 164 Ko
svchost.exe                   1888 Services                   0    11 952 Ko
svchost.exe                   1924 Services                   0     7 872 Ko
svchost.exe                   2012 Services                   0     8 240 Ko
igfxCUIService.exe            2060 Services                   0    12 848 Ko
svchost.exe                   2128 Services                   0    11 044 Ko
svchost.exe                   2144 Services                   0    16 664 Ko
svchost.exe                   2172 Services                   0    13 300 Ko
svchost.exe                   2204 Services                   0     9 012 Ko
svchost.exe                   2396 Services                   0    25 268 Ko
NVDisplay.Container.exe       2460 Services                   0    18 388 Ko
wsc_proxy.exe                 2536 Services                   0    10 780 Ko
svchost.exe                   2552 Services                   0     9 700 Ko
svchost.exe                   2560 Services                   0    13 272 Ko
svchost.exe                   2572 Services                   0     5 560 Ko
Memory Compression            2652 Services                   0    33 772 Ko
svchost.exe                   2744 Services                   0     8 528 Ko
svchost.exe                   2752 Services                   0     7 220 Ko
svchost.exe                   2784 Services                   0     7 364 Ko
svchost.exe                   3144 Services                   0    16 144 Ko
PresentationFontCache.exe     3208 Services                   0    18 772 Ko
svchost.exe                   3316 Services                   0    16 456 Ko
svchost.exe                   3324 Services                   0     6 532 Ko
svchost.exe                   3360 Services                   0     9 780 Ko
svchost.exe                   3692 Services                   0     7 628 Ko
svchost.exe                   4008 Services                   0    20 124 Ko
AVGSvc.exe                    4116 Services                   0   229 508 Ko
svchost.exe                   4144 Services                   0    14 148 Ko
wlanext.exe                   4256 Services                   0    17 460 Ko
conhost.exe                   4272 Services                   0    10 272 Ko
spoolsv.exe                   4588 Services                   0    14 716 Ko
svchost.exe                   4712 Services                   0    24 680 Ko
svchost.exe                   4868 Services                   0     7 908 Ko
svchost.exe                   4952 Services                   0    21 780 Ko
svchost.exe                   5056 Services                   0     8 544 Ko
svchost.exe                   5500 Services                   0    10 088 Ko
aswidsagent.exe               5908 Services                   0    68 440 Ko
WmiPrvSE.exe                  6020 Services                   0    13 744 Ko
svchost.exe                   6196 Services                   0     8 620 Ko
AdobeUpdateService.exe        6224 Services                   0    12 616 Ko
AGMService.exe                6236 Services                   0    13 456 Ko
AGSService.exe                6256 Services                   0    16 684 Ko
svchost.exe                   6300 Services                   0    59 620 Ko
svchost.exe                   6352 Services                   0    38 192 Ko
svchost.exe                   6388 Services                   0    29 652 Ko
EvtEng.exe                    6416 Services                   0    17 664 Ko
ibtsiva.exe                   6424 Services                   0     5 304 Ko
svchost.exe                   6436 Services                   0     7 684 Ko
svchost.exe                   6456 Services                   0    16 052 Ko
MSIService.exe                6536 Services                   0    12 228 Ko
MsiTrueColorService.exe       6556 Services                   0     4 728 Ko
pservice.exe                  6564 Services                   0     5 912 Ko
nvcontainer.exe               6572 Services                   0    40 648 Ko
KillerAnalyticsService.ex     6584 Services                   0    12 964 Ko
PnkBstrA.exe                  6660 Services                   0     6 544 Ko
svchost.exe                   6684 Services                   0     6 336 Ko
RegSrvc.exe                   6704 Services                   0     9 300 Ko
svchost.exe                   6728 Services                   0     7 908 Ko
svchost.exe                   6772 Services                   0     5 392 Ko
SynTPEnhService.exe           6780 Services                   0     8 560 Ko
svchost.exe                   6788 Services                   0    21 612 Ko
svchost.exe                   6816 Services                   0     7 784 Ko
ZeroConfigService.exe         6840 Services                   0    20 052 Ko
svchost.exe                   7100 Services                   0     6 084 Ko
svchost.exe                   7132 Services                   0     7 048 Ko
unsecapp.exe                  7372 Services                   0    11 176 Ko
svchost.exe                   7440 Services                   0    12 740 Ko
WmiPrvSE.exe                  7708 Services                   0    21 416 Ko
xTendSoftAPService.exe        7936 Services                   0    17 456 Ko
xTendUtilityService.exe       7956 Services                   0    17 440 Ko
svchost.exe                   8044 Services                   0     8 792 Ko
xTendSoftAP.exe               7120 Services                   0     5 924 Ko
xTendUtility.exe              4604 Services                   0     5 096 Ko
conhost.exe                   2052 Services                   0    12 428 Ko
conhost.exe                   8100 Services                   0    12 420 Ko
svchost.exe                   8616 Services                   0    10 204 Ko
svchost.exe                  10028 Services                   0    11 640 Ko
svchost.exe                  10324 Services                   0    12 884 Ko
dllhost.exe                  10528 Services                   0    10 344 Ko
SecurityHealthService.exe    10912 Services                   0    15 824 Ko
svchost.exe                  11292 Services                   0     8 960 Ko
AVGBrowserCrashHandler.ex    11664 Services                   0     1 120 Ko
GoogleCrashHandler.exe       11692 Services                   0     1 144 Ko
GoogleCrashHandler64.exe     11712 Services                   0     1 080 Ko
AVGBrowserCrashHandler64.    11720 Services                   0     1 080 Ko
svchost.exe                   3564 Services                   0    20 512 Ko
svchost.exe                   5852 Services                   0    14 376 Ko
svchost.exe                  11744 Services                   0     5 516 Ko
svchost.exe                  10128 Services                   0    12 088 Ko
svchost.exe                   9624 Services                   0    17 508 Ko
svchost.exe                   9188 Services                   0    12 152 Ko
IAStorDataMgrSvc.exe          1656 Services                   0    56 452 Ko
jhi_service.exe               6216 Services                   0     6 376 Ko
LMS.exe                       6528 Services                   0    12 412 Ko
SgrmBroker.exe                6596 Services                   0     6 480 Ko
svchost.exe                  12360 Services                   0    17 000 Ko
svchost.exe                  10864 Services                   0     8 960 Ko
svchost.exe                   4532 Services                   0    11 980 Ko
svchost.exe                   7280 Services                   0    10 028 Ko
isa.exe                       8292 Services                   0    21 484 Ko
svchost.exe                  10708 Services                   0     9 904 Ko
OfficeClickToRun.exe          3708 Services                   0    76 964 Ko
AppVShNotify.exe               392 Services                   0     8 072 Ko
SearchIndexer.exe            13260 Services                   0    50 744 Ko
svchost.exe                  14488 Services                   0     8 088 Ko
csrss.exe                     9440 Console                    3     6 264 Ko
winlogon.exe                 13696 Console                    3    10 200 Ko
fontdrvhost.exe              16680 Console                    3    11 560 Ko
dwm.exe                      10400 Console                    3   104 660 Ko
NVDisplay.Container.exe      14716 Console                    3    39 856 Ko
SynTPEnh.exe                  9760 Console                    3    54 292 Ko
nvcontainer.exe              13172 Console                    3    74 264 Ko
sihost.exe                     908 Console                    3    29 096 Ko
svchost.exe                   8488 Console                    3    28 112 Ko
svchost.exe                  14044 Console                    3    36 652 Ko
taskhostw.exe                11792 Console                    3    19 964 Ko
SynTPHelper.exe              13392 Console                    3     4 868 Ko
igfxEM.exe                    8628 Console                    3    13 152 Ko
igfxHK.exe                   12184 Console                    3     9 456 Ko
igfxTray.exe                  4924 Console                    3    11 744 Ko
unsecapp.exe                 14460 Console                    3    12 296 Ko
explorer.exe                  2992 Console                    3   167 472 Ko
svchost.exe                   2368 Console                    3    23 224 Ko
StartMenuExperienceHost.e    11844 Console                    3    87 744 Ko
ctfmon.exe                   14836 Console                    3    17 644 Ko
RuntimeBroker.exe            11888 Console                    3    25 848 Ko
SearchUI.exe                 12036 Console                    3   219 128 Ko
RuntimeBroker.exe             7384 Console                    3    43 204 Ko
SettingSyncHost.exe           4644 Console                    3     8 212 Ko
LockApp.exe                  10504 Console                    3    59 756 Ko
RuntimeBroker.exe             5924 Console                    3    32 548 Ko
NVIDIA Web Helper.exe         4752 Console                    3     4 016 Ko
conhost.exe                  13796 Console                    3     1 224 Ko
Dragon Gaming Center.exe     16516 Console                    3    52 928 Ko
SecurityHealthSystray.exe     7256 Console                    3     8 876 Ko
RtkNGUI64.exe                12240 Console                    3    20 864 Ko
Nahimic2UILauncher.exe        8868 Console                    3     1 528 Ko
SCM.exe                       8564 Console                    3    80 680 Ko
Nahimic2Svc32.exe            17284 Console                    3     3 580 Ko
Nahimic2Svc64.exe             1156 Console                    3     1 952 Ko
AVGUI.exe                     4476 Console                    3    67 752 Ko
SteelSeriesEngine3.exe       13092 Console                    3    62 400 Ko
ShellExperienceHost.exe       9196 Console                    3    81 508 Ko
RuntimeBroker.exe             1796 Console                    3    30 916 Ko
SystemSettingsBroker.exe     11260 Console                    3    31 824 Ko
ApplicationFrameHost.exe      4792 Console                    3    42 016 Ko
dllhost.exe                  13620 Console                    3    15 280 Ko
RuntimeBroker.exe             6748 Console                    3    20 720 Ko
IAStorIcon.exe                4892 Console                    3    39 160 Ko
WinStore.App.exe             15484 Console                    3       280 Ko
RuntimeBroker.exe             1076 Console                    3    15 496 Ko
svchost.exe                  15660 Console                    3    12 892 Ko
AVGUI.exe                    12396 Console                    3    32 928 Ko
xampp-control.exe            16428 Console                    3    21 480 Ko
WindowsInternal.Composabl     3032 Console                    3    58 004 Ko
YourPhone.exe                  328 Console                    3    48 624 Ko
RuntimeBroker.exe             2264 Console                    3    15 988 Ko
Discord.exe                   7140 Console                    3    85 120 Ko
Discord.exe                   7976 Console                    3   100 048 Ko
Discord.exe                  10804 Console                    3    25 876 Ko
Discord.exe                  11548 Console                    3    16 164 Ko
Discord.exe                   3944 Console                    3   229 720 Ko
Discord.exe                  11000 Console                    3    19 188 Ko
rundll32.exe                  7500 Console                    3    10 644 Ko
AdobeIPCBroker.exe            6088 Console                    3    14 304 Ko
Adobe Desktop Service.exe    14272 Console                    3   200 820 Ko
CoreSync.exe                  4352 Console                    3    42 216 Ko
AdobeNotificationClient.e    15572 Console                    3     1 084 Ko
CCLibrary.exe                 3784 Console                    3     2 484 Ko
node.exe                      2216 Console                    3    77 460 Ko
conhost.exe                   2020 Console                    3    11 060 Ko
RuntimeBroker.exe              728 Console                    3     6 524 Ko
Adobe Installer.exe           6248 Console                    3    12 876 Ko
CCXProcess.exe                3140 Console                    3     2 404 Ko
node.exe                     16340 Console                    3    67 800 Ko
conhost.exe                  13116 Console                    3    11 064 Ko
Video.UI.exe                 15544 Console                    3       596 Ko
RuntimeBroker.exe            11164 Console                    3    10 460 Ko
svchost.exe                  16580 Services                   0    10 744 Ko
svchost.exe                  17120 Console                    3    10 792 Ko
Microsoft.Photos.exe          2384 Console                    3    86 772 Ko
RuntimeBroker.exe            17740 Console                    3    33 712 Ko
svchost.exe                  12008 Services                   0     7 284 Ko
svchost.exe                   8184 Services                   0    10 012 Ko
dasHost.exe                  13060 Services                   0    12 076 Ko
Music.UI.exe                  7276 Console                    3     2 664 Ko
SystemSettings.exe            7412 Console                    3       264 Ko
smartscreen.exe              15336 Console                    3    28 500 Ko
RuntimeBroker.exe             4428 Console                    3    17 992 Ko
MicrosoftEdge.exe            17192 Console                    3    70 464 Ko
browser_broker.exe           14684 Console                    3    14 552 Ko
MicrosoftEdgeSH.exe          15796 Console                    3    15 988 Ko
MicrosoftEdgeCP.exe           8372 Console                    3   158 560 Ko
xampp-control.exe            10180 Console                    3    22 148 Ko
chrome.exe                    9024 Console                    3   186 748 Ko
chrome.exe                   15496 Console                    3    10 512 Ko
chrome.exe                    3612 Console                    3    80 616 Ko
chrome.exe                   14712 Console                    3    34 764 Ko
chrome.exe                    4628 Console                    3   107 432 Ko
chrome.exe                   16068 Console                    3   122 452 Ko
chrome.exe                   10472 Console                    3    82 696 Ko
svchost.exe                   2320 Services                   0     5 988 Ko
chrome.exe                   13360 Console                    3    85 148 Ko
chrome.exe                     580 Console                    3    93 040 Ko
chrome.exe                   10636 Console                    3    22 928 Ko
powershell.exe                1712 Console                    3    78 928 Ko
conhost.exe                  16276 Console                    3    17 612 Ko
Code.exe                      1244 Console                    3    95 616 Ko
Code.exe                      9780 Console                    3   221 636 Ko
Code.exe                     11960 Console                    3    26 096 Ko
Code.exe                     18676 Console                    3    16 764 Ko
Code.exe                      2312 Console                    3    72 284 Ko
Code.exe                     14516 Console                    3    42 388 Ko
Code.exe                      4496 Console                    3   206 352 Ko
Code.exe                      5928 Console                    3    72 336 Ko
conhost.exe                   2960 Console                    3     8 392 Ko
bash.exe                     13880 Console                    3     5 508 Ko
bash.exe                     19132 Console                    3    10 172 Ko
CodeHelper.exe               19036 Console                    3    14 640 Ko
conhost.exe                   5892 Console                    3    11 364 Ko
tasklist.exe                  7172 Console                    3    12 204 Ko
tu_pues_des_bras.exe           666 Console                    7    69 420 Ko
```

![](./images/burgond.jpg)

...

......

.........

............

OH OUI, OH OUI, OH TU SAIS CE QUE CA VEUT DIRE !

C'EST L'HEURE DE-DE-DE-DE-DE-DE-DE

![](./images/transition.png)

![](./images/gonagall2.jpg)