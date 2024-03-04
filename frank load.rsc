/routing table
add comment="VLAN NETWORKS" fib name=to-WAN1
add comment="VLAN NETWORKS" fib name=to-WAN2
add comment="VLAN NETWORKS" fib name=to-WAN3


/ip firewall address-list
add address=172.10.0.0/16 list=LOCAL-IP
add address=10.143.0.0/24 list=LOCAL-IP

/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.20.0/24
add action=accept chain=prerouting dst-address=192.168.70.0/24
add action=accept chain=prerouting dst-address=192.168.50.0/24
add action=accept chain=prerouting dst-address=10.134.0.160/24




add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=cm-WAN1 passthrough=yes
add action=mark-connection chain=input in-interface=WAN2 new-connection-mark=cm-WAN2 passthrough=yes
add action=mark-routing chain=output connection-mark=cm-WAN1 new-routing-mark=to-WAN1 passthrough=yes
add action=mark-routing chain=output connection-mark=cm-WAN2 new-routing-mark=to-WAN2 passthrough=yes

add action=mark-connection chain=prerouting new-connection-mark=cm-WAN1 passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0
add action=mark-connection chain=prerouting new-connection-mark=cm-WAN2 passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1
add action=mark-routing chain=prerouting connection-mark=cm-WAN1 new-routing-mark=to-WAN1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=cm-WAN2 new-routing-mark=to-WAN2 passthrough=yes

/ip route
add check-gateway=ping disabled=no distance=1 dst-address=1.1.1.1/32 gateway=\
    196.202.181.213 pref-src="" routing-table=main scope=30 \
    suppress-hw-offload=no target-scope=10
add check-gateway=ping disabled=no distance=1 dst-address=8.8.8.8/32 gateway=\
    192.168.52.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    1.1.1.1 pref-src="" routing-table=to-WAN1 scope=30 suppress-hw-offload=no \
    target-scope=30
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    8.8.8.8 pref-src="" routing-table=to-WAN2 scope=30 suppress-hw-offload=no \
    target-scope=30
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    8.8.8.8 pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=30
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    1.1.1.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=30
