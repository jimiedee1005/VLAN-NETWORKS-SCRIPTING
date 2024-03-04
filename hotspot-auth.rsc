{
ip firewall mangle
add action=mark-routing chain=prerouting connection-mark=no-mark dst-address-type=!local hotspot=auth in-interface=bridge new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0
add action=mark-routing chain=prerouting connection-mark=no-mark dst-address-type=!local hotspot=auth in-interface=bridge new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1



# serial number = HD8088K3BMV
/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2
/ip firewall mangle
add action=accept chain=prerouting dst-address=10.135.0.0/24


add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0 src-address=172.16.0.0/24
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1 src-address=172.16.0.0/24
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/2 src-address=172.16.0.0/24

/ip firewall mangle
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0 src-address=10.0.0.0/22
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1 src-address=10.0.0.0/22
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/2 src-address=10.0.0.0/22


add action=mark-routing chain=prerouting connection-mark=wan1_conn new-routing-mark=to_wan1 passthrough=yes src-address=172.16.0.0/24
add action=mark-routing chain=prerouting connection-mark=wan2_conn new-routing-mark=to_wan2 passthrough=yes src-address=172.16.0.0/24



/ip firewall mangle
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/0 src-address=10.0.0.0/22
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/1 src-address=10.0.0.0/22
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:3/2 src-address=10.0.0.0/22
add action=mark-routing chain=prerouting connection-mark=wan1_conn dst-address-type=!local hotspot=auth new-routing-mark=to_wan1 passthrough=yes src-address=10.0.0.0/22
add action=mark-routing chain=prerouting connection-mark=wan2_conn dst-address-type=!local hotspot=auth new-routing-mark=to_wan2 passthrough=yes src-address=10.0.0.0/22
