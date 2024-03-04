{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8  scope=20 target-scope=20 
add check-gateway=ping comment=to_wan5 distance=1 gateway=8.8.4.4  scope=20 target-scope=20 

}

{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8 scope=20 target-scope=20
add check-gateway=ping comment=to_wan5 distance=2 gateway=8.8.4.4 scope=20 target-scope=20

}

{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 dst-address=8.8.8.8/32 gateway=192.168.100.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan5 distance=1 dst-address=8.8.4.4/32 gateway=192.168.31.1 scope=10 target-scope=11

}


{
/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.100.1/24 in-interface=WAN1
add action=accept chain=prerouting dst-address=192.168.31.1/24 in-interface=WAN5
add action=accept chain=prerouting dst-address=172.0.1.0/24
add action=accept chain=prerouting dst-address=10.10.20.0/24
add action=accept chain=prerouting dst-address=10.136.0.83/24
}





{
/ip firewall mangle
add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=WAN1_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN5 new-connection-mark=WAN5_conn passthrough=yes

add action=mark-routing chain=prerouting connection-mark=WAN1_conn hotspot=auth new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN5_conn hotspot=auth new-routing-mark=to_wan5 passthrough=yes

add action=mark-connection chain=prerouting new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0
add action=mark-connection chain=prerouting new-connection-mark=WAN5_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1
/ip firewall mangle
add action=mark-routing chain=prerouting connection-mark=WAN1_conn new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN5_conn new-routing-mark=to_wan5 passthrough=yes

}

