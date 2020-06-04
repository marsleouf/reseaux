# Compte Rendu TP : Faisons joujou
## I.Exploration locale en solo
### 1.Affichage d'informations sur la pile TCP/IP locale

R�sultat obtenu pour les premi�res questions avec la commande ipconfig /all. J'ai pas de copy/paste sous la main.
Mes plates excuses.

Carte r�seau sans fil Connexion r�seau sans fil; adresse MAC : B4-6D-83-D2-D4-80
Carte Ethernet Connexion au r�seau local; adresse MAC : 0A-00-27-00-00-19
adresse gateway : 10.33.3.253


Graphical User Interface :
- IP : 10.33.3.148
- MAC : B4-6D-83-D2-D4-80
- Gateway : 10.33.3.253

Question bonus:
Le gateway d'Ynov permet de relier le r�seau locl d'ynov au r�seau internet.

### 2.Modifications des informations
#### A.Modification d'adresse IP (part 1)

Bon... je suis sous windows 7 ce qui veut dire "emmerdes sur emmerdes" donc j'ai eu quelque probl�mes avec ma carte wifi (pas de sauvegarde des param�tres d'Ip modifi�) sauf que apr�s un bon reboot du pc et �tre rentr�
dans le jeu de windows (soit recommencer l'op�ration plusieurs fois) ca marche va savoir pourquoi.
Bref, aucun probl�me de connexion rencontr�, on fait un ping du r�seau ynov, �a marche.
go continuer.
(j'ai pas de copier coller des commandes me tape pas stp, trust me anakin)

#### B.nmap

On installe nmap et tout se passe comme pr�vu sans aucun probl�me.
Apr�s avoir scann� le r�seau ynov avec la commande nmap ```nmap.exe -sP 10.33.0.0/22```, on se rend compte que le r�seau a beaucoup d'Ip libre. Let's go s'en approprier un.

Puis j'ai d�cid� de me mettre sur l'Ip 10.33.3.250 parce qu'elle �tait libre. On a :
```
Carte r�seau sans fil Connexion r�seau sans fil�:

   Suffixe DNS propre � la connexion. . . :
   Description. . . . . . . . . . . . . . : Intel(R) Dual Band Wireless-AC 3160
   Adresse physique . . . . . . . . . . . : B4-6D-83-D2-D4-80
   DHCP activ�. . . . . . . . . . . . . . : Non
   Configuration automatique activ�e. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::7199:3cab:9d69:5a73%14(pr�f�r�)
   Adresse IPv4. . . . . . . . . . . . . .: 10.33.3.250(pr�f�r�)
   Masque de sous-r�seau. . . .�. . . . . : 255.255.252.0
   Passerelle par d�faut. . . .�. . . . . : 10.33.3.253
   IAID DHCPv6 . . . . . . . . . . . : 380923267
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activ�
```
Menfin, tout �a c'est beau mais maintenant on va voir si avec toutes ces modifications on arrive � se connecter � internet.
Voici le protocole suivant :
```
PS C:\Users\Marius> nslookup google.com
Serveur :   dns.google
Address:  8.8.8.8

R�ponse ne faisant pas autorit� :
Nom :    google.com
Addresses:  2a00:1450:4007:809::200e
          216.58.204.110
```
Le pc � r�ussis � joindre google.com avec son Ip modifi�, en deux mots : "IT WORKS!!!". Et si je dis pas de b�tises, cette commande conclut la partie C.Modification d'adresse Ip (part2)

## II.Exploration locale en duo
### 3.Modification d'adresse Ip

Bon, cette partie je l'ai faite avec un ami chez lui. On a fait avec les moyens du bord et on s'est plut�t pas mal d�brouill�.
Pour commencer, la modification d'adresse Ip, �a nous donne ceci
```
Carte Ethernet Connexion au r�seau local :

   Suffixe DNS propre � la connexion. . . :
   Description. . . . . . . . . . . . . . : Killer e2200 Gigabit Ethernet Controller
   Adresse physique . . . . . . . . . . . : D8-CB-8A-82-94-30
   DHCP activ�. . . . . . . . . . . . . . : Non
   Configuration automatique activ�e. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::185e:347b:da51:bcf8%13(pr�f�r�)
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.27.2(pr�f�r�)
   Masque de sous-r�seau. . . .�. . . . . : 255.255.255.252
   Passerelle par d�faut. . . .�. . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 299420554
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activ�
```
Mon adresse Ip a �t� modifi� en 192.168.27.2 (la .1 �tait utilis� par Tony (l'ami d�panneur)).
On a tent� de suivre les consignes du tp � savoir se mettre en /30, donc mettre un masque de sous-r�seau � 255.255.255.252 et on a eu des gros probl�mes pour se ping.
```
PS C:\Users\Marius> ping 192.168.27.1

Envoi d'une requ�te 'Ping'  192.168.27.1 avec 32 octets de donn�es�:
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
```
Apr�s plusieurs tentatives en vain, on a jou� la solution de facilit� : on s'est mis en 255.255.255.0 (soit en /24).
Et l�, miracle :
```
PS C:\Users\Marius> ping 192.168.27.1

Envoi d'une requ�te 'Ping'  192.168.27.1 avec 32 octets de donn�es�:
R�ponse de 192.168.27.1�: octets=32 temps=2 ms TTL=128
R�ponse de 192.168.27.1�: octets=32 temps=1 ms TTL=128
R�ponse de 192.168.27.1�: octets=32 temps=1 ms TTL=128
R�ponse de 192.168.27.1�: octets=32 temps=1 ms TTL=128

Statistiques Ping pour 192.168.27.1:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
Dur�e approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 2ms, Moyenne = 1ms
```
### 4.Utilisation d'un des deux comme gateway
Bon, c'est l� que �a se g�te.
Pour commencer, on se met en 192.168.1.29 pour concorder les Ip de nos �quipements avec la livebox de Tony.
Mais apr�s de nombreux essai � modifer les Ip de chaque �quipement, aucun succ�s ne se pr�sente quand il faut faire communiquer l'ordinateur 1 � internet via l'ordinateur 2 en tant que passerrelle r�seau.

Voici un d�tail des diff�rentes erreurs rencontr�e:
```
PS C:\Users\Marius> ping 192.168.2.1

Envoi d'une requ�te 'Ping'  192.168.2.1 avec 32 octets de donn�es�:
PING�: �chec de la transmission. D�faillance g�n�rale.
PING�: �chec de la transmission. D�faillance g�n�rale.
PING�: �chec de la transmission. D�faillance g�n�rale.
PING�: �chec de la transmission. D�faillance g�n�rale.

Statistiques Ping pour 192.168.2.1:
    Paquets�: envoy�s = 4, re�us = 0, perdus = 4 (perte 100%),
```
```
PS C:\Users\Marius> ping 192.168.27.1

Envoi d'une requ�te 'Ping'  192.168.27.1 avec 32 octets de donn�es�:
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.27.2�: Impossible de joindre l'h�te de destination.

Statistiques Ping pour 192.168.27.1:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
```
On a cherch� de notre c�t� pour r�soudre ces probl�mes, mais bof bof... On va passer � l'�tape suivante. 
L�, c'est la partie o� tout est parti en sucette. Le reste du compte-rendu parlera de lui m�me.
Bref, on suit toujours la trame du TP:
```
Carte Ethernet Connexion au r�seau local :

   Suffixe DNS propre � la connexion. . . :
   Description. . . . . . . . . . . . . . : Killer e2200 Gigabit Ethernet Controller
   Adresse physique . . . . . . . . . . . : D8-CB-8A-82-94-30
   DHCP activ�. . . . . . . . . . . . . . : Non
   Configuration automatique activ�e. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::185e:347b:da51:bcf8%13(pr�f�r�)
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.27.2(pr�f�r�)
   Masque de sous-r�seau. . . .�. . . . . : 255.255.255.0
   Passerelle par d�faut. . . .�. . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 299420554
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activ�
```
```
Carte Ethernet Connexion au r�seau local :

   Suffixe DNS propre � la connexion. . . :
   Description. . . . . . . . . . . . . . : Killer e2200 Gigabit Ethernet Controller
   Adresse physique . . . . . . . . . . . : D8-CB-8A-82-94-30
   DHCP activ�. . . . . . . . . . . . . . : Non
   Configuration automatique activ�e. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::185e:347b:da51:bcf8%13(pr�f�r�)
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.1.2(pr�f�r�)
   Masque de sous-r�seau. . . .�. . . . . : 255.255.255.0
   Passerelle par d�faut. . . .�. . . . . : 192.168.1.29
   IAID DHCPv6 . . . . . . . . . . . : 299420554
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activ�
```
```
PS C:\Users\Marius> ping 192.168.1.29

Envoi d'une requ�te 'Ping'  192.168.1.29 avec 32 octets de donn�es�:
D�lai d'attente de la demande d�pass�.
R�ponse de 192.168.1.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.1.2�: Impossible de joindre l'h�te de destination.
D�lai d'attente de la demande d�pass�.

Statistiques Ping pour 192.168.1.29:
    Paquets�: envoy�s = 4, re�us = 2, perdus = 2 (perte 50%),
```
Tout ne se passe pas comme pr�vu, mais on continue, sait-on jamais ?
```
PS C:\Users\Marius> nslookup 8.8.8.8
DNS request timed out.
    timeout was 2 seconds.
Serveur :   UnKnown
Address:  fe80::a63e:51ff:fe78:9c6

DNS request timed out.
    timeout was 2 seconds.
*** Le d�lai de la requ�te sur UnKnown est d�pass�.
```
Apr�s m'�tre rendu compte de quelques petites erreurs concernant les Ip, je me retrouve avec ceci:
```
PS C:\Users\Marius> ping 192.168.1.29

Envoi d'une requ�te 'Ping'  192.168.1.29 avec 32 octets de donn�es�:
R�ponse de 192.168.1.29�: octets=32 temps=1 ms TTL=128
R�ponse de 192.168.1.29�: octets=32 temps=1 ms TTL=128
R�ponse de 192.168.1.29�: octets=32 temps=1 ms TTL=128
R�ponse de 192.168.1.29�: octets=32 temps=1 ms TTL=128

Statistiques Ping pour 192.168.1.29:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
Dur�e approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 1ms, Moyenne = 1ms
```
On a r�ussis a faire ping les pc entre eux, maintenant il faut que mon pc puisse "joindre" sa carte wifi pour r�cup�rer de l'internet.
``` 
PS C:\Users\Marius> ping 192.168.1.18

Envoi d'une requ�te 'Ping'  192.168.1.18 avec 32 octets de donn�es�:
R�ponse de 192.168.1.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.1.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.1.2�: Impossible de joindre l'h�te de destination.
R�ponse de 192.168.1.2�: Impossible de joindre l'h�te de destination.

Statistiques Ping pour 192.168.1.18:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
```
Cela annonce la couleur de la suite du Tp.
```
PS C:\Users\Marius> tracert 8.8.8.8

D�termination de l'itin�raire vers 8.8.8.8 avec un maximum de 30 sauts.

  1  Erreur de transmission�: code 1231

Itin�raire d�termin�.
```
A partir de l�, plus rien ne fonctionne...
```
PS C:\Users\Marius> nslookup 8.8.8.8
DNS request timed out.
    timeout was 2 seconds.
Serveur :   UnKnown
Address:  fe80::a63e:51ff:fe78:9c6

DNS request timed out.
    timeout was 2 seconds.
*** Le d�lai de la requ�te sur UnKnown est d�pass�.
```
### 5.Petit chat priv�
Cette partie l�, j'ai essay� de la faire chez moi. Donc j'utilise un nouveau pc, un vieux asus 700 jsplus quoi, bref : on cr�� le r�seau, on se ping et bim ca marche :
```
PS C:\Users\Marius> ping 192.168.1.1

Envoi d'une requ�te 'Ping'  192.168.1.1 avec 32 octets de donn�es�:
R�ponse de 192.168.1.1�: octets=32 temps<1ms TTL=128
R�ponse de 192.168.1.1�: octets=32 temps<1ms TTL=128
R�ponse de 192.168.1.1�: octets=32 temps<1ms TTL=128
R�ponse de 192.168.1.1�: octets=32 temps<1ms TTL=128

Statistiques Ping pour 192.168.1.1:
    Paquets�: envoy�s = 4, re�us = 4, perdus = 0 (perte 0%),
Dur�e approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
```
P.S : je suis le client et l'autre pc est le serveur.

Puis je pensais que l'�re des probl�mes sans solutions �tait finie. QUE NENNI! Netcat est arriv�. Je t�l�charge netcat sur le lien que tu nous a donn�.
Ensuite je le d�zip dans mon disque L:, puis j'�x�cute les commandes demand�.
```
PS C:\Users\Marius> nc.exe -1 -p 8888
Le terme ��nc.exe�� n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script ou programme ex�cu
le. V�rifiez l'orthographe du nom, ou si un chemin d'acc�s existe, v�rifiez que le chemin d'acc�s est correct et r�e
yez.
Au niveau de ligne�: 1 Caract�re�: 7
+ nc.exe <<<<  -1 -p 8888
    + CategoryInfo          : ObjectNotFound: (nc.exe:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```
Je d�cide d'aller dans le disque L: pour �x�cuter la commande netcat:
```
PS C:\Users\Marius> cd L:
PS L:\> cd netcat
PS L:\netcat> nc
Le terme ��nc�� n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script ou programme ex�cutabl
V�rifiez l'orthographe du nom, ou si un chemin d'acc�s existe, v�rifiez que le chemin d'acc�s est correct et r�essay
Au niveau de ligne�: 1 Caract�re�: 3
+ nc <<<<
    + CategoryInfo          : ObjectNotFound: (nc:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException


Suggestion [3,General]: La commande nc est introuvable, mais elle existe � l'emplacement actif. Par d�faut, Windows
rShell ne charge pas de commandes � partir de l'emplacement actif. Si vous approuvez cette commande, tapez ".\nc" �
lace. Pour plus d'informations, voir "get-help about_Command_Precedence".
PS L:\netcat> nc
Le terme ��nc�� n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script ou programme ex�cutabl
V�rifiez l'orthographe du nom, ou si un chemin d'acc�s existe, v�rifiez que le chemin d'acc�s est correct et r�essay
Au niveau de ligne�: 1 Caract�re�: 3
+ nc <<<<
    + CategoryInfo          : ObjectNotFound: (nc:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException


Suggestion [3,General]: La commande nc est introuvable, mais elle existe � l'emplacement actif. Par d�faut, Windows
rShell ne charge pas de commandes � partir de l'emplacement actif. Si vous approuvez cette commande, tapez ".\nc" �
lace. Pour plus d'informations, voir "get-help about_Command_Precedence".
PS L:\netcat>
```
Plus rien ne va. Petit plus, je dl netcat sur le vieux asus et meme probeme sauf que la, attend tu vas rire, je l'ai mis dans documents, j'ai d�compress� l'archive et avec un cmd il ne trouve meme pas le dossier netcat dans documents. 
L� je t'attend...

Je fais la commande nc et il s'av�re qu'elle ne fonctionne pas mais attends, je peux quand m�me l'�x�cuter si je fais un ".\nc", et ensuite je me retrouve avec ca :
```
PS L:\netcat> .\nc
Cmd line:
```
Sur le pc serveur, je fais la commande ```nc.exe -l -p 8888``` pour obtenir un message d'erreur indiquant ```nc.exe: invalid option -- 1```.

Je tente ```nc.exe -p 8888``` dans le menu Cmd line et j'obtiens :
```
nc.exe: forward host lookup failed: h_errno 11001: HOST_NOT_FOUND
```
Un peu bizzare vu que tu es cens� �tre le dis "host" de ce pseudo-r�seau.
Menfin je m'arr�te pas l�, on continue.

Sur mon pc (le pc client) je me retrouve avec :
```
PS L:\netcat> .\nc
Cmd line: nc.exe 192.168.1.1 8888
nc.exe: forward host lookup failed: h_errno 11001: HOST_NOT_FOUND
```
Bon bah � partir de l�, �a faisait toute une aprem que j'�tais dessus. Je pr�f�re l�cher l'affaire se sera moins douleureux que de continuer � se torturer le cerveau pour les m�mes erreurs sans solutions.

Bref, c'est fini.
Merci de ton attention.

on fais un test pour git ssh