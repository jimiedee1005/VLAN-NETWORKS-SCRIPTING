

{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8 scope=20 target-scope=20
add check-gateway=ping comment=to_wan2 distance=2 gateway=8.8.4.4 scope=20 target-scope=20

/ip route
add check-gateway=ping comment=to_wan1 distance=1 dst-address=8.8.8.8/32 gateway=192.168.100.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan2 distance=1 dst-address=8.8.4.4/32 gateway=192.168.200.1 scope=10 target-scope=11
}

{

}
{
/ip firewall mangle
add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=WAN1_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN2 new-connection-mark=WAN2_conn passthrough=yes

add action=mark-routing chain=prerouting connection-mark=WAN1_conn hotspot=auth new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN2_conn hotspot=auth new-routing-mark=to_wan2 passthrough=yes

add action=mark-connection chain=prerouting new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0
add action=mark-connection chain=prerouting new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1

add action=mark-routing chain=prerouting connection-mark=WAN1_conn new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN2_conn new-routing-mark=to_wan2 passthrough=yes
}

{
/ip route
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=192.168.100.1 routing-table=to_wan1 suppress-hw-offload=no
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=192.168.200.1 routing-table=to_wan2 suppress-hw-offload=no

#Create a route for each routing-mark
add distance=1 dst-address=0.0.0.0/0 gateway=192.168.100.1
add distance=2 dst-address=0.0.0.0/0 gateway=192.168.200.1
}