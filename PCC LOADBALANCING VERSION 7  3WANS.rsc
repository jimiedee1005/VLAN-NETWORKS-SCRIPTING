#UPDATE THE ROUTING TABLE
/routing table
add disabled=no fib name=WAN1_table
add disabled=no fib name=WAN2_table
add disabled=no fib name=WAN3_table


#Policy routing
/ip firewall mangle
add action=accept chain=prerouting dst-address=10.10.4.0/24 in-interface=bridge
add action=accept chain=prerouting dst-address=10.10.5.0/24 in-interface=bridge
add action=accept chain=prerouting dst-address=10.10.6.0/24 in-interface=bridge

/ip firewall mangle
add action=mark-connection chain=input connection-state=new in-interface=WAN1 new-connection-mark=WAN1
add action=mark-connection chain=input connection-state=new in-interface=WAN2 new-connection-mark=WAN2
add action=mark-connection chain=input connection-state=new in-interface=WAN2 new-connection-mark=WAN3

/ip firewall mangle
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=WAN1 passthrough=yes per-connection-classifier=both-addresses:3/0
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=WAN2 passthrough=yes per-connection-classifier=both-addresses:3/1
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=WAN2 passthrough=yes per-connection-classifier=both-addresses:3/2

/ip firewall mangle
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=bridge new-connection-mark=WAN1 per-connection-classifier=both-addresses:3/0
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=bridge new-connection-mark=WAN2 per-connection-classifier=both-addresses:3/1
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=bridge new-connection-mark=WAN3 per-connection-classifier=both-addresses:3/2

/ip firewall mangle
add action=mark-routing chain=output connection-mark=WAN1 new-routing-mark=WAN1_table
add action=mark-routing chain=prerouting connection-mark=WAN1 in-interface=bridge new-routing-mark=WAN1_table

/ip firewall mangle 
add action=mark-routing chain=output connection-mark=WAN2 new-routing-mark=WAN2_table
add action=mark-routing chain=prerouting connection-mark=WAN2 in-interface=bridge new-routing-mark=WAN2_table

/ip firewall mangle
add action=mark-routing chain=output connection-mark=WAN3 new-routing-mark=WAN3_table
add action=mark-routing chain=prerouting connection-mark=WAN3 in-interface=bridge new-routing-mark=WAN3_table

/ip route
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=10.10.4.1 routing-table=WAN1_table suppress-hw-offload=no
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=10.10.5.1 routing-table=WAN2_table suppress-hw-offload=no
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=10.10.6.1 routing-table=WAN3_table suppress-hw-offload=no

#Create a route for each routing-mark
add distance=1 dst-address=0.0.0.0/0 gateway=10.10.4.1
add distance=2 dst-address=0.0.0.0/0 gateway=10.10.5.1
add distance=3 dst-address=0.0.0.0/0 gateway=10.10.6.1

#NAT
/ip firewall nat
add action=masquerade chain=srcnat out-interface=WAN1
add action=masquerade chain=srcnat out-interface=WAN2
add action=masquerade chain=srcnat out-interface=WAN3
