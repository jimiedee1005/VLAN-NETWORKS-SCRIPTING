{
{
#IP Addresses
#The router has two upstream (ISP) interfaces with the addresses of ether_ISP100/24 and ether_ISP200/24. The LAN interface has IP address of 192.168.0.1/24.
/ip address
add address=ether_ISP100/24 interface=ether_ISP1 network=10.10.4.0
add address=ether_ISP200/24 interface=ether_ISP2 network=10.10.5.0
add address=192.168.100.1/24 interface=ether_LAN network=192.168.100.0
}

#We are adding two new Routing tables, which will be used later:
{
/routing table
add disabled=no fib name=ISP1_table
add disabled=no fib name=ISP2_table
add disabled=no fib name=ISP3_table
}
}
#Policy routing
{
{
/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.248.133/24 in-interface=ether_LAN
add action=accept chain=prerouting dst-address=192.168.122.87/24 in-interface=ether_LAN
add action=accept chain=prerouting dst-address=192.168.126.138/24 in-interface=ether_LAN
}
#To avoid this situation we need to allow usage of default routing table for traffic to connected networks.
{
add action=mark-connection chain=input connection-state=new in-interface=ether_ISP1 new-connection-mark=ISP1
add action=mark-connection chain=input connection-state=new in-interface=ether_ISP2 new-connection-mark=ISP2
add action=mark-connection chain=input connection-state=new in-interface=ether_ISP3 new-connection-mark=ISP3

add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=ISP1 passthrough=yes per-connection-classifier=both-addresses:3/0
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=ISP2 per-connection-classifier=both-addresses:3/1
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=ISP3 per-connection-classifier=both-addresses:3/2
}
}
{
#We will mark all new incoming connections, to remember what was the interface.
{
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=ether_LAN new-connection-mark=ISP1 per-connection-classifier=both-addresses:3/0
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=ether_LAN new-connection-mark=ISP2 per-connection-classifier=both-addresses:3/2
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=ether_LAN new-connection-mark=ISP3 per-connection-classifier=both-addresses:3/1
}
#PCC we will divide traffic into two groups based on source and destination addressees.
{
add action=mark-routing chain=output connection-mark=ISP1 new-routing-mark=ISP1_table
add action=mark-routing chain=prerouting connection-mark=ISP1 in-interface=ether_LAN new-routing-mark=ISP1_table
add action=mark-routing chain=output connection-mark=ISP2 new-routing-mark=ISP2_table
add action=mark-routing chain=prerouting connection-mark=ISP2 in-interface=ether_LAN new-routing-mark=ISP2_table
add action=mark-routing chain=output connection-mark=ISP3 new-routing-mark=ISP3_table
add action=mark-routing chain=prerouting connection-mark=ISP3 in-interface=ether_LAN new-routing-mark=ISP3_table
}
#Then we need to mark all packets from those connections with a proper mark
{
/ip route
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=ether_ISP1 routing-table=ISP1_table suppress-hw-offload=no
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=ether_ISP2 routing-table=ISP2_table suppress-hw-offload=no
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=ether_ISP3 routing-table=ISP3_table suppress-hw-offload=no

}
#Create a route for each routing-mark
{
add distance=1 dst-address=0.0.0.0/0 gateway=ether_ISP1
add distance=2 dst-address=0.0.0.0/0 gateway=ether_ISP2
add distance=3 dst-address=0.0.0.0/0 gateway=ether_ISP3


}
#NAT
{
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether_ISP1
add action=masquerade chain=srcnat out-interface=ether_ISP2
add action=masquerade chain=srcnat out-interface=ether_ISP3
}
}


