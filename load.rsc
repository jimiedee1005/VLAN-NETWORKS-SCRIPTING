# jul/17/2023 09:58:29 by RouterOS 6.48.7
# software id = 48ZB-7RDF
#
# model = RB3011UiAS
# serial number = HCG085RQNFN

{
/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.150.0/24 in-interface=WAN1
add action=accept chain=prerouting dst-address=192.168.100.0/24 in-interface=WAN2
add action=accept chain=prerouting dst-address=192.168.88.0/24 in-interface=WAN3
add action=accept chain=prerouting dst-address=10.0.0.0/24
add action=accept chain=prerouting dst-address=172.0.0.0/8
add action=accept chain=prerouting dst-address=10.134.0.0/24
}


{
/ip firewall mangle
add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=WAN1_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN2 new-connection-mark=WAN2_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN3 new-connection-mark=WAN3_conn passthrough=yes

add action=mark-connection chain=prerouting new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0
add action=mark-connection chain=prerouting new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1
add action=mark-connection chain=prerouting new-connection-mark=WAN3_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/2

/ip firewall mangle
add action=mark-routing chain=prerouting connection-mark=WAN1_conn dst-address-type=!local new-routing-mark=to_wan1 passthrough=yes 
add action=mark-routing chain=prerouting connection-mark=WAN2_conn dst-address-type=!local new-routing-mark=to_wan2 passthrough=yes 
add action=mark-routing chain=prerouting connection-mark=WAN3_conn dst-address-type=!local new-routing-mark=to_wan1 passthrough=yes 
}