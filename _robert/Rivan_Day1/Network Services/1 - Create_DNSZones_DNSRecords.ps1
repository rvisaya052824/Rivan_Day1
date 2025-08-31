add-DnsServerPrimaryZone -Name "ngcpM.ph" -ZoneFile "NGCP12.com.dns"
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name ns  -ipv4address 10.m.1.7

add-DnsServerResourceRecord -zonename ngcpM.ph -Cname -name www -hostname ns.ngcpM.ph
add-DnsServerResourceRecord -zonename ngcpM.ph -Cname -name imap -hostname ns.ngcpM.ph
add-DnsServerResourceRecord -zonename ngcpM.ph -Cname -name pop -hostname ns.ngcpM.ph
add-DnsServerResourceRecord -zonename ngcpM.ph -Cname -name smtp -hostname ns.ngcpM.ph

add-DnsServerResourceRecord -zonename ngcpM.ph -A -name cb  -ipv4address 10.m.1.4
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name ct  -ipv4address 10.m.1.2
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name cm  -ipv4address 10.m.100.8
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name ed  -ipv4address 10.m.m.1
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name p1  -ipv4address 10.m.100.101
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name p2  -ipv4address 10.m.100.102
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name c1  -ipv4address 10.m.50.6
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name c2  -ipv4address 10.m.50.8
add-DnsServerResourceRecord -zonename ngcpM.ph -A -name ap  -ipv4address 10.m.10.3
