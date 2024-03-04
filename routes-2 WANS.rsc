{
/ip route
add check-gateway=ping comment=to_wan1 disabled=yes distance=1 gateway=\
    196.202.220.1 routing-mark=to_wan1
add check-gateway=ping comment=to_wan2 disabled=yes distance=1 gateway=\
    197.211.31.129 routing-mark=to_wan2
add check-gateway=ping comment=to_wan1 distance=1 gateway=196.202.220.1
add check-gateway=ping distance=2 gateway=197.211.31.129

}


/ip firewall mangle
add action=mark-connection chain=input in-interface="vlan1" new-connection-mark="unwired main" passthrough=yes
add action=mark-connection chain=input in-interface="ether4-AIRTEL UPLINK - NYAMASARIA" new-connection-mark="Telkom backup" passthrough=yes
add action=mark-routing chain=output connection-mark="unwired main" new-routing-mark="To Unwired" passthrough=yes
add action=mark-routing chain=output connection-mark="Telkom backup " new-routing-mark="To Telkom" passthrough=yes
add action=accept chain=prerouting in-interface=pnp_bridge


/ip route

add check-gateway=ping comment=to_wan2 disabled=yes distance=1 gateway=\
    197.211.31.129 routing-mark=to_wan2
add check-gateway=ping distance=2 gateway=197.211.31.129
