# jul/17/2023 09:58:29 by RouterOS 6.48.7
# software id = 48ZB-7RDF
#
# model = RB3011UiAS
# serial number = HCG085RQNFN



{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8  scope=20 target-scope=20 
add check-gateway=ping comment=to_wan5 distance=1 gateway=8.8.4.4  scope=20 target-scope=20 
add check-gateway=ping comment=to_wan3 distance=1 gateway=9.9.9.9  scope=20 target-scope=20 
add check-gateway=ping comment=to_wan4 distance=1 gateway=1.1.1.1 scope=20 target-scope=20 
}

{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8 scope=20 target-scope=20
add check-gateway=ping comment=to_wan5 distance=2 gateway=8.8.4.4 scope=20 target-scope=20
add check-gateway=ping comment=to_wan3 distance=3 gateway=9.9.9.9 scope=20 target-scope=20
add check-gateway=ping comment=to_wan4 distance=4 gateway=1.1.1.1 scope=20 target-scope=20

}

{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 dst-address=8.8.8.8/32 gateway=173.29.10.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan5 distance=1 dst-address=8.8.4.4/32 gateway=172.92.10.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan3 distance=1 dst-address=9.9.9.9/32 gateway=173.29.10.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan4 distance=1 dst-address=1.1.1.1/32 gateway=172.73.10.1 scope=10 target-scope=11

}


{
/ip firewall mangle
add action=accept chain=prerouting dst-address=173.29.10.1/24 in-interface=WAN1
add action=accept chain=prerouting dst-address=172.92.10.1/24 in-interface=WAN5
add action=accept chain=prerouting dst-address=173.29.10.0/24 in-interface=WAN3
add action=accept chain=prerouting dst-address=172.73.10.1/24 in-interface=WAN4
add action=accept chain=prerouting dst-address=10.254.0.0/16



}



{
/ip firewall mangle
add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=WAN1_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN5 new-connection-mark=wan5_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN3 new-connection-mark=WAN3_conn passthrough=yes
/ip firewall mangle
add action=mark-connection chain=input in-interface=WAN5 new-connection-mark=WAN5_conn passthrough=yes



add action=mark-routing chain=prerouting connection-mark=WAN1_conn hotspot=auth new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=wan5_conn hotspot=auth new-routing-mark=to_wan5 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN3_conn hotspot=auth new-routing-mark=to_wan3 passthrough=yes
/ip firewall mangle
add action=mark-routing chain=prerouting connection-mark=WAN5_conn hotspot=auth new-routing-mark=to_wan4 passthrough=yes





add action=mark-connection chain=prerouting new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/0
add action=mark-connection chain=prerouting new-connection-mark=wan5_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/1
add action=mark-connection chain=prerouting new-connection-mark=WAN3_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/2
add action=mark-connection chain=prerouting new-connection-mark=WAN4_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/3


add action=mark-routing chain=prerouting connection-mark=WAN1_conn new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=wan5_conn new-routing-mark=to_wan5 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN3_conn new-routing-mark=to_wan4 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN4_conn new-routing-mark=to_wan5 passthrough=yes



}


{
/ip route
add check-gateway=ping comment=to_wan5 disabled=yes distance=1 gateway=\
  105.27.232.2 routing-mark=to_wan5

add check-gateway=ping comment=to_wan5 distance=1 gateway=105.27.232.2
}


/ip firewall mangle
add action=mark-routing chain=prerouting connection-state="" disabled=yes new-routing-mark=to_wan2 passthrough=no src-address-list=BUSINESS
add action=mark-routing chain=prerouting connection-state="" disabled=yes new-routing-mark=to_wan1 passthrough=no src-address-list=HOTSPOT
