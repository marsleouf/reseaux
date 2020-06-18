# B42 Réseau 2020 - TP2

*Salut à tous, ce compte rendu est sponsorisé par Raid Shadow Legends. Oubliez tous ce que vous pensez savoir sur les jeux mobile. Raid Shadow Legends offre totes les fonctionnalitées d'un jeu de rôle et un scénario incroyable. Des graphismes...*
![](./images/gueule.jpg)
---

## I. Création et utilisation simples d'une VM CentOS
---

Bon plus sérieusement, voilà mon compte rendu du tp2. Installe toi bien. ET Z'EEEEEEEEST BARTIIIIIIIIIIIIIIIIS!

Name | Ip | Mac | Function
--- | --- | --- | ---
`enp0s3` | `10.0.2.15/24` | `08:00:27:33:e9:9e` | Nat
`enps08` | `10.2.1.2/24` | `08:00:27:5b:44:06` | `card host only`

"Oh un petit tableau, que c'est mignon!"
Mais maintenant il est grand temps de faire des changements :

![](./images/change.gif)

Name | Ip | Mac | Function
--- | --- | --- | ---
`enp0s8` | `10.2.1.10/24` | `08:00:27:5b:44:06` | `card host only`

![](./images/transition.png)

ET ON FAIT DU PING, PING, PING!

```powershell
PS C:\Users\Marius> ping 10.2.1.10
Envoi d'une requête 'Ping'  10.2.1.10 avec 32 octets de données :
Réponse de 10.2.1.10 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.10 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.10 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.10 : octets=32 temps=1 ms TTL=64

Statistiques Ping pour 10.2.1.10:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 1ms, Moyenne = 0ms
```
ET MAINTENANT ON FAIT DU QUOI?? ON FAIT DU SCAN, SCAN, SCAN!

Essai réalisable grâce à notre sponsor "Nmap" et ses branches de particuliers.

Testons ensemble l'éfficacité du produit:

```powershell
[vinny@patron ~]$ nmap 10.2.1.10

Starting Nmap 6.40 ( http://nmap.org ) at 2020-02-27 15:02 CET
Nmap scan report for vm1 (10.2.1.10)
Host is up (0.0011s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 1 IP address (1 host up) scanned in 0.14 seconds
```
De plus, grâce aux incroyables compétences de nos ingénieurs séquestrés dans nos laboratoires, appro... aprofo.. approfondi... alons en profondeur dans notre test:

```powershell
PS C:\Windows\system32> nmap -sP 10.2.1.0/24
Starting Nmap 7.80 ( https://nmap.org ) at 2020-02-27 15:09 Paris, Madrid
Nmap scan report for 10.2.1.10
Host is up (0.00s latency).
MAC Address: 08:00:27:5B:44:06 (Oracle VirtualBox virtual NIC)
Nmap scan report for 10.2.1.1
Host is up.
Nmap done: 256 IP addresses (2 hosts up) scanned in 4.59 seconds
```
Précisons qu'il s'agit là d'un test depuis notre superbe machine Win7 incontournable vers la VM.

Faisons maintenant l'inverse, à savoir de la VM au Magnificent 7 (j'ai réussis à caler un titre d'un film dans un compte rendu, je veux une satue en cookies à mon éfigie):

```powershell
[vinny@patron ~]$ nmap -sP 10.2.1.0/24

Starting Nmap 6.40 ( http://nmap.org ) at 2020-02-27 15:10 CET
nmap: nsock_pool.c:227: nsp_delete: Assertion `nse->iod->events_pending >= 0' failed.
Aborted
```
![](./images/point.jpg)
![](./images/commence.jpg)

(oui oui oui, la même réaction quand j'ai vu "ABORTED", trois pitit point like. puis je me suis enervé)

Là je t'attend, là t'as pas la solution hein ? Là je t'ai collé, hein ? (sors moi "ton erreur c'est win7" et je te propose un octogone avec des règles)

Bref, reconcentrons nous :  on peut pas être au moulin et au fourneau en même temps. 

On "ss" (SuperSympa, ou un régime composé d'une equipe de dresseur pokémon de 39-45 qui gonna catch them all') le réseau pour lister les ports TCP et UDP présent:

```
[vinny@patron ~]$ sudo ss -lntunm
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
tcp    LISTEN     0      128       *:22                    *:*
         skmem:(r0,rb87380,t0,tb16384,f0,w0,o0,bl0,d0)
tcp    LISTEN     0      100    127.0.0.1:25                    *:*             
         skmem:(r0,rb87380,t0,tb16384,f0,w0,o0,bl0,d0)
tcp    LISTEN     0      128      :::22                   :::*
         skmem:(r0,rb87380,t0,tb16384,f0,w0,o0,bl0,d0)
tcp    LISTEN     0      100     ::1:25                   :::*
         skmem:(r0,rb87380,t0,tb16384,f0,w0,o0,bl0,d0)
```

Et baaaaaaaaah, pas de chance... Faut croire que j'ai que des ports TCP.

![](./images/longue.jpg)

Bon... pour la suite j'ai voulu faire le malin avec el famoso tcpdump... puuiiiis, la commande qui te choppe 1 000 000 de paquets en moins de 2 minutes, non merci j'ai plus faim.

En clair : tcpdump est un echec viral.

```powershell
[vinny@patron ~]$ ping 10.2.1.1
PING 10.2.1.1 (10.2.1.1) 56(84) bytes of data.
64 bytes from 10.2.1.1: icmp_seq=1 ttl=128 time=0.626 ms
64 bytes from 10.2.1.1: icmp_seq=2 ttl=128 time=0.109 ms
64 bytes from 10.2.1.1: icmp_seq=3 ttl=128 time=0.266 ms
64 bytes from 10.2.1.1: icmp_seq=4 ttl=128 time=0.113 ms
64 bytes from 10.2.1.1: icmp_seq=5 ttl=128 time=0.127 ms
64 bytes from 10.2.1.1: icmp_seq=6 ttl=128 time=0.129 ms
64 bytes from 10.2.1.1: icmp_seq=7 ttl=128 time=0.120 ms
64 bytes from 10.2.1.1: icmp_seq=8 ttl=128 time=0.131 ms
```
Je t'ai mis le ping de la VM vers le pc mais sinon je te rassure, je vais pas te mettre la commande tcpdump parce que je doute que tu t'amuses à te farcir 3 000 lignes de commande.

En revanche, mate ca :

```powershell
19:30:07.037147 IP vm1.ssh > 10.2.1.1.26188: Flags [P.], seq 327858544:327858720, ack 965441, win 6159, length 176
19:30:07.037191 IP 10.2.1.1.26188 > vm1.ssh: Flags [P.], seq 965441:965505, ack 327858544, win 252, length 64
^C
2276503 PACKETS CAPTURED
2276503 packets received by filter
0 packets dropped by kernel
```
Et il tournait depuis, genre, 2 minute à tout casser.

Je pense que tu sais ce que ça veut dire tout ça...

![](./images/transition.png)


## II. Notion de ports
---

Alors... pour commencer, on va regarder quelque chose:

```powershell
[vinny@patron ~]$ ss -ltunp
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
udp    UNCONN     0      0         *:68                    *:*
tcp    LISTEN     0      128       *:22                    *:*
tcp    LISTEN     0      100    127.0.0.1:25                    *:*             
tcp    LISTEN     0      128      :::22                   :::*
tcp    LISTEN     0      100     ::1:25                   :::*

```

QUIZZ : A quoi sert cette commande ?

	a - à espionner le FBI (use reverse card UNO)

	b - à vérifier sur quel port écoute le serveur SSH

	c - à apprendre à se servir d'un sextemps (obligation de mettre 20 sur ma note si t'as la rèf)

	d - la réponse D

![](./images/ouais.gif)
(pôce blô si tu peux entendre ce gif)

WOAW, tu es super fort Léal (un Léal des Léo t'as capté ? HEIN T'AS CAPTÉ?!?), t'as trouvé la bonne réponse! Maintenant résout l'équation quantique du continuum espace temps.
(tip : le résultat est 2.21 Gigowatts).

Bien maintenant trouve l'éqquation du boson de Higgs.
Ah bah tiens... ON FAIT MOINS LE MALIN LA HEIN ?!?

Bref (acronyme de "Bon Revenons En au Fait"), la suite: on vérifie la connection SSH du dit port 22.

```powershell
[vinny@patron ~]$ ss -l -t
State      Recv-Q Send-Q Local Address:Port                 Peer Address:Port   
LISTEN     0      128        *:ssh                      *:*
LISTEN     0      100    127.0.0.1:smtp                     *:*                 
LISTEN     0      128       :::ssh                     :::*
LISTEN     0      100      ::1:smtp                    :::*
```
SSH est dans la place, plus rien ne va. DONC, ça fonctionne.
Après tu vas dans /etc/ssh/ssh_config et on est censé modifier le fichier avec la ligne qui indique les infos concernant le port sur lequel écoute le serveur SSH.
Tu trouve la ligne # Port 22, tu delete le # puis tu rentres la valeur du port souhaité. Faut choisir une valeur entre 1024 et 65535...
Bah vu que je suis un gros gamin, je vais choisir "69420", et c'est trop grand. Donc "42069".

Bon bon bon... ok j'avoue la commande suivante on me l'a filé:

```powershell
[vinny@patron ssh]$ sudo firewall-cmd --add-port=42069/tcp --permanent
success
```
On l'utilise en fait pour ajouter le port renseigné dans la liste des ports autorisé par le firewall.
Allé on continue ?
STOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOP!!

FAUT RESTART LE TOUT COUILLON!

Allé bonne dose de fun:

```powershell
[vinny@patron ssh]$ sudo firewall-cmd --reload
success
```
Puis on vérifie que tout est bon:

```powershell
[vinny@patron ssh]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s3 enp0s8
  sources:
  services: ssh dhcpv6-client
  ports: 8888/tcp 2222/tcp 42069/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```

Alors, tu peux voir trois port, le 8888, le 2222 et le famoso 42069. Le 2222 c'est juste que comme un con quand on m'a "prété" la commande j'ai fait la même sans rien toucher, juste ctrl-c ctrl-v (héhé).
Sans modifier le port... Voilàààà!

Puis la suite... bah cé ke zé pa su fère tu voa, hihi.
(Et tout de suite une représentation parfaite de toi qui voit que le II n'est pas finit.)

![](./images/instrument.jpg)

(me tape pas)

![](./images/transition.png)


## III. Routage statique
---

Partie III réalisé avec Clément.
Bon là, c'est la partie chiante, c'est long alors on va être rapide.
Une fois toute les modifications demandé en préambule effectuées, on passe la première parce que le point mort, c'est pas qu'on avance pas mais en fait si.

Ping pc vers vm :

```powershell
PS C:\Users\Marius> ping 10.2.1.10

Envoi d'une requête 'Ping'  10.2.1.10 avec 32 octets de données :
Réponse de 10.2.1.10 : octets=32 temps=1 ms TTL=64
Réponse de 10.2.1.10 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.10 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.10 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 10.2.1.10:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 1ms, Moyenne = 0ms*
```

Ping pc Clément :

```powershell
PS C:\Users\Marius> ping 10.2.12.2

Envoi d'une requête 'Ping'  10.2.12.2 avec 32 octets de données :
Réponse de 10.2.12.2 : octets=32 temps=1 ms TTL=128
Réponse de 10.2.12.2 : octets=32 temps=1 ms TTL=128
Réponse de 10.2.12.2 : octets=32 temps=1 ms TTL=128
Réponse de 10.2.12.2 : octets=32 temps=1 ms TTL=128

Statistiques Ping pour 10.2.12.2:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 1ms, Moyenne = 1ms
```
On rentre dans le registre du pc pour passer la valeur de la clé IPEnableRouter à 1 au lieu de 0.

On redémarre entièrement le pc (merci pour la perte de temps, t'as fait craché ses poumons à mon Win7. c'est vraiment pô nice, déjà qu'il est fumeur passif).

BREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEF, il m'a regardé, je l'ai régardé.
On a continué.

Vu que le pc a besoin d'aide, on lui indique quelle route prendre, genre comme ça:
![](./images/chemin.jpg)

Nan je rigole, plus comme ça:

```powershell
PS C:\Windows\system32> route add 10.2.2.0/24 mask 255.255.255.0 10.2.12.2
 OK!
```

Maintenant on ping l'autre PC:

```powershell
PS C:\Windows\system32> ping 10.2.2.1

Envoi d'une requête 'Ping'  10.2.2.1 avec 32 octets de données :
Réponse de 10.2.2.1 : octets=32 temps=1 ms TTL=127
Réponse de 10.2.2.1 : octets=32 temps=1 ms TTL=127
Réponse de 10.2.2.1 : octets=32 temps=1 ms TTL=127
Réponse de 10.2.2.1 : octets=32 temps=1 ms TTL=127

Statistiques Ping pour 10.2.2.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes : 
    Minimum = 1ms, Maximum = 1ms, Moyenne = 1ms
```
Mainenant on créé la route qu'empruntera la VM pour joindre l'autre PC, puis une fois que c'est fait, on teste le tout avec un ping:

```powershell
[vinny@patron network-scripts]$ ping 10.2.2.1
connect: Network is unreachable
[vinny@patron network-scripts]$ ip route add 10.2.2.0/24 via 10.2.1.1 dev enp0s8
RTNETLINK answers: Operation not permitted
[vinny@patron network-scripts]$ sudo ip route add 10.2.2.0/24 via 10.2.1.1 dev enp0s8
[sudo] password for vinny:
[vinny@patron network-scripts]$ ping 10.2.2.1
PING 10.2.2.1 (10.2.2.1) 56(84) bytes of data.
64 bytes from 10.2.2.1: icmp_seq=1 ttl=126 time=2.20 ms
64 bytes from 10.2.2.1: icmp_seq=2 ttl=126 time=1.33 ms
64 bytes from 10.2.2.1: icmp_seq=3 ttl=126 time=1.54 ms
64 bytes from 10.2.2.1: icmp_seq=4 ttl=126 time=2.78 ms
64 bytes from 10.2.2.1: icmp_seq=5 ttl=126 time=1.79 ms
64 bytes from 10.2.2.1: icmp_seq=6 ttl=126 time=1.61 ms
^C
--- 10.2.2.1 ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5014ms
rtt min/avg/max/mdev = 1.335/1.880/2.787/0.486 ms
```
ET IL SEMBLERAIT QUE LA ROUTE FONCTIONNE!!

![](./images/alive.jpeg)

(rien a voir avec le tp cette image mais je voulais juste la caler mdrrr)

Même chose pour joindre l'autre vm maintenant.

```powershell
[vinny@patron ~]$ sudo ip route add 10.2.2.0/24 via 10.2.1.1 dev enp0s8
[vinny@patron ~]$ traceroute 10.2.2.1
traceroute to 10.2.2.1 (10.2.2.1), 30 hops max, 60 byte packets
 1  10.2.1.1 (10.2.1.1)  0.286 ms * *
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * *^C
```
ET non c'etait avec la nat activée mdrrrrr. Qu'est ce que je suis con quand je m'y met.

Sans nat activé (je l'avais activé juste avant cette ligne pour installer des packets parce qu'ils y étaient pas haha), ça donne:

```powershell
[vinny@patron ~]$ traceroute 10.2.2.1
traceroute to 10.2.2.1 (10.2.2.1), 30 hops max, 60 byte packets
 1  10.2.1.1 (10.2.1.1)  0.191 ms * *
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * *^C
```

Mmmmmouais... bon bah la meme chose quoi.
Je ping le pc de Clément:

```powershell
[vinny@patron ~]$ ping 10.2.2.1
PING 10.2.2.1 (10.2.2.1) 56(84) bytes of data.
64 bytes from 10.2.2.1: icmp_seq=1 ttl=126 time=1.60 ms
64 bytes from 10.2.2.1: icmp_seq=2 ttl=126 time=1.50 ms
64 bytes from 10.2.2.1: icmp_seq=3 ttl=126 time=2.09 ms
```
It works!

Je ping la VM Clément:

```powershell
[vinny@patron ~]$ ping 10.2.2.10
PING 10.2.2.10 (10.2.2.10) 56(84) bytes of data.
64 bytes from 10.2.2.10: icmp_seq=1 ttl=62 time=1.65 ms
64 bytes from 10.2.2.10: icmp_seq=2 ttl=62 time=1.55 ms
64 bytes from 10.2.2.10: icmp_seq=3 ttl=62 time=1.40 ms
64 bytes from 10.2.2.10: icmp_seq=4 ttl=62 time=1.46 ms
```
IT WOOOOOOOOOOOOOOOOOOOOOOOOOOORKS!!!

Bon après avoir changé les hosts des VM et des PC, on ping via la commande:

```powershell
[vinny@patron etc]$ ping vm2.tp2.b1
PING vm2 (10.2.2.10) 56(84) bytes of data.
64 bytes from vm2 (10.2.2.10): icmp_seq=1 ttl=62 time=1.94 ms
64 bytes from vm2 (10.2.2.10): icmp_seq=2 ttl=62 time=1.67 ms
64 bytes from vm2 (10.2.2.10): icmp_seq=3 ttl=62 time=1.58 ms
^C
--- vm2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.580/1.735/1.947/0.158 ms
```
Puis on traceroute:

```powershell
[vinny@patron ~]$ traceroute vm2.tp2.b1
traceroute to vm2.tp2.b1 (10.2.2.10), 30 hops max, 60 byte packets
 1  10.2.1.1 (10.2.1.1)  0.483 ms * *
 2  * * *
 3  vm2 (10.2.2.10)  1.570 ms !X  1.430 ms !X  0.879 ms !X
```
Puis on passe sur netcat teh, c'est bien de faire ping les VM entre elles, mais c'est encore mieux si on peut les faire échanger sur des sujets d'actualité tel le COVID-19:

```powershell
[vinny@patron ~]$ sudo firewall-cmd --add-port=8888/tcp --permanent
success

[vinny@patron ~]$ nc -l 8888
test
message

[vinny@patron ~]$ nc vm2.tp2.b1 8888
test
bonoure
qkjshf:qk
```
ET voilà! C'est finit ça fonctionne parfaitement. Et un tp de réussis, un.

Et attend on m'informe que t'as commencé à lacher l'affaire parce qu'il n'y a pas eu de blagues depuis 30 secondes alors attends... euh.. euh...

```
Qu'est ce qui n'est pas un steak ?																																	ET BAH UNE PUTE HAHAHA
```

Merci pour avoir follow le tp jusqu'ici, jespère que tu t'es tapé des barres, que t'as passé un bon moment, et que t'as mangé ton fromage blanc avec une fiche bristol.

(et ouais j'ai totalement pompé ta mise en forme et alors ?)