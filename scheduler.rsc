/system scheduler add name="Reboot Router Daily" on-event="/system reboot" start-date=dec/01/2021 start-time=02:00:00 interval=1d comment="" disabled=no


{

/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2

add action=accept chain=prerouting dst-address=192.168.100.0/24 in-interface=WAN1
add action=accept chain=prerouting dst-address=192.168.200.0/24 in-interface=WAN2



/ip firewall mangle
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0 src-address=172.0.0.0/8
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1 src-address=172.0.0.0/8

add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/0 src-address=10.0.0.0/24
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:2/1 src-address=10.0.0.0/24


add action=mark-routing chain=prerouting connection-mark=wan1_conn new-routing-mark=to_wan1 passthrough=yes src-address=172.0.0.0/8
add action=mark-routing chain=prerouting connection-mark=wan2_conn new-routing-mark=to_wan2 passthrough=yes src-address=172.0.0.0/8
add action=mark-routing chain=prerouting connection-mark=wan1_conn new-routing-mark=to_wan1 passthrough=yes src-address=10.0.0.0/24
add action=mark-routing chain=prerouting connection-mark=wan2_conn new-routing-mark=to_wan2 passthrough=yes src-address=10.0.0.0/24




}

