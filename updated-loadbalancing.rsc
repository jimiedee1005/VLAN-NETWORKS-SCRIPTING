# may/22/2023 21:45:43 by RouterOS 7.8
# software id = 
#Naming interfaces
{
{
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether_ISP1
set [ find default-name=ether2 ] disable-running-check=no name=ether_ISP2
set [ find default-name=ether3 ] disable-running-check=no name=ether_ISP3
set [ find default-name=ether4 ] disable-running-check=no name=ether_LAN
}
#Routing
{
/routing table
add disabled=no fib name=ISP1_table
add disabled=no fib name=ISP2_table
add disabled=no fib name=ISP3_table
}
#Lan address
{
/ip address
add address=192.168.31.1/24 interface=ether_LAN network=192.168.31.0
}
#Dhcp-client
{
/ip dhcp-client
add interface=ether_ISP1
add interface=ether_ISP2
add interface=ether_ISP3
}
#Mangle rules
{
/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.248.0/24 in-interface=ether_LAN
add action=accept chain=prerouting dst-address=192.168.122.0/24 in-interface=ether_LAN
add action=accept chain=prerouting dst-address=192.168.126.0/24 in-interface=ether_LAN
add action=mark-connection chain=input connection-state=new in-interface=ether_ISP1 new-connection-mark=ISP1
add action=mark-connection chain=input connection-state=new in-interface=ether_ISP2 new-connection-mark=ISP2
add action=mark-connection chain=input connection-state=new in-interface=ether_ISP3 new-connection-mark=ISP3
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=ISP1 passthrough=yes per-connection-classifier=both-addresses:3/0
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=ISP2 per-connection-classifier=both-addresses:3/1
add action=mark-connection chain=output connection-mark=no-mark connection-state=new new-connection-mark=ISP3 per-connection-classifier=both-addresses:3/2
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=ether_LAN new-connection-mark=ISP1 per-connection-classifier=both-addresses:3/0
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=ether_LAN new-connection-mark=ISP2 per-connection-classifier=both-addresses:3/2
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-type=!local in-interface=ether_LAN new-connection-mark=ISP3 per-connection-classifier=both-addresses:3/1
add action=mark-routing chain=output connection-mark=ISP1 new-routing-mark=ISP1_table
add action=mark-routing chain=prerouting connection-mark=ISP1 in-interface=ether_LAN new-routing-mark=ISP1_table
add action=mark-routing chain=output connection-mark=ISP2 new-routing-mark=ISP2_table
add action=mark-routing chain=prerouting connection-mark=ISP2 in-interface=ether_LAN new-routing-mark=ISP2_table
add action=mark-routing chain=output connection-mark=ISP3 new-routing-mark=ISP3_table
add action=mark-routing chain=prerouting connection-mark=ISP3 in-interface=ether_LAN new-routing-mark=ISP3_table
}
#NAT
{
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether_ISP1
add action=masquerade chain=srcnat out-interface=ether_ISP2
add action=masquerade chain=srcnat out-interface=ether_ISP3
}
#Route
{
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.248.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
add disabled=no distance=2 dst-address=0.0.0.0/0 gateway=192.168.122.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
add disabled=no distance=3 dst-address=0.0.0.0/0 gateway=192.168.126.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
}
}