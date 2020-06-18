# Compte Rendu TP : Faisons joujou
## I.Exploration locale en solo
### 1.Affichage d'informations sur la pile TCP/IP locale

Résultat obtenu pour les premières questions avec la commande ipconfig /all. J'ai pas de copy/paste sous la main.
Mes plates excuses.

Carte réseau sans fil Connexion réseau sans fil; adresse MAC : B4-6D-83-D2-D4-80
Carte Ethernet Connexion au réseau local; adresse MAC : 0A-00-27-00-00-19
adresse gateway : 10.33.3.253


Graphical User Interface :
- IP : 10.33.3.148
- MAC : B4-6D-83-D2-D4-80
- Gateway : 10.33.3.253

Question bonus:
Le gateway d'Ynov permet de relier le réseau locl d'ynov au réseau internet.

### 2.Modifications des informations
#### A.Modification d'adresse IP (part 1)

Bon... je suis sous windows 7 ce qui veut dire "emmerdes sur emmerdes" donc j'ai eu quelque problèmes avec ma carte wifi (pas de sauvegarde des paramètres d'Ip modifié) sauf que après un bon reboot du pc et être rentré
dans le jeu de windows (soit recommencer l'opération plusieurs fois) ca marche va savoir pourquoi.
Bref, aucun problème de connexion rencontré, on fait un ping du réseau ynov, ça marche.
go continuer.
(j'ai pas de copier coller des commandes me tape pas stp, trust me anakin)

#### B.nmap

On installe nmap et tout se passe comme prévu sans aucun problème.
Après avoir scanné le réseau ynov avec la commande nmap ```nmap.exe -sP 10.33.0.0/22```, on se rend compte que le réseau a beaucoup d'Ip libre. Let's go s'en approprier un.

Puis j'ai décidé de me mettre sur l'Ip 10.33.3.250 parce qu'elle était libre. On a :
```
Carte réseau sans fil Connexion réseau sans fil :

   Suffixe DNS propre à la connexion. . . :
   Description. . . . . . . . . . . . . . : Intel(R) Dual Band Wireless-AC 3160
   Adresse physique . . . . . . . . . . . : B4-6D-83-D2-D4-80
   DHCP activé. . . . . . . . . . . . . . : Non
   Configuration automatique activée. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::7199:3cab:9d69:5a73%14(préféré)
   Adresse IPv4. . . . . . . . . . . . . .: 10.33.3.250(préféré)
   Masque de sous-réseau. . . . . . . . . : 255.255.252.0
   Passerelle par défaut. . . . . . . . . : 10.33.3.253
   IAID DHCPv6 . . . . . . . . . . . : 380923267
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activé
```
Menfin, tout ça c'est beau mais maintenant on va voir si avec toutes ces modifications on arrive à se connecter à internet.
Voici le protocole suivant :
```
PS C:\Users\Marius> nslookup google.com
Serveur :   dns.google
Address:  8.8.8.8

Réponse ne faisant pas autorité :
Nom :    google.com
Addresses:  2a00:1450:4007:809::200e
          216.58.204.110
```
Le pc à réussis à joindre google.com avec son Ip modifié, en deux mots : "IT WORKS!!!". Et si je dis pas de bêtises, cette commande conclut la partie C.Modification d'adresse Ip (part2)

## II.Exploration locale en duo
### 3.Modification d'adresse Ip

Bon, cette partie je l'ai faite avec un ami chez lui. On a fait avec les moyens du bord et on s'est plutôt pas mal débrouillé.
Pour commencer, la modification d'adresse Ip, ça nous donne ceci
```
Carte Ethernet Connexion au réseau local :

   Suffixe DNS propre à la connexion. . . :
   Description. . . . . . . . . . . . . . : Killer e2200 Gigabit Ethernet Controller
   Adresse physique . . . . . . . . . . . : D8-CB-8A-82-94-30
   DHCP activé. . . . . . . . . . . . . . : Non
   Configuration automatique activée. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::185e:347b:da51:bcf8%13(préféré)
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.27.2(préféré)
   Masque de sous-réseau. . . . . . . . . : 255.255.255.252
   Passerelle par défaut. . . . . . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 299420554
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activé
```
Mon adresse Ip a été modifié en 192.168.27.2 (la .1 était utilisé par Tony (l'ami dépanneur)).
On a tenté de suivre les consignes du tp à savoir se mettre en /30, donc mettre un masque de sous-réseau à 255.255.255.252 et on a eu des gros problèmes pour se ping.
```
PS C:\Users\Marius> ping 192.168.27.1

Envoi d'une requête 'Ping'  192.168.27.1 avec 32 octets de données :
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
```
Après plusieurs tentatives en vain, on a joué la solution de facilité : on s'est mis en 255.255.255.0 (soit en /24).
Et là, miracle :
```
PS C:\Users\Marius> ping 192.168.27.1

Envoi d'une requête 'Ping'  192.168.27.1 avec 32 octets de données :
Réponse de 192.168.27.1 : octets=32 temps=2 ms TTL=128
Réponse de 192.168.27.1 : octets=32 temps=1 ms TTL=128
Réponse de 192.168.27.1 : octets=32 temps=1 ms TTL=128
Réponse de 192.168.27.1 : octets=32 temps=1 ms TTL=128

Statistiques Ping pour 192.168.27.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 2ms, Moyenne = 1ms
```
### 4.Utilisation d'un des deux comme gateway
Bon, c'est là que ça se gâte.
Pour commencer, on se met en 192.168.1.29 pour concorder les Ip de nos équipements avec la livebox de Tony.
Mais après de nombreux essai à modifer les Ip de chaque équipement, aucun succès ne se présente quand il faut faire communiquer l'ordinateur 1 à internet via l'ordinateur 2 en tant que passerrelle réseau.

Voici un détail des différentes erreurs rencontrée:
```
PS C:\Users\Marius> ping 192.168.2.1

Envoi d'une requête 'Ping'  192.168.2.1 avec 32 octets de données :
PING : échec de la transmission. Défaillance générale.
PING : échec de la transmission. Défaillance générale.
PING : échec de la transmission. Défaillance générale.
PING : échec de la transmission. Défaillance générale.

Statistiques Ping pour 192.168.2.1:
    Paquets : envoyés = 4, reçus = 0, perdus = 4 (perte 100%),
```
```
PS C:\Users\Marius> ping 192.168.27.1

Envoi d'une requête 'Ping'  192.168.27.1 avec 32 octets de données :
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.27.2 : Impossible de joindre l'hôte de destination.

Statistiques Ping pour 192.168.27.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
```
On a cherché de notre côté pour résoudre ces problèmes, mais bof bof... On va passer à l'étape suivante. 
Là, c'est la partie où tout est parti en sucette. Le reste du compte-rendu parlera de lui même.
Bref, on suit toujours la trame du TP:
```
Carte Ethernet Connexion au réseau local :

   Suffixe DNS propre à la connexion. . . :
   Description. . . . . . . . . . . . . . : Killer e2200 Gigabit Ethernet Controller
   Adresse physique . . . . . . . . . . . : D8-CB-8A-82-94-30
   DHCP activé. . . . . . . . . . . . . . : Non
   Configuration automatique activée. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::185e:347b:da51:bcf8%13(préféré)
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.27.2(préféré)
   Masque de sous-réseau. . . . . . . . . : 255.255.255.0
   Passerelle par défaut. . . . . . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 299420554
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activé
```
```
Carte Ethernet Connexion au réseau local :

   Suffixe DNS propre à la connexion. . . :
   Description. . . . . . . . . . . . . . : Killer e2200 Gigabit Ethernet Controller
   Adresse physique . . . . . . . . . . . : D8-CB-8A-82-94-30
   DHCP activé. . . . . . . . . . . . . . : Non
   Configuration automatique activée. . . : Oui
   Adresse IPv6 de liaison locale. . . . .: fe80::185e:347b:da51:bcf8%13(préféré)
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.1.2(préféré)
   Masque de sous-réseau. . . . . . . . . : 255.255.255.0
   Passerelle par défaut. . . . . . . . . : 192.168.1.29
   IAID DHCPv6 . . . . . . . . . . . : 299420554
   DUID de client DHCPv6. . . . . . . . : 00-01-00-01-1E-6D-F2-DF-D8-CB-8A-82-94-30
   Serveurs DNS. . .  . . . . . . . . . . : 8.8.8.8
   NetBIOS sur Tcpip. . . . . . . . . . . : Activé
```
```
PS C:\Users\Marius> ping 192.168.1.29

Envoi d'une requête 'Ping'  192.168.1.29 avec 32 octets de données :
Délai d'attente de la demande dépassé.
Réponse de 192.168.1.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.1.2 : Impossible de joindre l'hôte de destination.
Délai d'attente de la demande dépassé.

Statistiques Ping pour 192.168.1.29:
    Paquets : envoyés = 4, reçus = 2, perdus = 2 (perte 50%),
```
Tout ne se passe pas comme prévu, mais on continue, sait-on jamais ?
```
PS C:\Users\Marius> nslookup 8.8.8.8
DNS request timed out.
    timeout was 2 seconds.
Serveur :   UnKnown
Address:  fe80::a63e:51ff:fe78:9c6

DNS request timed out.
    timeout was 2 seconds.
*** Le délai de la requête sur UnKnown est dépassé.
```
Après m'être rendu compte de quelques petites erreurs concernant les Ip, je me retrouve avec ceci:
```
PS C:\Users\Marius> ping 192.168.1.29

Envoi d'une requête 'Ping'  192.168.1.29 avec 32 octets de données :
Réponse de 192.168.1.29 : octets=32 temps=1 ms TTL=128
Réponse de 192.168.1.29 : octets=32 temps=1 ms TTL=128
Réponse de 192.168.1.29 : octets=32 temps=1 ms TTL=128
Réponse de 192.168.1.29 : octets=32 temps=1 ms TTL=128

Statistiques Ping pour 192.168.1.29:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 1ms, Moyenne = 1ms
```
On a réussis a faire ping les pc entre eux, maintenant il faut que mon pc puisse "joindre" sa carte wifi pour récupérer de l'internet.
``` 
PS C:\Users\Marius> ping 192.168.1.18

Envoi d'une requête 'Ping'  192.168.1.18 avec 32 octets de données :
Réponse de 192.168.1.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.1.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.1.2 : Impossible de joindre l'hôte de destination.
Réponse de 192.168.1.2 : Impossible de joindre l'hôte de destination.

Statistiques Ping pour 192.168.1.18:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
```
Cela annonce la couleur de la suite du Tp.
```
PS C:\Users\Marius> tracert 8.8.8.8

Détermination de l'itinéraire vers 8.8.8.8 avec un maximum de 30 sauts.

  1  Erreur de transmission : code 1231

Itinéraire déterminé.
```
A partir de là, plus rien ne fonctionne...
```
PS C:\Users\Marius> nslookup 8.8.8.8
DNS request timed out.
    timeout was 2 seconds.
Serveur :   UnKnown
Address:  fe80::a63e:51ff:fe78:9c6

DNS request timed out.
    timeout was 2 seconds.
*** Le délai de la requête sur UnKnown est dépassé.
```
### 5.Petit chat privé
Cette partie là, j'ai essayé de la faire chez moi. Donc j'utilise un nouveau pc, un vieux asus 700 jsplus quoi, bref : on créé le réseau, on se ping et bim ca marche :
```
PS C:\Users\Marius> ping 192.168.1.1

Envoi d'une requête 'Ping'  192.168.1.1 avec 32 octets de données :
Réponse de 192.168.1.1 : octets=32 temps<1ms TTL=128
Réponse de 192.168.1.1 : octets=32 temps<1ms TTL=128
Réponse de 192.168.1.1 : octets=32 temps<1ms TTL=128
Réponse de 192.168.1.1 : octets=32 temps<1ms TTL=128

Statistiques Ping pour 192.168.1.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
```
P.S : je suis le client et l'autre pc est le serveur.

Puis je pensais que l'ère des problèmes sans solutions était finie. QUE NENNI! Netcat est arrivé. Je télécharge netcat sur le lien que tu nous a donné.
Ensuite je le dézip dans mon disque L:, puis j'éxécute les commandes demandé.
```
PS C:\Users\Marius> nc.exe -1 -p 8888
Le terme « nc.exe » n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script ou programme exécu
le. Vérifiez l'orthographe du nom, ou si un chemin d'accès existe, vérifiez que le chemin d'accès est correct et rée
yez.
Au niveau de ligne : 1 Caractère : 7
+ nc.exe <<<<  -1 -p 8888
    + CategoryInfo          : ObjectNotFound: (nc.exe:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```
Je décide d'aller dans le disque L: pour éxécuter la commande netcat:
```
PS C:\Users\Marius> cd L:
PS L:\> cd netcat
PS L:\netcat> nc
Le terme « nc » n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script ou programme exécutabl
Vérifiez l'orthographe du nom, ou si un chemin d'accès existe, vérifiez que le chemin d'accès est correct et réessay
Au niveau de ligne : 1 Caractère : 3
+ nc <<<<
    + CategoryInfo          : ObjectNotFound: (nc:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException


Suggestion [3,General]: La commande nc est introuvable, mais elle existe à l'emplacement actif. Par défaut, Windows
rShell ne charge pas de commandes à partir de l'emplacement actif. Si vous approuvez cette commande, tapez ".\nc" à
lace. Pour plus d'informations, voir "get-help about_Command_Precedence".
PS L:\netcat> nc
Le terme « nc » n'est pas reconnu comme nom d'applet de commande, fonction, fichier de script ou programme exécutabl
Vérifiez l'orthographe du nom, ou si un chemin d'accès existe, vérifiez que le chemin d'accès est correct et réessay
Au niveau de ligne : 1 Caractère : 3
+ nc <<<<
    + CategoryInfo          : ObjectNotFound: (nc:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException


Suggestion [3,General]: La commande nc est introuvable, mais elle existe à l'emplacement actif. Par défaut, Windows
rShell ne charge pas de commandes à partir de l'emplacement actif. Si vous approuvez cette commande, tapez ".\nc" à
lace. Pour plus d'informations, voir "get-help about_Command_Precedence".
PS L:\netcat>
```
Plus rien ne va. Petit plus, je dl netcat sur le vieux asus et meme probeme sauf que la, attend tu vas rire, je l'ai mis dans documents, j'ai décompressé l'archive et avec un cmd il ne trouve meme pas le dossier netcat dans documents. 
Là je t'attend...

Je fais la commande nc et il s'avère qu'elle ne fonctionne pas mais attends, je peux quand même l'éxécuter si je fais un ".\nc", et ensuite je me retrouve avec ca :
```
PS L:\netcat> .\nc
Cmd line:
```
Sur le pc serveur, je fais la commande ```nc.exe -l -p 8888``` pour obtenir un message d'erreur indiquant ```nc.exe: invalid option -- 1```.

Je tente ```nc.exe -p 8888``` dans le menu Cmd line et j'obtiens :
```
nc.exe: forward host lookup failed: h_errno 11001: HOST_NOT_FOUND
```
Un peu bizzare vu que tu es censé être le dis "host" de ce pseudo-réseau.
Menfin je m'arrête pas là, on continue.

Sur mon pc (le pc client) je me retrouve avec :
```
PS L:\netcat> .\nc
Cmd line: nc.exe 192.168.1.1 8888
nc.exe: forward host lookup failed: h_errno 11001: HOST_NOT_FOUND
```
Bon bah à partir de là, ça faisait toute une aprem que j'étais dessus. Je préfère lâcher l'affaire se sera moins douleureux que de continuer à se torturer le cerveau pour les mêmes erreurs sans solutions.

Bref, c'est fini.
Merci de ton attention.

on fais un test pour git ssh