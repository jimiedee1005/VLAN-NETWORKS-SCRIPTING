/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2
add action=accept chain=prerouting in-interface=WAN3
add action=mark-connection chain=input comment="packect input" in-interface=\
    WAN1 new-connection-mark=WAN1_Conn passthrough=no
add action=mark-connection chain=input in-interface=WAN2 new-connection-mark=\
    WAN2_Conn passthrough=no
add action=mark-connection chain=input in-interface=WAN3 new-connection-mark=\
    WAN3_Conn passthrough=no
add action=mark-connection chain=prerouting comment="WAN Routing" in-interface=\
    WAN1 new-connection-mark=WAN1_Conn passthrough=no
add action=mark-connection chain=prerouting in-interface=WAN2 \
    new-connection-mark=WAN2_Conn passthrough=no
add action=mark-connection chain=prerouting in-interface=WAN3 \
    new-connection-mark=WAN3_Conn passthrough=no
add action=accept chain=prerouting comment="Dst Address Routing" dst-address=\
    192.168.100.0/24
add action=accept chain=prerouting dst-address=192.168.200.0/24
add action=accept chain=prerouting dst-address=192.168.250.0/24
add action=mark-connection chain=prerouting comment="PCC routing" \
    dst-address-type=!local new-connection-mark=WAN1_Conn passthrough=yes \
    per-connection-classifier=both-addresses-and-ports:3/0
add action=mark-connection chain=prerouting dst-address-type=!local \
    new-connection-mark=WAN2_Conn passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:3/1
add action=mark-connection chain=prerouting dst-address-type=!local \
    new-connection-mark=WAN3_Conn passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:3/2
add action=mark-routing chain=prerouting comment="Packet Routing" \
    connection-mark=WAN1_Conn new-routing-mark=to_WAN1 passthrough=no
add action=mark-routing chain=prerouting connection-mark=WAN2_Conn \
    new-routing-mark=to_WAN2 passthrough=no
add action=mark-routing chain=prerouting connection-mark=WAN3_Conn \
    new-routing-mark=to_WAN3 passthrough=no
add action=mark-routing chain=output comment="Output routing" connection-mark=\
    WAN1_Conn hotspot=auth new-routing-mark=to_WAN1 passthrough=no
add action=mark-routing chain=output connection-mark=WAN2_Conn hotspot=auth \
    new-routing-mark=to_WAN2 passthrough=no
add action=mark-routing chain=output connection-mark=WAN3_Conn hotspot=auth \
    new-routing-mark=to_WAN3 passthrough=no
