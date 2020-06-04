# TP 3 - Routage

## Préparation de l'environnement

### 2 - Etablissement des vm

**Client 1, ready ?**

Tout d'abbord, on désactive la carte enp0s3 avec `sudo ifdown enp0s3`.
Puis dans le fichier `/etc/sysconfig/network-scripts/ifcfg-enp0s3` on passe le `ONBOOT='yes'` à `ONBOOT='no'`
On check avec la commande `ip a` :

```powershell
[vinny@client_tp3_1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:98:38:c5 brd ff:ff:ff:ff:ff:ff
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:92:14:91 brd ff:ff:ff:ff:ff:ff
    inet 10.2.1.13/24 brd 10.2.2.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe92:1491/64 scope link 
       valid_lft forever preferred_lft forever
```

On vérifie que le port ssh est bien en écoute sur le port `7777` avec la commade `ss -tulnp` : 

```powershell
[vinny@client_tp3_1 ~]$ ss -tulnp                                                                        
Netid State      Recv-Q Send-Q    Local Address:Port                   Peer Address:Port              
tcp   LISTEN     0      100           127.0.0.1:25                                *:*                  
tcp   LISTEN     0      128                   *:7777                              *:*                  
tcp   LISTEN     0      100               [::1]:25                             [::]:*                  
tcp   LISTEN     0      128                [::]:7777                           [::]:*
```

On check que le firewall est bien activé et qu'il bloque pas l'écoute sur le port souhaité : 

```powershell
[vinny@client_tp3_1 ~]$ sudo firewall-cmd --list-all
[sudo] password for vinny: 
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s8
  sources: 
  services: dhcpv6-client ssh
  ports: 7777/tcp
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports:
  icmp-blocks: 
  rich rules:
```

On check le hostname :

```powershell
[vinny@client_tp3_1 ~]$ hostname
client_tp3_1.net1.tp3
```

Let's go bidouiller le fichier `/etc/hosts`.

```powershell
[vinny@client_tp3_1 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.2.1.13   tp3.b1 client_tp3_1.net1.tp3
```

Puis on rôgard les ip sur la vm :

```powershell
[vinny@client_tp3_1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:98:38:c5 brd ff:ff:ff:ff:ff:ff
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:92:14:91 brd ff:ff:ff:ff:ff:ff
    inet 10.2.1.13/24 brd 10.2.2.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe92:1491/64 scope link 
       valid_lft forever preferred_lft forever
```

Puis un `ping` de 10.2.1.13 avec la machine host vers la VM : 

```powershell
PS C:\Users\marsl> ping 10.2.1.13

Envoi d’une requête 'Ping'  10.2.1.13 avec 32 octets de données :
Réponse de 10.2.1.13 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.13 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.13 : octets=32 temps<1ms TTL=64
Réponse de 10.2.1.13 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 10.2.1.13:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
```

#### Maintenant on peut vérifier qu'au sein de notre bivouac, le client peut communiquer avec le routeur :

```powershell
[vinny@client_tp3_1 ~]$ ping 10.2.1.254 -c 3
PING 10.2.1.254 (10.2.1.254) 56(84) bytes of data.
64 bytes from 10.2.1.254: icmp_seq=1 ttl=64 time=1.33 ms
64 bytes from 10.2.1.254: icmp_seq=2 ttl=64 time=2.67 ms
64 bytes from 10.2.1.254: icmp_seq=3 ttl=64 time=1.25 ms

--- 10.2.1.254 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 1.253/1.753/2.678/0.656 ms
```

Et inversement le router peut ping le client :

```powershell
[vinny@routèr ~]$ ping 10.2.1.13 -c 3
PING 10.2.1.13 (10.2.1.13) 56(84) bytes of data.
64 bytes from 10.2.1.13: icmp_seq=1 ttl=64 time=1.23 ms
64 bytes from 10.2.1.13: icmp_seq=2 ttl=64 time=1.36 ms
64 bytes from 10.2.1.13: icmp_seq=3 ttl=64 time=1.33 ms

--- 10.2.1.13 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2012ms
rtt min/avg/max/mdev = 1.232/1.309/1.365/0.056 ms
```

On essaye maintenant de ping le router depuis le server : 

```powershell
[vinny@server1 ~]$ ping 10.2.2.254 -c 3
PING 10.2.2.254 (10.2.2.254) 56(84) bytes of data.
64 bytes from 10.2.2.254: icmp_seq=1 ttl=64 time=1.31 ms
64 bytes from 10.2.2.254: icmp_seq=2 ttl=64 time=2.46 ms
64 bytes from 10.2.2.254: icmp_seq=3 ttl=64 time=1.32 ms

--- 10.2.2.254 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2009ms
rtt min/avg/max/mdev = 1.314/1.701/2.466/0.541 ms
```

Et inversement : 

```powershell
[vinny@routèr ~]$ ping 10.2.2.11 -c 3
PING 10.2.2.11 (10.2.2.11) 56(84) bytes of data.
64 bytes from 10.2.2.11: icmp_seq=1 ttl=64 time=1.44 ms
64 bytes from 10.2.2.11: icmp_seq=2 ttl=64 time=1.66 ms
64 bytes from 10.2.2.11: icmp_seq=3 ttl=64 time=1.50 ms

--- 10.2.2.11 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2007ms
rtt min/avg/max/mdev = 1.441/1.537/1.667/0.095 ms
```

## I. Mise en place du routage
### 1. Configuration du routage sur `router`

Pour commencer, vérifier si l'IP Forwarding est activé serait une bonne chose : 

```powershell
[vinny@routèr ~]$ cat /proc/sys/net/ipv4/ip_forward
0
``` 

Le 0 nous indique que l'IP Forwarding n'est pas activé. Réglons le problème :

```powershell
[vinny@routèr ~]$ sudo sysctl -w net.ipv4.ip_forward=1
net.ipv4.ip_forward = 1
```

Bingo.

### 2. Ajouter les routes statiques

Pour joindre le réseau net2, on fait comme ça : `sudo ip route add 10.2.1.0/24 via 10.2.1.254 dev enp0s8`. Checkons :

```powershell
[vinny@client_tp3_1 ~]$ ip r s                                                 
10.2.2.0/24 dev enp0s8 proto kernel scope link src 10.2.1.13 metric 101 
10.2.1.0/24 via 10.2.1.254 dev enp0s8
```
On le voit bien apparaître sur la deuxième ligne.

On refait la même étape pour `server1` pour qu'il joigne `net1` en tapant la commande `sudo ip route add 10.2.2.0/24 via 10.2.2.254 dev enp0s8`. Et on recheck : 

```powershell
[vinny@server1 ~]$ ip r s
10.2.2.0/24 via 10.2.2.254 dev enp0s8 
10.2.1.0/24 dev enp0s8 proto kernel scope link src 10.2.2.11 metric 101
```

Cette fois-ci on peut le vérifier sur la première ligne.

On vérifie que ça fonctionne bien avec un ping des deux côtés :

```powershell
[vinny@client_tp3_1 ~]$ ping 10.2.2.254 -c 3
PING 10.2.2.254 (10.2.2.254) 56(84) bytes of data.
64 bytes from 10.2.2.254: icmp_seq=1 ttl=64 time=1.23 ms
64 bytes from 10.2.2.254: icmp_seq=2 ttl=64 time=1.30 ms
64 bytes from 10.2.2.254: icmp_seq=3 ttl=64 time=1.35 ms

--- 10.2.2.254 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 1.233/1.296/1.352/0.064 ms
```

Puis avec un `traceroute` : 

```powershell
[vinny@client_tp3_1 ~]$ traceroute 10.2.2.11
traceroute to 10.2.2.11 (10.2.2.11), 30 hops max, 60 byte packets
 1  gateway (10.2.1.254)  2.140 ms  1.850 ms  1.745 ms
 2  gateway (10.2.1.254)  1.361 ms !X  0.863 ms !X  2.109 ms !X
```

> client_tp3_1 vers net2

Puis : 
```powershell
[vinny@server1 ~]$ ping 10.2.1.254 -c 3
PING 10.2.1.254 (10.2.1.254) 56(84) bytes of data.
64 bytes from 10.2.1.254: icmp_seq=1 ttl=64 time=2.93 ms
64 bytes from 10.2.1.254: icmp_seq=2 ttl=64 time=1.17 ms
64 bytes from 10.2.1.254: icmp_seq=3 ttl=64 time=1.46 ms

--- 10.2.1.254 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 1.171/1.854/2.930/0.771 ms
```

De nouveau un `traceroute` :

```powershell
[vinny@server1 ~]$ traceroute 10.2.1.13
traceroute to 10.2.1.13 (10.2.1.13), 30 hops max, 60 byte packets
 1  gateway (10.2.2.254)  1.122 ms  0.488 ms  0.823 ms
 2  gateway (10.2.2.254)  0.626 ms !X  0.980 ms !X  1.009 ms !X
```

> server1 vers net1

---

### 3. Comprendre le routage

Me tape pas mais le tableau j'ai pas compris. J'aurais aimé soliciter ton aide cependant, te joindre est aussi facile que de trouver le graal. Alors bah...
Je t'ai déjà dit que les canapés gris taupe était en réduction à Ikéa en ce moment ?
---

## II. ARP
### 1. Tables ARP
#### client_tp3_1 : 

```powershell
[vinny@client_tp3_1 ~]$ ip neigh show
10.2.1.254 dev enp0s8 lladdr 08:00:27:76:e0:78 STALE
10.2.2.1 dev enp0s8 lladdr 0a:00:27:00:00:00 REACHABLE
```

#### Server1

```powershell
[vinny@server1 ~]$ ip neigh show 
10.2.2.254 dev enp0s8 lladdr 08:00:27:16:98:9d STALE
10.3.2.1 dev enp0s8 lladdr 0a:00:27:00:00:01 REACHABLE
```


#### Router

```powershell
[vinny@routèr ~]$ ip neigh show  
10.2.1.13 dev enp0s8 lladdr 08:00:27:92:14:91 STALE
10.2.2.11 dev enp0s9 lladdr 08:00:27:33:cd:4e STALE
10.2.2.1 dev enp0s8 lladdr 0a:00:27:00:00:00 REACHABLE
```

---

### 2. Requêtes ARP
#### A. Table ARP 1

Observons la table ARP vidé del famoso clienté : 

```powershell
[vinny@client_tp3_1 ~]$ sudo ip neigh flush all
[vinny@client_tp3_1 ~]$ ip neigh show          
10.2.2.1 dev enp0s8 lladdr 0a:00:27:00:00:00 REACHABLE
```
Seul le router est joignable, puis on fait un `ping 10.2.2.11 -c 3` pour envoyer des paquets a `server1`, on 'espionne' ceci avec la table ARP : 

```powershell
[vinny@client_tp3_1 ~]$ ip neigh show
10.2.1.254 dev enp0s8 lladdr 08:00:27:76:e0:78 REACHABLE
10.2.2.1 dev enp0s8 lladdr 0a:00:27:00:00:00 REACHABLE
```

On lit **REACHABLE**, ce qui veut dire que le server est **REACHABLE**.


#### B. Table ARP 2

On vide les tables ARP (encore, ça fait beaucoup là non ?) , puis : `ping 10.2.2.11 -c 3` pour afficher une nouvelle ligne dans l'ARP table :

```powershell
[vinny@server1 ~]$ ip neigh show
10.2.2.254 dev enp0s8 lladdr 08:00:27:16:98:9d REACHABLE
10.3.2.1 dev enp0s8 lladdr 0a:00:27:00:00:01 REACHABLE
```

Premiere ligne = Router ok. 
Deuxième ligne = client tu peux venir sur server.


#### C. tcpdump 1

```powershell
6	1.686093	PcsCompu_92:14:91	Broadcast	ARP	42	Who has 10.2.1.254? Tell 10.2.1.13
```

Ici le client demande qui est `10.2.1.254`, en réponse (on luit "eh ntm", parce qu'il habite dans le 9-3 (non je déconne)) : 

```powershell
8	1.687148	PcsCompu_76:e0:78	PcsCompu_92:14:91	ARP	60	10.2.1.254 is at 08:00:27:76:e0:78
```

On lui répond que `10.2.1.254` correspond à l'adresse MAC `08:00:27:76:e0:78a`


#### D. tcpdump 2

```powershell
3	19.027394	PcsCompu_16:98:9d	Broadcast	ARP	60	Who has 10.2.2.11? Tell 10.2.2.254
```

Ici `10.2.2.254` qui est la carte host-only dans le réseau `net2` demande qui est `10.2.2.11`, lui on lui propose un vodka-martini parce que c'est un parrain :

```powershell
4	19.027453	PcsCompu_33:cd:4e	PcsCompu_16:98:9d	ARP	42	10.2.2.11 is at 08:00:27:33:cd:4e
```

L'adresse MAC `08:27:00:33:cd:4e` posséde l'ip `10.2.2.11`.

#### E. (Srx c'est quoi ces noms de parties de merde... t'abuses)

SALUT, TU T'APPELLES PLUS LEO MAIS 10.2.1.13
Colissimo tu connais ? Bah la on va pas du tout s'en servir. Internet ca existe alors t'envois tes paquets de jsp quoi à `10.2.1.254` et tu t'en fous de savoir où ça part (bon ok on va dire que tu dois du pognon à Big Tony donc tu dis à 10.2.1.254 "eh..." (parce que t'es une victim <3)), et t'obtiens ça: 

```powershell
6   1.686093    PcsCompu_92:14:91   Broadcast   ARP 42  Who has 10.2.1.254? Tell 10.2.1.13
```

Du coup on te répond ceci :

```powershell
8   1.687148    PcsCompu_76:e0:78   PcsCompu_92:14:91   ARP 60  10.2.1.254 is at 08:00:27:76:e0:78
```

Voila la magnifique boite mail sur laquelle tu vas rembourser Big Tony -> `08:00:27:76:e0:78`


Big Tony recoit un mail qui dit que ses bitcoins sont prêt à être envoyé. Big Tony lui c'est 10.2.2.11, t'obtiens :

```powershell
3   19.027394   PcsCompu_16:98:9d   Broadcast   ARP 60  Who has 10.2.2.11? Tell 10.2.2.254
```

Puis on lui répond :

```powershell
4   19.027453   PcsCompu_33:cd:4e   PcsCompu_16:98:9d   ARP 42  10.2.2.11 is at 08:00:27:33:cd:4e
```

Bon en vrai je t'ai fait un scénario complétement timbré mais t'as capté.

---

## Donner un accès internet aux VMs

Tout d'abord on réactive la carte NAT du router avec la commande `sudo ifup enp0s3`
Puis on tape les commandes pour le firewall donné dans le tp.

On ping depuis client_tp3_1 :

```powershell
[vinny@client_tp3_1 ~]$ ping 8.8.8.8 -c 3
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=61 time=341 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=61 time=374 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=61 time=257 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2000ms
rtt min/avg/max/mdev = 257.252/324.338/374.104/49.253 ms
```

On pense aussi à ajouter la ligne `nameserver 1.1.1.1` dans le fichier de conf `/etc/resolv.conf` pour traduire les adresses IP en noms de domaines.

puis pour voir si ca fonctionne, t'installe qqch... (le processus d'installation faisant quelques centaines de lignes je te le colle pas ici mais je te fis un résumé) :

```powershell
Installation NGINX en cours...
100% done
Installation Nginx installée
```
---

## III. Plus de tcpdump
### 1. TCP et UDP
#### A. Warm-up

Tout d'abord sur server1 ajoute le port 8975 (parce que j'ai décidé) dans le firewall : `sudo firewall-cmd --add-port=8975/tcp --permanent` et on oublie pas de "MATRIX RELOADED"

- tape la commande `nc -l -t -p 8975` sur le server1
- tape la commande `nc -t 10.2.2.11 8975` sur le client.
Et on obtient des messages qui arrive bien de client :

```powershell
[vinny@server1 ~]$ nc -l -t -p 8975
C'est l'histoire d'un mec,
il rentre dans un bar
puis il sort in flingue,
mais il le range parce qu'il veut commander
```

On refait la même chose pour l'échange en udp.
Et on obtient des messages qui arrivent bien de client : 

```powershell
[vinny@server1 ~]$ nc -l -u -p 8975
alors il demande au barman "un coca svp"
puis le barman lui répond 
"monsieur c'est pas un bar mais une piscine municipale ici"
```

---

#### B. Analyse de trames
##### TCP

Le 3-way handshake est représenté dans les 3 trames suivantes :

```powershell
3	6.307766	10.2.1.13	10.2.2.11	TCP	74	33794 → 8975 [SYN] Seq=0 Win=29200 Len=0 MSS=1460 SACK_PERM=1 TSval=15407937 TSecr=0 WS=64

4	6.308231	10.2.2.11	10.2.1.13	TCP	74	8975 → 33794 [SYN, ACK] Seq=0 Ack=1 Win=28960 Len=0 MSS=1460 SACK_PERM=1 TSval=15403128 TSecr=15407937 WS=64

5	6.308565	10.2.1.13	10.2.2.11	TCP	66	33794 → 8975 [ACK] Seq=1 Ack=1 Win=29248 Len=0 TSval=15407946 TSecr=15403128
```

Le 3WHS, ça resssemble à ça :

- 3 : [SYN] = coucou
- 4 : [SYN, ACK] = oui, coucou
- 5 : [ACK] = oui

```powershell
6	7.991315	10.2.1.13	10.2.2.11	TCP	72	33794 → 8975 [PSH, ACK] Seq=1 Ack=1 Win=29248 Len=6 TSval=15409628 TSecr=15403128

7	7.992530	10.2.2.11	10.2.1.13	TCP	66	8975 → 33794 [ACK] Seq=1 Ack=7 Win=28992 Len=0 TSval=15404811 TSecr=15409628
```
- PSH = PUSH, cela signifie qu'on pousse la donnée
- ACK = accronyme pour "c'est bon j'ai récu ton message je t'envoie un accusé de réception"

```powershell
14	13.891859	10.2.2.11	10.2.1.13	TCP	66	8975 → 33794 [FIN, ACK] Seq=1 Ack=22 Win=28992 Len=0 TSval=15410710 TSecr=15412504

15	13.894175	10.2.1.13	10.2.2.11	TCP	66	33794 → 8975 [ACK] Seq=22 Ack=2 Win=29248 Len=0 TSval=15415532 TSecr=15410710

16	14.488857	10.2.1.13	10.2.2.11	TCP	66	33794 → 8975 [FIN, ACK] Seq=22 Ack=2 Win=29248 Len=0 TSval=15416125 TSecr=15410710

17	14.489901	10.2.2.11	10.2.1.13	TCP	66	8975 → 33794 [ACK] Seq=2 Ack=23 Win=28992 Len=0 TSval=15411309 TSecr=15416125
```

- FIN = fin, faut vraiment etre con pour pas le comprendre celui là
- ACK = re l'accronyme

##### UDP

```powershell
3	4.130183	10.2.1.13	10.2.2.11	UDP	60	41261 → 8975 Len=5

4	4.988314	10.2.1.13	10.2.2.11	UDP	60	41261 → 8975 Len=5

5	5.906879	10.2.1.13	10.2.2.11	UDP	60	41261 → 8975 Len=4
```

Coucou port 8975.

### 2. SSH

On effectue d'abord une connexion SSH depuis client_tp3_1 vers server1

```powershell
[vinny@client_tp3_1 ~]$ ssh 10.2.2.11 -p 7777
The authenticity of host '[10.2.2.11]:7777 ([10.2.2.11]:7777)' can't be established.
ECDSA key fingerprint is SHA256:bEhiDpXIH6xK352VumHVLpY1xErKvWj5D5+n9p6AiMs.
ECDSA key fingerprint is MD5:7c:d1:7e:9c:f1:35:fe:05:86:6f:f5:45:2b:f2:e9:8c.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[10.2.2.11]:7777' (ECDSA) to the list of known hosts.
vinny@10.2.2.11's password: 
Last login: [tu sauras jamais la date] from 10.3.2.1
```

On observe le tcpdump :

```powershell
3	7.486489	10.2.1.13	10.2.2.11	TCP	74	41534 → 7777 [SYN] Seq=0 Win=29200 Len=0 MSS=1460 SACK_PERM=1 TSval=23895905 TSecr=0 WS=64

4	7.487919	10.2.2.11	10.2.1.13	TCP	74	7777 → 41534 [SYN, ACK] Seq=0 Ack=1 Win=28960 Len=0 MSS=1460 SACK_PERM=1 TSval=23891093 TSecr=23895905 WS=64

5	7.488387	10.2.1.13	10.2.2.11	TCP	66	41534 → 7777 [ACK] Seq=1 Ack=1 Win=29248 Len=0 TSval=23895913 TSecr=23891093
```

On voit donc que le SSH utilise le protocole `TCP`

Voilà, un tp de finis avec moins d'humour que le précédent.
Il a démissioné mais reviendra peut être dans le prochain.

(toit pendant ce compte rendu)

![](./images/vie.jpg)