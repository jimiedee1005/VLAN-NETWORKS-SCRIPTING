/ip firewall mangle
add action=accept chain=prerouting dst-address=172.17.17.0/24 in-interface=WAN1
add action=accept chain=prerouting dst-address=172.92.10.0/24 in-interface=WAN2
add action=accept chain=prerouting dst-address=173.29.10.0/24 in-interface=WAN3
add action=accept chain=prerouting dst-address=172.73.10.0/24 in-interface=WAN4
add action=accept chain=prerouting dst-address=10.10.10.0/24
add action=accept chain=prerouting dst-address=10.254.0.0/16
add action=accept chain=prerouting dst-address=172.19.0.0/22
add action=accept chain=prerouting dst-address=10.255.0.0/16
add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=WAN1_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN2 new-connection-mark=WAN2_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN3 new-connection-mark=WAN3_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN4 new-connection-mark=WAN4_conn passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN1_conn hotspot=auth new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN2_conn hotspot=auth new-routing-mark=to_wan2 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN3_conn hotspot=auth new-routing-mark=to_wan3 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN4_conn hotspot=auth new-routing-mark=to_wan4 passthrough=yes

add action=mark-connection chain=prerouting new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=src-address-and-port:7/0
add action=mark-connection chain=prerouting new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=src-address-and-port:7/1
add action=mark-connection chain=prerouting new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=src-address-and-port:7/2
add action=mark-connection chain=prerouting new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=src-address-and-port:7/3
add action=mark-connection chain=prerouting new-connection-mark=WAN3_conn passthrough=yes per-connection-classifier=src-address-and-port:7/4
add action=mark-connection chain=prerouting new-connection-mark=WAN3_conn passthrough=yes per-connection-classifier=src-address-and-port:7/5
add action=mark-connection chain=prerouting new-connection-mark=WAN4_conn passthrough=yes per-connection-classifier=src-address-and-port:7/6
add action=mark-routing chain=prerouting connection-mark=WAN1_conn new-routing-mark=to_wan1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN2_conn new-routing-mark=to_wan2 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN3_conn new-routing-mark=to_wan3 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN4_conn new-routing-mark=to_wan4 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN1_conn new-routing-mark=to_wan1 passthrough=yes src-address=10.254.0.0/16
add action=mark-routing chain=prerouting connection-mark=WAN2_conn new-routing-mark=to_wan2 passthrough=yes src-address=10.254.0.0/16
add action=mark-routing chain=prerouting connection-mark=WAN3_conn new-routing-mark=to_wan3 passthrough=yes src-address=10.254.0.0/16
add action=mark-routing chain=prerouting connection-mark=WAN4_conn new-routing-mark=to_wan4 passthrough=yes src-address=10.254.0.0/16
