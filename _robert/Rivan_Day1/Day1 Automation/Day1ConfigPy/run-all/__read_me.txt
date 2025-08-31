
==========================================

Find and Replace ( ctrl + h ): 

	#$34T# = Your monitor number

Replace all ( ctrl + alt + enter)

==========================================




=====| STEP 1 - Add routing to PC

@command prompt
route add 10.0.0.0 mask 255.0.0.0 10.#$34T#.1.4
route add 200.0.0.0 mask 255.255.255.0 10.#$34T#.1.4


=====| STEP 2 - Add ip address and routing to device

@coreTaas
conf t
 int vlan 1
  no shut
  ip add 10.#$34T#.1.2 255.255.255.0
  desc mgmtData-configuredManually
  exit
  enable secret pass
 line vty 0 14
  password pass
  transport input all
  login
  exec-timeout 0 0
  end

@coreBaba
conf t
 int vlan 1
  no shut
  ip add 10.#$34T#.1.4 255.255.255.0
  desc mgmtData-configuredManually
  exit
 vlan 100
  name VOICEVLAN
  exit
 int vlan 100
  no shut
  ip add 10.#$34T#.100.4 255.255.255.0
  desc vlanMgmtVoice-configuredManually
  exit
 int fa 0/3
  sw mo ac
  sw ac vlan 100
  exit
 int gi0/1
  no switchport
  no shut 
  ip add 10.#$34T#.#$34T#.4 255.255.255.0
  exit
 ip routing
 ip route 0.0.0.0 0.0.0.0 10.#$34T#.#$34T#.1 120
 enable secret pass
 line vty 0 14
  password pass
  transport input all
  login
  exec-timeout 0 0
  end

@cucm
conf t
 int fa0/0
  no shut
  ip add 10.#$34T#.100.8 255.255.255.0
  exit
 ip routing
 ip route 0.0.0.0 0.0.0.0 10.#$34T#.100.4 120
 enable secret pass
 line vty 0 14
  password pass
  transport input all
  login
  exec-timeout 0 0
  end

@edge
conf t
 int gi 0/0/0
  ip add 10.#$34T#.#$34T#.1 255.255.255.0
  no shut
  exit
 ip routing
 ip route 10.#$34T#.0.0 255.255.0.0 10.#$34T#.#$34T#.4 120
 enable secret pass
 line vty 0 14
  password pass
  transport input all
  login
  exec-timeout 0 0
  end


=====| Step 3 - Telnet to each device

On SecureCRT:

	10.#$34T#.1.2		CoreTaas
	10.#$34T#.1.4		CoreBaba
	10.#$34T#.100.8		CUCM
	10.#$34T#.#$34T#.1	EDGE


=====| Step 4 - Note MAC Addresses

@CoreBaba
sh mac address-table

Camera 6 MAC Address (fa0/6):   replaceMe
Camera 8 MAC Address (fa0/8):   replaceMe
Ephone 1 MAC Address (fa0/5):   replaceMe
Ephone 2 MAC Address (fa0/7):   replaceMe


=====| Step 4 - Enable SSH

For an SSH connection to be established, the device must have:
    - a non-default hostname         hostname coreBaba#$34T#
    - a domain name                  ip domain name day1lab.com
    - a local user account           username admin privilege 15 secret pass
    - generated crypto keys          crypto key generate rsa modulus 2048
    - SSH enabled                    ip ssh version 2
    - enable remote access           transport input all
    - enable remote user/pass login  login local

Extra lines
    - password encryption            service password-encryption
    - no logs                        no logging console
    - no domain lookups              no ip domain-lookup
    - no timeout                     exec-timeout 0 0



@coreTaas
conf t
 hostname coreTaas-#$34T#
 service password-encryption
 no logging console
 no ip domain-lookup
 ip domain name autoday1.com
 username admin privilege 15 secret pass
 line vty 0 14
  transport input all
  login local
  exec-timeout 0 0
  exit
 crypto key generate rsa modulus 2048 label devs
 ip ssh rsa keypair-name devs
 ip ssh version 2
 end
 
 
@coreBaba
conf t
 hostname coreBaba-#$34T#
 service password-encryption
 no logging console
 no ip domain-lookup
 ip domain name autoday1.com
 username admin privilege 15 secret pass
 line vty 0 14
  transport input all
  login local
  exec-timeout 0 0
  exit
 crypto key generate rsa modulus 2048 label devs
 ip ssh rsa keypair-name devs
 ip ssh version 2
 end
 

@cucm
conf t
 hostname cucm-#$34T#
 service password-encryption
 no logging console
 no ip domain-lookup
 ip domain name autoday1.com
 username admin privilege 15 secret pass
 line vty 0 14
  transport input all
  login local
  exec-timeout 0 0
 crypto key generate rsa modulus 2048 label devs
 ip ssh rsa keypair-name devs
 ip ssh version 2
 end

@edge
conf t
 hostname edge-#$34T#
 service password-encryption
 no logging console
 no ip domain-lookup
 ip domain name autoday1.com
 username admin privilege 15 secret pass
 line vty 0 14
  transport input all
  login local
  exec-timeout 0 0
 crypto key generate rsa modulus 2048 label devs
 ip ssh rsa keypair-name devs
 ip ssh version 2
 end



=====| Step 4 - Run main.py
