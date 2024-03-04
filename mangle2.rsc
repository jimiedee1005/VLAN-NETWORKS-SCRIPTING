
{{/user add comment="pnpradius user" group=full name=pnpradius password="wIp592tp47H%"
}

{
/ip firewall filter
add action=accept chain=forward src-address-list=allowed
add action=drop chain=forward src-address-list=blocked
/ip firewall address-list add address=10.30.40.2/30 list=blocked
/ip firewall address-list add address=182.50.60.2/30 list=blocked
}

/ip firewall address-list add address=2.2.0.0/16 list=blocked
/ip firewall address-list add address=182.2.0.0/16 list=blocked 
/ip firewall address-list add address=101.101.0.0/16 list=blocked
/ip firewall address-list add address=100.80.0.0/16 list=blocked
/ip firewall address-list add address=102.102.0.0/16 list=blocked
/ip firewall address-list add address=199.50.0.0/16 list=blocked
/ip firewall address-list add address=192.10.0.0/16 list=blocked
/ip firewall address-list add address=172.168.0.0/16 list=blocked
/ip firewall address-list add address=180.180.0.0/16 list=blocked
/ip firewall address-list add address=177.177.0.0/16 list=blocked
/ip firewall address-list add address=174.174.0.0/16 list=blocked
/ip firewall address-list add address=172.172.0.0/16 list=blocked
/ip firewall address-list add address=169.169.0.0/16 list=blocked
/ip firewall address-list add address=164.164.0.0/16 list=blocked
/ip firewall address-list add address=162.162.0.0/16 list=blocked
/ip firewall address-list add address=161.161.0.0/16 list=blocked
/ip firewall address-list add address=160.160.0.0/16 list=blocked
/ip firewall address-list add address=146.146.0.0/16 list=blocked
/ip firewall address-list add address=135.135.0.0/16 list=blocked
/ip firewall address-list add address=130.130.0.0/16 list=blocked
/ip firewall address-list add address=103.103.0.0/16 list=blocked
/ip firewall address-list add address=100.100.0.0/16 list=blocked
/ip firewall address-list add address=98.98.0.0/16 list=blocked
/ip firewall address-list add address=97.97.0.0/16 list=blocked
/ip firewall address-list add address=57.57.0.0/16 list=blocked
/ip firewall address-list add address=53.53.0.0/16 list=blocked
/ip firewall address-list add address=47.47.0.0/16 list=blocked
/ip firewall address-list add address=37.37.0.0/16 list=blocked
/ip firewall address-list add address=35.35.0.0/16 list=blocked
/ip firewall address-list add address=34.34.0.0/16 list=blocked
/ip firewall address-list add address=20.20.0.0/16 list=blocked
/ip firewall address-list add address=18.18.0.0/16 list=blocked
/ip firewall address-list add address=7.7.0.0/16 list=blocked
/ip firewall address-list add address=6.6.0.0/16 list=blocked
/ip firewall address-list add address=5.5.0.0/16 list=blocked
/ip firewall address-list add address=3.3.0.0/16 list=blocked
/ip firewall address-list add address=1.1.0.0/16 list=blocked
/ip firewall address-list add address=155.155.0.0/16 list=blocked
/ip firewall address-list add address=165.165.0.0/16 list=blocked
/ip firewall address-list add address=156.156.0.0/16 list=blocked
/ip firewall address-list add address=149.149.0.0/16 list=blocked
/ip firewall address-list add address=147.147.0.0/16 list=blocked
/ip firewall address-list add address=140.140.0.0/16 list=blocked
/ip firewall address-list add address=136.136.0.0/16 list=blocked
/ip firewall address-list add address=125.125.0.0/16 list=blocked
/ip firewall address-list add address=124.124.0.0/16 list=blocked
/ip firewall address-list add address=121.121.0.0/16 list=blocked
/ip firewall address-list add address=96.96.0.0/16 list=blocked
/ip firewall address-list add address=45.45.0.0/16 list=blocked
/ip firewall address-list add address=87.87.0.0/16 list=blocked
/ip firewall address-list add address=82.82.0.0/16 list=blocked
/ip firewall address-list add address=69.69.0.0/16 list=blocked
/ip firewall address-list add address=41.41.0.0/16 list=blocked
/ip firewall address-list add address=40.40.0.0/16 list=blocked
/ip firewall address-list add address=28.28.0.0/16 list=blocked
/ip firewall address-list add address=24.24.0.0/16 list=blocked
/ip firewall address-list add address=22.22.0.0/16 list=blocked
/ip firewall address-list add address=19.19.0.0/16 list=blocked
/ip firewall address-list add address=14.14.0.0/16 list=blocked
/ip firewall address-list add address=13.13.0.0/16 list=blocked
/ip firewall address-list add address=11.11.0.0/16 list=blocked
/ip firewall address-list add address=9.9.0.0/16 list=blocked
/ip firewall address-list add address=4.4.0.0/16 list=blocked
/ip firewall address-list add address=43.43.0.0/16 list=blocked
/ip firewall address-list add address=168.168.0.0/16 list=blocked
/ip firewall address-list add address=104.104.0.0/16 list=blocked
/ip firewall address-list add address=39.39.0.0/16 list=blocked
/ip firewall address-list add address=38.38.0.0/16 list=blocked
/ip firewall address-list add address=67.67.0.0/16 list=blocked
/ip firewall address-list add address=10.30.0.0/16 list=blocked
}



{
/ip firewall mangle
add action=mark-connection chain=prerouting comment=stat new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=src-address-and-port:3/0 src-address=172.16.0.0/16
add action=mark-connection chain=prerouting comment=stat new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=src-address-and-port:3/1 src-address=172.16.0.0/16
add action=mark-connection chain=prerouting comment=stat new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=src-address-and-port:3/2 src-address=172.16.0.0/16
add action=mark-connection chain=prerouting comment=stat new-connection-mark=WAN4_conn passthrough=yes per-connection-classifier=src-address-and-port:4/3 src-address=172.16.0.0/16
add action=mark-routing chain=prerouting comment=stat connection-mark=WAN1_conn new-routing-mark=to_wan1 passthrough=yes src-address=172.16.0.0/16
add action=mark-routing chain=prerouting comment=stat connection-mark=WAN2_conn new-routing-mark=to_wan2 passthrough=yes src-address=172.16.0.0/16
add action=mark-routing chain=prerouting comment=stat connection-mark=wan2_conn new-routing-mark=to_wan2 passthrough=yes src-address=172.16.0.0/16
add action=mark-routing chain=prerouting comment=stat connection-mark=WAN4_conn new-routing-mark=to_wan4 passthrough=yes src-address=172.16.0.0/16
}


{
/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2

/ip firewall mangle
add action=mark-connection chain=prerouting comment=wan1 dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0 src-address=10.10.6.0/24
add action=mark-connection chain=prerouting comment=wan2 dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1 src-address=10.10.6.0/24

add action=mark-routing chain=prerouting connection-mark=wan1_conn new-routing-mark=to_wan1 passthrough=yes src-address=10.10.6.0/24
add action=mark-routing chain=prerouting connection-mark=wan2_conn new-routing-mark=to_wan2 passthrough=yes src-address=10.10.6.0/24

}