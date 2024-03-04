# jul/17/2023 10:02:09 by RouterOS 6.48.7
# software id = 48ZB-7RDF
#
# model = RB3011UiAS
# serial number = HCG085RQNFN
{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8 routing-mark=to_wan1 scope=20 target-scope=20
add check-gateway=ping comment=to_wan3 distance=1 gateway=1.1.1.1 routing-mark=to_wan3 scope=20 target-scope=20
add check-gateway=ping comment=to_wan4 distance=1 gateway=9.9.9.9 routing-mark=to_wan4 scope=20 target-scope=20
add check-gateway=ping comment=to_wan2 distance=1 gateway=8.8.4.4 routing-mark=to_wan2 scope=20 target-scope=20
}

{
/ip route
add check-gateway=ping comment=to_wan1 distance=1 gateway=8.8.8.8 scope=20 target-scope=20
add check-gateway=ping comment=to_wan2 distance=2 gateway=8.8.4.4 scope=20 target-scope=20
add check-gateway=ping comment=to_wan3 distance=3 gateway=1.1.1.1 scope=20 target-scope=20
add check-gateway=ping comment=to_wan4 distance=4 gateway=9.9.9.9 scope=20 target-scope=20
}

{
/ip route
add check-gateway=ping comment=to_wan3 distance=1 dst-address=1.1.1.1/32 gateway=192.168.100.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan2 distance=1 dst-address=8.8.4.4/32 gateway=192.168.77.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan1 distance=1 dst-address=8.8.8.8/32 gateway=192.168.99.1 scope=10 target-scope=11
add check-gateway=ping comment=to_wan4 distance=1 dst-address=9.9.9.9/32 gateway=192.168.88.1 scope=10 target-scope=11
}