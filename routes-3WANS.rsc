{
/ip route
add check-gateway=ping comment=to_wan1 disabled=yes distance=1 gateway=\
    192.168.100.1 routing-mark=to_wan1
add check-gateway=ping comment=to_wan2 disabled=yes distance=1 gateway=\
    192.168.4.1 routing-mark=to_wan2
add check-gateway=ping comment=to_wan1 distance=1 gateway=192.168.100.1
add check-gateway=ping distance=2 gateway=192.168.4.1
{
add check-gateway=ping comment=to_wan3 disabled=yes distance=1 gateway=\
    192.168.5.1 routing-mark=to_wan3
add check-gateway=ping comment=to_wan3 distance=1 gateway=192.168.5.1
}
add check-gateway=ping comment=to_wan4 disabled=yes distance=1 gateway=\
    192.168.6.1 routing-mark=to_wan4
add check-gateway=ping comment=to_wan4 distance=1 gateway=192.168.6.1
}