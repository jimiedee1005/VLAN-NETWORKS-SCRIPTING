{
/ip firewall mangle
add action=mark-connection chain=prerouting in-interface=bridge1 new-connection-mark=WAN1 passthrough=yes src-address-list=WAN1
add action=mark-routing chain=prerouting in-interface=bridge1 new-routing-mark=to-wan1 passthrough=no src-address-list=WAN1
add action=mark-connection chain=prerouting in-interface=bridge1 new-connection-mark=WAN2 passthrough=yes src-address-list=WAN2
add action=mark-routing chain=prerouting dst-address-list="" in-interface=bridge1 new-routing-mark=to-wan2 passthrough=no src-address-list=WAN2
}

{
ip firewall mangle
add action=mark-connection chain=prerouting connection-state=new new-connection-mark=WAN1 nth=2,1 passthrough=yes src-address=192.168.45.0/24
add action=add-src-to-address-list address-list=WAN1 address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN1 src-address=192.168.45.0/24 src-address-list=!ASSIGNED
add action=add-src-to-address-list address-list=ASSIGNED address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN1 src-address=192.168.45.0/24
add action=mark-routing chain=prerouting connection-mark=WAN1 new-routing-mark=to-wan1 passthrough=no src-address=192.168.45.0/24


add action=mark-connection chain=prerouting connection-state=new new-connection-mark=WAN2 nth=2,2 passthrough=yes src-address=192.168.45.0/24
add action=add-src-to-address-list address-list=WAN2 address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN2 src-address=192.168.45.0/24 src-address-list=!ASSIGNED
add action=add-src-to-address-list address-list=ASSIGNED address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN2 src-address=192.168.45.0/24
add action=mark-routing chain=prerouting connection-mark=WAN2 new-routing-mark=to-wan2 passthrough=no src-address=192.168.45.0/24
}

