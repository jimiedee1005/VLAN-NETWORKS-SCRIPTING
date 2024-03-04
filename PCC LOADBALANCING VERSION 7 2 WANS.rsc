/routing table
add disabled=no fib name=to_WAN1
add disabled=no fib name=to_WAN2

#Policy routing
/ip firewall mangle
add action=accept chain=prerouting dst-address=196.202.181.213 in-interface=bridge1
add action=accept chain=prerouting dst-address=192.168.52.1 in-interface=bridge1

/ip firewall mangle
add action=mark-connection chain=input connection-state=new in-interface=WAN1 new-connection-mark=WAN1
add action=mark-connection chain=input connection-state=new in-interface=WAN2 new-connection-mark=WAN2



/ip firewall mangle
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=WAN1 passthrough=yes per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=WAN2 passthrough=yes per-connection-classifier=both-addresses:2/1

/ip firewall mangle
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=bridge1 new-connection-mark=WAN1 per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=bridge1 new-connection-mark=WAN2 per-connection-classifier=both-addresses:2/1

add action=mark-routing chain=output connection-mark=WAN1 new-routing-mark=to_WAN1
add action=mark-routing chain=prerouting connection-mark=WAN1 in-interface=bridge1 new-routing-mark=to_WAN1

/ip firewall mangle 
add action=mark-routing chain=output connection-mark=WAN2 new-routing-mark=to_WAN2
add action=mark-routing chain=prerouting connection-mark=WAN2 in-interface=bridge1 new-routing-mark=to_WAN2

/ip firewall mangle 
add action=mark-routing chain=output connection-mark=WAN3 new-routing-mark=to_wan3
add action=mark-routing chain=prerouting connection-mark=WAN3 in-interface=bridge1 new-routing-mark=to_wan3

/ip firewall mangle 
add action=mark-routing chain=output connection-mark=WAN4 new-routing-mark=to_wan4
add action=mark-routing chain=prerouting connection-mark=WAN4 in-interface=bridge1 new-routing-mark=to_wan4



/ip route
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=10.10.4.1 routing-table=to_WAN1 suppress-hw-offload=no
add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=10.10.5.1 routing-table=to_WAN2 suppress-hw-offload=no

#Create a route for each routing-mark
add distance=1 dst-address=0.0.0.0/0 gateway=10.10.4.1
add distance=2 dst-address=0.0.0.0/0 gateway=10.10.5.1

#NAT
/ip firewall nat
add action=masquerade chain=srcnat out-interface=WAN1
add action=masquerade chain=srcnat out-interface=WAN2