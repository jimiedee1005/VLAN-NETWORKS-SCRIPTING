{
#Nat
{
/ip firewall nat
add chain=srcnat action=masquerade out-interface=ether_ISP1
add chain=srcnat action=masquerade out-interface=ether_ISP2
add chain=srcnat action=masquerade out-interface=ether_ISP3
}
#routing
{
/routing table
add fib name=to_ISP1
add fib name=to_ISP2
add fib name=to_ISP3
}
#Filewall mangle
{
/ip firewall mangle
add chain=output connection-state=new connection-mark=no-mark action=mark-connection new-connection-mark=ISP1_conn out-interface=ether_ISP1
add chain=output connection-mark=ISP1_conn action=mark-routing new-routing-mark=to_ISP1 out-interface=ether_ISP1
add chain=output connection-state=new connection-mark=no-mark action=mark-connection new-connection-mark=ISP2_conn out-interface=ether_ISP2
add chain=output connection-mark=ISP2_conn action=mark-routing new-routing-mark=to_ISP2 out-interface=ether_ISP2
add chain=output connection-state=new connection-mark=no-mark action=mark-connection new-connection-mark=ISP3_conn out-interface=ether_ISP3
add chain=output connection-mark=ISP1_conn action=mark-routing new-routing-mark=to_ISP3 out-interface=ether_ISP3
}
#We will split the routing configuration into three parts. First, we will configure Host1 and Host2 as destination addresses in the routing section:
{
/ip route
add dst-address=8.8.8.8 scope=10 gateway=192.168.248.2
add dst-address=8.8.4.4 scope=10 gateway=192.168.122.1
add dst-address=8.8.4.4 scope=10 gateway=192.168.126.1
}

#Now configure routes that will be resolved recursively, so they will only be active when they are reachable with ping
{
/ip route
add distance=1 gateway=8.8.8.8 routing-table=to_ISP1 target-scope=11 check-gateway=ping
add distance=2 gateway=8.8.4.4 routing-table=to_ISP1 target-scope=11 check-gateway=ping
}

#Configure similar recursive routes for the second gateway:
{
/ip route
add distance=1 gateway=8.8.4.4 routing-table=to_ISP2 target-scope=11 check-gateway=ping
add distance=2 gateway=8.8.8.8 routing-table=to_ISP2 target-scope=11 check-gateway=ping
}

{
/ip route
add distance=1 gateway=8.8.8.8 routing-table=to_ISP3 target-scope=11 check-gateway=ping
add distance=3 gateway=8.8.4.4 routing-table=to_ISP3 target-scope=11 check-gateway=ping
}
}