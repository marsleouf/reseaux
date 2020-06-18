# TP 4 - Cisco

*Tantantala ! Mesdames, messieurs. La SNCF sponsorise ce compte rendu. Nous vous prions de bien vouloir nous excuser pour le retard occasionné et tout les dérangement apportés par la suite. Non en vrai on s'en fout. Allé, tous en voiture on a du retard à rattraper. En route mauvais troupe !*

![](./images/piccolo3.jpeg)
![](./images/piccolo4.jpeg)


## I - Topologie 1
### 2. Mise en place
#### B. Définition d'IP statique

##### Admin uno
SELINUX, faut le désactiver. Pour ça, tu tapes sur (et non pas) ton clavier `sudo setenforce 0`,  puis tu changes la valeur dans le fichier de configuration : 
```bash
cat /etc/selinux/config
blablablablabla
SELINUX=permissive
blablablablabla
```

Pour définir une IP statique, il faut modifier le fichier de configuration `ifcfg-enp0s8` et... mais attend... ce serait pas une reprise du tp 2 ça ?
Bon bref... la suite consiste à modifier la ligne `IPADDR=10.2.1.4`.
Puis reste à définir un nom : `echo 'admin1.b1.tp4' | sudo tee /etc/hostname`


##### Routèr uno

Et comment tu fais pour voir les artes ethernet ? Eh beh en tapant ça `show ip int br`!

```bash
R1#show ip interface brief
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            unassigned      YES unset  administratively down down    
FastEthernet1/0            unassigned      YES unset  administratively down down
```

Après tu fais un petit `conf.t`pour modifier les configs de la machine

On aura besoin de `interface fastethernet 0/0` pour selectionner la carte qui nous intéresse. 

Taper sur (et toujours pas) le clavier `ip address 10.2.1.254 255.255.255.0` pour configurer l'adresse IP et lelelelele ? bah le masque de sous réseaux. 

Puis on rentre `no shut` (et pas `oh shit`(oui à 3h78 je l'ai fait(je comprenais pas pourquoi ça marchait pas))) pour dire bah... traduit littéralemet ca voudrait dire "pas de shutdown", donc on le désactiverait sauf que ça allume la carte... Me demande pas je sais pas. 

Bref reprenons `show ip int br` :

```bash
R1#show ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.2.1.254      YES manual up                    up      
FastEthernet1/0            unassigned      YES unset  administratively down down
```

Rebelotte pour l'interface `fastethernet 1/0` là où on remplacera juste l'adresse IP par `10.2.2.254`, ce qui donne :
```bash
R1#show ip int br
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.2.1.254      YES manual up                    up      
FastEthernet1/0            10.2.2.254      YES manual up                    up
```


Pour changer le nom de `R1` en `router1` on passe directement par GNS3, on clic droit sur le routeur puis `Change hostname` (ça parait tout con mais j'ai galéré à trouver).

Puis pour sauvegarder tout les changements, tu tapes sur (ET NON TOUJOURS PAS) le clavier `copy running-config startup-config`. Pas de `ctrl s`, sorry.


##### Guest uno

On ouvre la console du VPCS ou guest1 et on entre la commande `ip 10.2.2.11/24`. Voilà !
```bash
VPCS> show ip

NAME        : VPCS[1]
IP/MASK     : 10.2.2.11/24
GATEWAY     : 0.0.0.0
DNS         : 
MAC         : 00:50:79:66:68:00
LPORT       : 20007
RHOST:PORT  : 127.0.0.1:20008
MTU:        : 1500
```
`IP/MASK     : 10.2.2.11/24` 

Pis on change le nom, pis on sauvegarde.


##### Checking

Bah maintenant c'est bien bô tout ça mais faut voir si ça fonctionne. Qu'est ce que tu dirais d'un ping `guest1` vers `routèr1`?

```bash
VPCS> ping 10.2.2.254 -c 3
84 bytes from 10.2.2.254 icmp_seq=1 ttl=255 time=8.919 ms
84 bytes from 10.2.2.254 icmp_seq=2 ttl=255 time=5.091 ms
84 bytes from 10.2.2.254 icmp_seq=3 ttl=255 time=1.128 ms
```
![](./images/thicc.png)

On fait ensuite la même de `admin1` vers `router1` :

```bash
[agrorec@localhost ~]$ ping 10.2.1.254 -c 3                                                           
PING 10.2.1.254 (10.2.1.254) 56(84) bytes of data.
64 bytes from 10.2.1.254: icmp_seq=1 ttl=255 time=2.79 ms
64 bytes from 10.2.1.254: icmp_seq=2 ttl=255 time=5.94 ms
64 bytes from 10.2.1.254: icmp_seq=3 ttl=255 time=5.33 ms

--- 10.2.1.254 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 2.798/4.690/5.942/1.362 ms
```
![](./images/thicc.png)

Puis on vérifie maintenant que `routèr1` peut joindre `admin1` bien évidemment :

```bash
router1#ping 10.2.1.4

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.2.1.4, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 36/44/56 ms
```

![](./images/thicc.png)

On a faillit oublier `guest1` :

```bash
router1#ping 10.2.2.11

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.2.2.11, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 4/7/12 ms
```
....ça marche... je possèede un immense pouvoir...

Attend ! pas de conclusion rapide... continuons les vérifications :

```bash
R1#show arp
Protocol  Address          Age (min)  Hardware Addr   Type   Interface
Internet  10.2.1.4               1   0800.2746.c0ae  ARPA   FastEthernet0/0
Internet  10.2.2.11              30   0050.7966.6800  ARPA   FastEthernet1/0
Internet  10.2.1.254              -   cc01.04c0.0000  ARPA   FastEthernet0/0
Internet  10.2.2.254              -   cc01.04c0.0010  ARPA   FastEthernet1/0
```

Check l'adresse MAC de `admin1` pour voir :

```bash
[user@admin1 ~]$ ip a 
blablablablablablabla
3 : enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:46:c0:ae brd ff:ff:ff:ff:ff:ff
    inet 10.2.1.4/24 brd 10.2.1.255 scope glocal noprefixroute enp0s8
        valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe46:c0ae/64 scope link
        valid_lft forever preferred_lft forever
```

Mais c'est que ça correspond avec la table ARP tout ça.
Maintenant passons à la MAC de `guest1` :

```bash
guest1> sh

NAME   IP/MASK              GATEWAY           MAC                LPORT  RHOST:PORT
VCPS1  10.2.2.11/24         255.255.255.0     00:50:79:66:68:00  20007  127.0.0.1:20008
       fe80::250:79ff:fe66:6800/64

```
Mais c'est bon tout ça.

#### C. Routage
#### Routèr uno

```bash
R1#show ip route
Codes: C - connected, S - static, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2
       i - IS-IS, su - IS-IS summary, L1 - IS-IS level-1, L2 - IS-IS level-2
       ia - IS-IS inter area, * - candidate default, U - per-user static route
       o - ODR, P - periodic downloaded static route

Gateway of last resort is not set

     10.0.0.0/24 is subnetted, 2 subnets
C       10.2.2.0 is directly connected, FastEthernet1/0
C       10.2.1.0 is directly connected, FastEthernet0/0
```

#### Admin uno

Pour ajouter une route, prends rdv avec `/etc/sysconfig/network-scripts/route-enp0s8`et fait lui gober `10.2.2.0/24 via 10.2.1.254 dev enp0s8` quand tu l'attrpes.

```bash
[user@admin1 ~]$ ip route show
10.2.1.0/24 dev enp0s8 proto kernel scope link src 10.2.1.4 metric 101
10.2.2.0/24 via 10.2.1.254 dev enp0s8 proto static metric 101
```
la modification a donc bien été prise en compte.

#### Guest uno

```bash
guest1> ip 10.2.2.11/24 10.2.2.254
Checking for duplicate address...
PC1 : 10.2.2.11 255.255.255.0 gateway 10.2.2.254

```

#### Checking = passion

```bash
guest1> ping 10.2.1.4
84 bytes from 10.2.1.4 icmp_seq=1 ttl=63 time=31.766 ms
84 bytes from 10.2.1.4 icmp_seq=2 ttl=63 time=13.390 ms
84 bytes from 10.2.1.4 icmp_seq=3 ttl=63 time=18.808 ms
84 bytes from 10.2.1.4 icmp_seq=4 ttl=63 time=17.707 ms
^C
```
`guest1` peut joindre `admin1`

```bash
[user@admin1 ~]$ ping 10.2.2.11
PING 10.2.2.11 (10.2.2.11) 56(84) bytes of data.
64 bytes from 10.2.2.11: icmp_seq1 ttl=63 time=17.7 ms
64 bytes from 10.2.2.11: icmp_seq2 ttl=63 time=13.9 ms
64 bytes from 10.2.2.11: icmp_seq3 ttl=63 time=19.8 ms
64 bytes from 10.2.2.11: icmp_seq4 ttl=63 time=13.8 ms
^C
--- 10.2.2.11 ping statitics ---
4 packets transmitted, 4 received, 0% packet loss, time 3009ms
rtt min/avg/max/mdev = 13.861/16.340/19.813/2.552 ms
```
`admin1` arrive à joindre `guest1`.
Et si on vérifiait le passage par le routeur :

```bash
[user@admin1 ~]$ traceroute 10.2.2.11
traceroute to 10.2.2.11 (10.2.2.11), 30 hops max, 60 byte packets
1   10.2.1.254 (10.2.1.254) 10.077 ms 10.056 ms 10.044 ms
2   10.2.2.11 (10.2.2.11) 3019.029 ms **
```
Bon bah le routeur transmet bien les paquets de coke, nickel.

Comment ça c'est pas des paquets de drogue ?

## II. Topologie 2 (repris quelques jours plus tard on va pas se mentir)
### 2. Mise en place
#### C. Je t'ai déjà dit que checking = + qu'une passion ?

```bash
guest1> ping 10.2.1.4
84 bytes from 10.2.1.4 icmp_seq=1 ttl=63 time=30.250 ms
84 bytes from 10.2.1.4 icmp_seq=2 ttl=63 time=10.828 ms
84 bytes from 10.2.1.4 icmp_seq=3 ttl=63 time=15.709 ms
84 bytes from 10.2.1.4 icmp_seq=4 ttl=63 time=17.689 ms
^C
```

```bash
[user@admin1 ~]$ ping 10.2.2.11
PING 10.2.2.11 (10.2.2.11) 56(84) bytes of data.
64 bytes from 10.2.2.11: icmp_seq1 ttl=63 time=13.7 ms
64 bytes from 10.2.2.11: icmp_seq2 ttl=63 time=21.6 ms
64 bytes from 10.2.2.11: icmp_seq3 ttl=63 time=19.7 ms
64 bytes from 10.2.2.11: icmp_seq4 ttl=63 time=21.6 ms
^C
--- 10.2.2.11 ping statitics ---
4 packets transmitted, 4 received, 0% packet loss, time 3009ms
rtt min/avg/max/mdev = 13.788/19.222/21.665/3.231 ms
```

```bash
[user@admin1 ~]$ traceroute 10.2.2.11
traceroute to 10.2.2.11 (10.2.2.11), 30 hops max, 60 byte packets
1   10.2.1.254 (10.2.1.254) 8.899 ms 8.870 ms 8856 ms
2   10.2.2.11 (10.2.2.11) 3014.095 ms **
```
Le routèr fonctionne toujours. Tout est nickel, c'est propre, personne en a profité pour pénétrer mes ports... gros dégueulase je te vois.

## III. Topologie 3
### 2. Mise en place
#### B. VCPS

Rebelotte pour un `guest2` 
```bash
guest2> ip 10.2.2.12 255.255.255.0
Checking for duplicate address...
PC1 : 10.2.2.12 255.255.255.0

guest2> save
Saving startup configuration to startup.vpc
.  done
```
T'ajoutes la route :

```bash
guest2> ip 10.2.2.12/24 10.2.2.254
Checking for duplicate address...
PC1 : 10.2.2.12 255.255.255.0 gateway 10.2.2.254
```
Faut un `guest3` ?

```bash
guest3> ip 10.2.2.13 255.255.255.0
Checking for duplicate address...
PC1 : 10.2.2.13 255.255.255.0

guest3> save
Saving startup configuration to startup.vpc
.  done
guest3> ip 10.2.2.13/24 10.2.2.254
Checking for duplicate address...
PC1 : 10.2.2.13 255.255.255.0 gateway 10.2.2.254
```
Peuvent-ils joindre le réseau `admin` ?

```bash
guest2> ping 10.2.1.4
10.2.1.4 icmp_seq=1 timeout
84 bytes from 10.2.1.4 icmp_seq=2 ttl=63 time=14.700 ms
84 bytes from 10.2.1.4 icmp_seq=3 ttl=63 time=16.702 ms
84 bytes from 10.2.1.4 icmp_seq=4 ttl=63 time=13.836 ms
84 bytes from 10.2.1.4 icmp_seq=5 ttl=63 time=18.786 ms
```

```bash
guest3> ping 10.2.1.4
84 bytes from 10.2.1.4 icmp_seq=1 ttl=63 time=21.490 ms
84 bytes from 10.2.1.4 icmp_seq=2 ttl=63 time=20.619 ms
84 bytes from 10.2.1.4 icmp_seq=3 ttl=63 time=15.770 ms
84 bytes from 10.2.1.4 icmp_seq=4 ttl=63 time=14.700 ms
```
![](./images/thicc.png)

#### C. Accès WAN (et non pas dans un van... même endroit où j'ai perdu ma virginité à 5... quoi ?)

Et on mange encore de la configuration... mais en DHCP cette fois... non c'est toujours aussi long et chiant on se le cahce pas.

```bash
R1#show ip interface brief
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.2.1.254      YES NVRAM  up                    up  
FastEthernet1/0            10.2.2.254      YES NVRAM  up                    up  
FastEthernet2/0            unassigned      YES unset  administratively down down
R1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#interface FastEthernet 2/0
R1(config-if)#ip address dhcp
R1(config-if)#no shut
R1(config-if)#exit
R1(config)#exit
R1#show ip interface brief
Interface                  IP-Address      OK? Method Status                Protocol
FastEthernet0/0            10.2.1.254      YES NVRAM  up                    up  
FastEthernet1/0            10.2.2.254      YES NVRAM  up                    up  
FastEthernet2/0            192.168.122.81  YES DHCP   up                    up  
```

Met encore une configuration à faire et je te retrouve :

```bash
R1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#interface FastEthernet 0/0
R1(config-if)#ip nat inside
R1(config-if)#exit
R1(config)#interface FastEthernet 1/0
R1(config-if)#ip nat inside
R1(config-if)#exit
R1(config)#interface FastEthernet 2/0
R1(config-if)#ip nat outside

*Mar  1 00:07:07.967: %LINEPROTO-5-UPDOWN: Line protocol on Interface NVI0, changed state to up
R1(config-if)#
*Mar  1 00:07:14.699: %SYS-3-CPUHOG: Task is running for (2036)msecs, more than (2000)msecs (0/0),process = Exec.
-Traceback= 0x612C9CF4 0x612CA974 0x61292050 0x61292310 0x61292434 0x61292434 0x61293304 0x612C6154 0x612D234C 0x612BC744 0x612BD3A8 0x612BE2F8 0x60F0A454 0x6040914C 0x60425410 0x604C8600
*Mar  1 00:07:15.139: %SYS-3-CPUYLD: Task ran for (2476)msecs, more than (2000)msecs (0/0),process = Exec
R1(config-if)#exit
R1(config)#access-list 1 permit any
R1(config)#ip nat inside source list 1 interface FastEthernet 2/0 overload
R1(config)#exit
R1#
*Mar  1 00:08:22.711: %SYS-5-CONFIG_I: Configured from console by console
R1#copy running-config startup-config
Destination filename [startup-config]?
Building configuration...
[OK]
```
##### "Configurer" les clients 
(je vais te retrouver)

Begin command prompt in 3, 2, 1 :

```bash
[user@admin1 ~]$ sudo cat /etc/resolv.conf
# Generated by NetworkManager
search home tp4.network
nameserver 1.1.1.1
```
Continuation sur les VCPS :

`guest1`:
```bash
guest1> ip dns 1.1.1.1

guest1> save
Saving startup configuration to startup.vpc
.  done
```

`guest2`:
```bash
guest2> ip dns 1.1.1.1

guest2> save
Saving startup configuration to startup.vpc
.  done
```

`guest3`:
```bash
guest3> ip dns 1.1.1.1

guest3> save
Saving startup configuration to startup.vpc
.  done
```
##### Je vais me marier avec le checking là

```bash
R1#ping 8.8.8.8

Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 8.8.8.8, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 68/90/100 ms
```
`admin1`: 
```bash
[user@admin1 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=51 time=65.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=51 time=41.9 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=51 time=58.3 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=51 time=74.8 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 41.975/60.246/74.817/12.055 ms
```

`guest1`:
```bash
guest1> ping 8.8.8.8
84 bytes from 8.8.8.8 icmp_seq=1 ttl=51 time=51.333 ms
84 bytes from 8.8.8.8 icmp_seq=2 ttl=51 time=42.520 ms
8.8.8.8 icmp_seq=3 timeout
84 bytes from 8.8.8.8 icmp_seq=4 ttl=51 time=59.910 ms
```

`guest2`:
```bash
guest2> ping 8.8.8.8
84 bytes from 8.8.8.8 icmp_seq=1 ttl=51 time=63.450 ms
84 bytes from 8.8.8.8 icmp_seq=2 ttl=51 time=37.426 ms
84 bytes from 8.8.8.8 icmp_seq=3 ttl=51 time=52.628 ms
84 bytes from 8.8.8.8 icmp_seq=4 ttl=51 time=37.320 ms
```

`guest3`:
```bash
guest3> ping 8.8.8.8
84 bytes from 8.8.8.8 icmp_seq=1 ttl=51 time=41.767 ms
84 bytes from 8.8.8.8 icmp_seq=2 ttl=51 time=38.155 ms
84 bytes from 8.8.8.8 icmp_seq=3 ttl=51 time=35.236 ms
84 bytes from 8.8.8.8 icmp_seq=4 ttl=51 time=40.122 ms
```
Mais tout le monde peut appeller google, c'est franchement génial : tout le monde peut désormais se faire espionner.

**Toujours plus de vérif :**
```bash
[user@admin1 ~]$ dig www.google.com

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> www.google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10389
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1452
;; QUESTION SECTION:
;www.google.com.                        IN      A

;; ANSWER SECTION:
www.google.com.         157     IN      A       172.217.19.228

;; Query time: 32 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Mon Mar 30 12:02:17 CEST 2020
;; MSG SIZE  rcvd: 59
```
`admin1` t'as un problème ? non ? bah tant mieux.

## Topologie IV

Qui écoute sur quoi ?
Regardons tout de suite après une courte page de pub:

![](./images/bk.gif)

```bash
[user@dhcp ~]$ sudo ss -nludp
Netid State      Recv-Q Send-Q           Local Address:Port                          Peer Address:Port
udp   UNCONN     0      0                            *:67                                       *:*                   users:(("dhcpd",pid=15116,fd=8))
```

Pour faire simple : port 67 = écouté = service dhcp.


## FINITO !

(toi devant ce compte rendu)

![](./images/factor.jpeg)