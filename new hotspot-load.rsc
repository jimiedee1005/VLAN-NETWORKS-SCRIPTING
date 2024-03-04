/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2
add action=accept chain=prerouting in-interface=WAN3


add action=accept chain=prerouting dst-address=192.168.1720.0/24 in-interface=WAN1
add action=accept chain=prerouting dst-address=192.168.200.0/24 in-interface=WAN2
add action=accept chain=prerouting dst-address=192.168.200.0/24 in-interface=WAN2



add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:2/0 src-address=172.16.0.1/16
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:2/1 src-address=172.16.0.1/16
add action=mark-routing chain=prerouting connection-mark=wan1_conn dst-address-type=!local new-routing-mark=to_wan1 passthrough=yes src-address=172.16.0.1/16
add action=mark-routing chain=prerouting connection-mark=wan2_conn dst-address-type=!local new-routing-mark=to_wan2 passthrough=yes src-address=172.16.0.1/16





{
/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2


add action=mark-connection chain=prerouting new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0 src-address=172.16.0.1/16
add action=mark-connection chain=prerouting new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1 src-address=172.16.0.1/16


add action=mark-routing chain=prerouting connection-mark=wan1_conn dst-address-type=!local new-routing-mark=to_wan1 passthrough=yes src-address=172.16.0.1/16
add action=mark-routing chain=prerouting connection-mark=wan2_conn dst-address-type=!local new-routing-mark=to_wan2 passthrough=yes src-address=172.16.0.1/16
}

{
/ip firewall mangle
add action=mark-connection chain=prerouting new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0 src-address=10.10.0.2/16
add action=mark-connection chain=prerouting new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1 src-address=10.10.0.2/16
add action=mark-connection chain=prerouting new-connection-mark=wan3_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/2 src-address=10.10.0.2/16
add action=mark-routing chain=prerouting connection-mark=wan1_conn dst-address-type=!local new-routing-mark=to_wan1 passthrough=yes src-address=10.10.0.2/16
add action=mark-routing chain=prerouting connection-mark=wan2_conn dst-address-type=!local new-routing-mark=to_wan2 passthrough=yes src-address=10.10.0.2/16
add action=mark-routing chain=prerouting connection-mark=wan3_conn dst-address-type=!local new-routing-mark=to_wan3 passthrough=yes src-address=10.10.0.2/16
}

{
/ip firewall mangle
add action=mark-connection chain=prerouting new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0 src-address=192.168.4.2/24
add action=mark-connection chain=prerouting new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1 src-address=192.168.4.2/24
add action=mark-connection chain=prerouting new-connection-mark=wan3_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/2 src-address=192.168.4.2/24
add action=mark-routing chain=prerouting connection-mark=wan1_conn dst-address-type=!local new-routing-mark=to_wan1 passthrough=yes src-address=192.168.4.2/24
add action=mark-routing chain=prerouting connection-mark=wan2_conn dst-address-type=!local new-routing-mark=to_wan2 passthrough=yes src-address=192.168.4.2/24
add action=mark-routing chain=prerouting connection-mark=wan3_conn dst-address-type=!local new-routing-mark=to_wan3 passthrough=yes src-address=192.168.4.2/24
}
