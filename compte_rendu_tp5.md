# TP 5 - Une topologie
## I. Toplogie 1
### 2. Adressage

Pinguons les admins entre eux :

De adm1 à adm2 :

```bash
admin1> ping 10.2.10.12 -c 3
84 bytes from 10.2.10.12 icmp_seq=1 ttl=64 time=1.380 ms
84 bytes from 10.2.10.12 icmp_seq=2 ttl=64 time=0.832 ms
84 bytes from 10.2.10.12 icmp_seq=3 ttl=64 time=0.883 ms
```

De adm2 à adm1 :

```bash
admin2> ping 10.2.10.11 -c 3
84 bytes from 10.2.10.11 icmp_seq=1 ttl=64 time=1.234 ms
84 bytes from 10.2.10.11 icmp_seq=2 ttl=64 time=0.602 ms
84 bytes from 10.2.10.11 icmp_seq=3 ttl=64 time=1.010 ms
```

On oublie pas les guests. Guest uno à guest dos :

```bash
guest1> ping 10.2.20.12 -c 3
84 bytes from 10.2.20.12 icmp_seq=1 ttl=64 time=0.613 ms
84 bytes from 10.2.20.12 icmp_seq=2 ttl=64 time=0.780 ms
84 bytes from 10.2.20.12 icmp_seq=3 ttl=64 time=0.577 ms
```

Et inversement :

```bash
guest2> ping 10.2.20.11 -c 3
84 bytes from 10.2.20.11 icmp_seq=1 ttl=64 time=0.470 ms
84 bytes from 10.2.20.11 icmp_seq=2 ttl=64 time=0.767 ms
84 bytes from 10.2.20.11 icmp_seq=3 ttl=64 time=1.418 ms
```

![](./images/thicc.png)

### 3. VLAN

Encore et toujours de la configuration (à croire qu'être ingénieur en système informatique et numérique revient à avoir BAC+5 en configuration).
Et bien passons à la configuration machines / switchs.

```bash
IOU1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
IOU1(config)#vlan 10
IOU1(config-vlan)#name admins 
IOU1(config-vlan)#exit
IOU1(config)#vlan 20
IOU1(config-vlan)#name guests
IOU1(config-vlan)#exit
IOU1(config)#interface Ethernet1/1
IOU1(config-if)#switchport mode access
IOU1(config-if)#switchport access vlan 10
IOU1(config-if)#exit
IOU1(config)#interface Ethernet1/2
IOU1(config-if)#switchport mode access
IOU1(config-if)#switchport access vlan 20
IOU1(config-if)#exit
```

Les VLAN 10 et 20 sont en mode trunk entre les switchs :

```bash
IOU1(config)#interface Ethernet0/0
IOU1(config-if)#switchport trunk encapsulation dot1q
IOU1(config-if)#switchport mode trunk
IOU1(config-if)#switchport trunk allowed vlan 10,20 
IOU1(config-if)#exit
IOU1(config)#exit
```

Puis si t'as bien lu le tp4, qu'est ce qui viens après des configs ? Les les les ??? Les VE-RI-FI-CA-TIONS !

Est ce que les admins peuvent toujours se ping ?

```bash
admin1> ping 10.2.10.12 -c 3
84 bytes from 10.2.10.12 icmp_seq=1 ttl=64 time=1.039 ms
84 bytes from 10.2.10.12 icmp_seq=2 ttl=64 time=1.209 ms
84 bytes from 10.2.10.12 icmp_seq=3 ttl=64 time=2.523 ms
```

```bash
admin2> ping 10.2.10.11 -c 3
84 bytes from 10.2.10.11 icmp_seq=1 ttl=64 time=1.154 ms
84 bytes from 10.2.10.11 icmp_seq=2 ttl=64 time=1.386 ms
84 bytes from 10.2.10.11 icmp_seq=3 ttl=64 time=2.010 ms
```

![](./images/yes.jpg)

Même question pour les guests :

```bash
guest1> ping 10.2.20.12 -c 3
84 bytes from 10.2.20.12 icmp_seq=1 ttl=64 time=1.945 ms
84 bytes from 10.2.20.12 icmp_seq=2 ttl=64 time=1.347 ms
84 bytes from 10.2.20.12 icmp_seq=3 ttl=64 time=1.628 ms
```

```bash
guest2> ping 10.2.20.11 -c 3
84 bytes from 10.2.20.11 icmp_seq=1 ttl=64 time=1.450 ms
84 bytes from 10.2.20.11 icmp_seq=2 ttl=64 time=1.896 ms
84 bytes from 10.2.20.11 icmp_seq=3 ttl=64 time=1.345 ms
```

![](./images/carl.png)

Maintenant, on va faire de l'immigration : bouger un guest du pays Guest vers le pays admin mais il n'aurait pas les droit d'un admin ni la possibiliré d'entrer en contact avec eux :

![](./images/comparaison.jpg)

```bash
guest1> ip 10.2.10.20
Checking for duplicate address...
admin1 : 10.2.10.20 255.255.255.0

guest1> ping 10.2.10.11
host (10.2.10.11) not reachable

guest1> ping 10.2.10.12
host (10.2.10.12) not reachable
```
guest1 be like :

![](./images/sadpc.jpg)


## II. Topologie 2
### 2. Adressage

Est ce qu'on ferait pas encore des vérifications ?
Bah si, puisqu'on vient de rajouter un admin number 3.

```bash
admin3> ping 10.2.10.11 -c 3
84 bytes from 10.2.10.11 icmp_seq=1 ttl=64 time=1.262 ms
84 bytes from 10.2.10.11 icmp_seq=2 ttl=64 time=1.341 ms
84 bytes from 10.2.10.11 icmp_seq=3 ttl=64 time=1.127 ms

admin3> ping 10.2.10.12 -c 3
84 bytes from 10.2.10.12 icmp_seq=1 ttl=64 time=1.163 ms
84 bytes from 10.2.10.12 icmp_seq=2 ttl=64 time=1.390 ms
84 bytes from 10.2.10.12 icmp_seq=3 ttl=64 time=0.918 ms
```

Et un guest number 3 :

```bash
guest3> ping 10.2.20.11 -c 3
84 bytes from 10.2.20.11 icmp_seq=1 ttl=64 time=2.923 ms
84 bytes from 10.2.20.11 icmp_seq=2 ttl=64 time=0.988 ms
84 bytes from 10.2.20.11 icmp_seq=3 ttl=64 time=2.046 ms

guest3> ping 10.2.20.12 -c 3
84 bytes from 10.2.20.12 icmp_seq=1 ttl=64 time=1.420 ms
84 bytes from 10.2.20.12 icmp_seq=2 ttl=64 time=0.961 ms
84 bytes from 10.2.20.12 icmp_seq=3 ttl=64 time=0.920 ms
```
Et ça fonctionne !

![](./images/ohouais.jpg)

### 3. VLAN

On va pas se fouler, le troisième switch sera une pâle copie des deux premier :

```bash
IOU1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
IOU1(config)#vlan 10
IOU1(config-vlan)#name admins 
IOU1(config-vlan)#exit
IOU1(config)#vlan 20
IOU1(config-vlan)#name guests
IOU1(config-vlan)#exit
IOU1(config)#interface Ethernet1/1
IOU1(config-if)#switchport mode access
IOU1(config-if)#switchport access vlan 10
IOU1(config-if)#exit
IOU1(config)#interface Ethernet1/2
IOU1(config-if)#switchport mode access
IOU1(config-if)#switchport access vlan 20
IOU1(config-if)#exit
```

Et on switch ("switch" mdrrr tu l'as ? t'as compris ?) les vlans 10 et 20 en mode trunk :

```bash
IOU1(config)#interface Ethernet0/0
IOU1(config-if)#switchport trunk encapsulation dot1q
IOU1(config-if)#switchport mode trunk
IOU1(config-if)#switchport trunk allowed vlan 10,20 
IOU1(config-if)#exit
IOU1(config)#exit
```

Tu sais ce qu'on va faire ? On va refaire de l'immigration :

```bash
guest3> ping 10.2.10.11
host (10.2.10.11) not reachable

guest3> ping 10.2.10.12
host (10.2.10.12) not reachable

guest3> ping 10.2.10.13
host (10.2.10.13) not reachable
```

### 4. Sous-interfaces

Je mange de la configuration, je bois de la configuration, je ch** de la configuration :

```bash
R1#conf t   
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#interface fastEthernet0/0.10
R1(config-subif)#encapsulation dot1q 10
R1(config-subif)#ip address 10.2.10.254 255.255.255.0
R1(config-subif)#exit
R1(config)#interface fastEthernet0/0.20
R1(config-subif)#encapsulation dot1q 20
R1(config-subif)#ip address 10.2.20.254 255.255.255.0
R1(config-subif)#exit
R1(config)#interface FastEthernet0/0
R1(config-if)#no shut
R1(config-if)#exit
```


Puis suite logique de la configuration, la checkifigation :

```bash
admin1> ping 10.2.10.254 -c 3
84 bytes from 10.2.10.254 icmp_seq=1 ttl=255 time=17.372 ms
84 bytes from 10.2.10.254 icmp_seq=2 ttl=255 time=16.950 ms
84 bytes from 10.2.10.254 icmp_seq=3 ttl=255 time=17.211 ms
```

```bash
guest3> ping 10.2.20.254 -c 3
84 bytes from 10.2.20.254 icmp_seq=1 ttl=255 time=18.996 ms
84 bytes from 10.2.20.254 icmp_seq=2 ttl=255 time=17.041 ms
84 bytes from 10.2.20.254 icmp_seq=3 ttl=255 time=18.065 ms
```

And it works well.


Et si on poussait le délire jusqu'au bout avec l'immigration ? Non ? Bah on le fait quand même.

```bash
guest3> ip 10.2.10.20
Checking for duplicate address...
PC1 : 10.2.10.20 255.255.255.0

guest3> ping 10.2.10.11
host (10.2.10.11) not reachable
```

### 5. NAT

... (configuration)

```bash
R1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#interface FastEthernet0/0.10
R1(config-subif)#ip nat inside
R1(config-subif)#exit
R1(config)#interface FastEthernet0/0.20
R1(config-subif)#ip nat inside
R1(config-subif)#exit
R1(config)#interface FastEthernet1/0
R1(config-if)#ip nat outside
R1(config-if)#exit
R1(config)#access-list 1 permit any
R1(config)#ip nat inside source list 1 interface fastEthernet1/0 overload
R1(config)#exit
R1(config)#interface FastEthernet1/0
R1(config-if)#ip address dhcp
R1(config-if)#no shut
R1(config-if)#exit
R1(config)#exit
```

AH, AH, autre chose quede la config ? Ah bah non.

```bash
admin1> ip 10.2.10.11/24 10.2.10.254
Checking for duplicate address...
PC1 : 10.2.10.11 255.255.255.0 gateway 10.2.10.254
```
Eh google ? Je peux t'espionner ? Ah non c'est vrai c'est toi qui le fait :

```bash
admin1> ping 8.8.8.8 -c 3
84 bytes from 8.8.8.8 icmp_seq=1 ttl=51 time=39.649 ms
84 bytes from 8.8.8.8 icmp_seq=2 ttl=51 time=38.589 ms
84 bytes from 8.8.8.8 icmp_seq=3 ttl=51 time=46.478 ms
```

## Topologie 3 
### 3. Serveur dhcp

Et un config IP dynamiquement sur le VPC de guest tres, une !

```bash
guest3> ip dhcp
DDORA 
IP 10.2.20.100/24 GW 10.2.20.254
```

IP + gateway = cOnFiGuRaTiOn automatique.

### 4. Webeuh

Let's go tester la topologie en serveur web (quoi ? c'était pas ça l'énoncé ?) :

```bash
[user@web ~]$ curl localhost:80
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>Welcome to CentOS</title>
  <style rel="stylesheet" type="text/css">
  [...]
</div>


</body>
</html>
```

Je viens de faire l'équivalent d'un cat hein, rien de fortiche, range le champomi. 

Tu aimes les vérifications sur toutes les machines ? Moi j'aime les vérifications sur toutes les machines.

```bash
[user@dns ~]$ curl 10.2.30.12:80
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>Welcome to CentOS</title>
  <style rel="stylesheet" type="text/css">
  [...]
</div>


</body>
</html>
```

![](./images/niiice.gif)

### 5. Serveur DNS

Là on fait du serveur web. Tout d'abbord, les ports écoutés :

```bash
[user@dns ~]$ sudo ss -ltunp
[sudo] password for user:
Netid State      Recv-Q Send-Q           Local Address:Port                          Peer Address:Port
udp   UNCONN     0      0                   10.2.30.11:53                                       *:*                   users:(("named",pid=1543,fd=513))
udp   UNCONN     0      0                    127.0.0.1:53                                       *:*                   users:(("named",pid=1543,fd=512))
udp   UNCONN     0      0                            *:68                                       *:*                   users:(("dhclient",pid=850,fd=6))
udp   UNCONN     0      0                        [::1]:53                                    [::]:*                   users:(("named",pid=1543,fd=514))
tcp   LISTEN     0      128                          *:22                                       *:*                   users:(("sshd",pid=1066,fd=3))
tcp   LISTEN     0      128                  127.0.0.1:953                                      *:*                   users:(("named",pid=1543,fd=24))
tcp   LISTEN     0      100                  127.0.0.1:25                                       *:*                   users:(("master",pid=1304,fd=13))
tcp   LISTEN     0      10                  10.2.30.11:53                                       *:*                   users:(("named",pid=1543,fd=22))
tcp   LISTEN     0      10                   127.0.0.1:53                                       *:*                   users:(("named",pid=1543,fd=21))
tcp   LISTEN     0      128                       [::]:22                                    [::]:*                   users:(("sshd",pid=1066,fd=4))
tcp   LISTEN     0      128                      [::1]:953                                   [::]:*                   users:(("named",pid=1543,fd=25))
tcp   LISTEN     0      100                      [::1]:25                                    [::]:*                   users:(("master",pid=1304,fd=14))
tcp   LISTEN     0      10                       [::1]:53                                    [::]:*                   users:(("named",pid=1543,fd=23))
```

Euh... euh... euh... FIREWALL ! AUTORISE MOI DES PORTS ALEATOIRES §

```bash
[rootultra] yes master
processing ...
100% done
enable auto writing
[user@dns ~]$ sudo firewall-cmd --add-port=953/tcp --permanent
success
[user@dns ~]$ sudo firewall-cmd --add-port=53/udp --permanent
success
[user@dns ~]$ sudo firewall-cmd --reload
success
```

Merci firewall. Continue le TP pour moi.

```bash
[rootultra] as you wish King_marselouf
enable auto complete
100% done

guest3> ip dns 10.2.30.11

guest3> ping google.com
google.com resolved to 216.58.215.46
84 bytes from 216.58.215.46 icmp_seq=1 ttl=51 time=42.341 ms
84 bytes from 216.58.215.46 icmp_seq=2 ttl=51 time=39.684 ms
84 bytes from 216.58.215.46 icmp_seq=3 ttl=51 time=41.753 ms
84 bytes from 216.58.215.46 icmp_seq=4 ttl=51 time=45.164 ms

```

Alors... Pour ce qui suit j'ai fait l'appel à un ami.

```bash
zone "20.5.10.in-addr.arpa" IN {

          type master;                                                                                                  
          file "/var/named/20.5.10.db";

          allow-update { none; };
};

zone "10.2.10.in-addr.arpa" IN {

          type master;
          file "/var/named/10.2.10.db";

          allow-update { none; };
};
```
 
```bash
allow-query        { 10.2.10.0/24; 10.2.20.0/24; 10.2.30.0/24; };
```
 
```bash
[user@dhcp ~]$ sudo cat /etc/dhcp/dhcpd.conf
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp*/dhcpd.conf.example see dhcpd.conf(5) man page
#
# DHCP lease lifecycle
default-lease-time 600;
max-lease-time 7200;
# This server is the only DHCP server we got So it is the authoritative one
authoritative;
# Configure logging
log-facility local7;
# Actually configure the DHCP server to serve our network
subnet 10.2.20.0 netmask 255.255.255.0 {
  # IPs that our DHCP server can give to client
  range 10.2.20.100 10.2.20.150;
  # Domain name served and DNS server (optional) The DHCP server gives this info to clients
  option domain-name "tp5.network";
  option domain-name-servers 10.2.3.11;
  # Gateway of the network (optional) The DHCP server gives this info to clients
  option routers 10.2.20.254;
  # Specify broadcast addres of the network (optional)
  option broadcast-address 10.2.20.255;
}
[user@dhcp ~]$ sudo systemctl restart dhcpd
```

Je vais être franc... je serais incapable de le refaire. Il l'a fait en m'expliquant mais j'ai pas tout capté.

## Pour aller plus loin...
### DHCP Snoop Dog

```bash
IOU3#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
IOU3(config)#ip dhcp snooping
IOU3(config)#ip dhcp snooping vlan 10
IOU3(config)#ip dhcp snooping vlan 20
IOU3(config)#ip dhcp snooping vlan 30
```

On autorise le Snoopy :

```bash
IOU3(config)#interface Ethernet 0/3
IOU3(config-if)#ip dhcp snooping trust
IOU3(config-if)#exit
IOU3(config)#exit
IOU3#
*Apr 12 19:24:59.090: %SYS-5-CONFIG_I: Configured from console by console
IOU3#show ip dhcp snooping
Switch DHCP snooping is enabled
Switch DHCP gleaning is disabled
DHCP snooping is configured on following VLANs:
10,20,30
DHCP snooping is operational on following VLANs:
10,20,30
DHCP snooping is configured on the following L3 Interfaces:

Insertion of option 82 is enabled
   circuit-id default format: vlan-mod-port
   remote-id: aabb.cc00.0300 (MAC)
Option 82 on untrusted port is not allowed
Verification of hwaddr field is enabled
Verification of giaddr field is enabled
DHCP snooping trust/rate is configured on the following Interfaces:

Interface                  Trusted    Allow option    Rate limit (pps)
-----------------------    -------    ------------    ----------------
Ethernet0/3                yes        yes             unlimited
  Custom circuit-ids:
```
```bash
[rootultra] server located on Ethernet 0/3
enable DHCP snooping on Ethernet 0/3
processing ...
100% done

Finished !
```