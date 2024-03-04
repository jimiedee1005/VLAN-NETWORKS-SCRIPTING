#setting up mange rules for accepting connection
{
/ip firewall mangle
add action=mark-connection chain=prerouting in-interface=bridge1 new-connection-mark=WAN-1 passthrough=yes src-address-list=WAN-1
add action=mark-routing chain=prerouting in-interface=bridge1 new-routing-mark=to-wan1 passthrough=no src-address-list=WAN-1
add action=mark-connection chain=prerouting in-interface=bridge1 new-connection-mark=WAN-2 passthrough=yes src-address-list=WAN2
add action=mark-routing chain=prerouting dst-address-list="" in-interface=bridge1 new-routing-mark=to-wan2 passthrough=no src-address-list=WAN-2
add action=mark-connection chain=prerouting in-interface=bridge1 new-connection-mark=WAN-3 passthrough=yes src-address-list=WAN-3
add action=mark-routing chain=prerouting dst-address-list="" in-interface=bridge1 new-routing-mark=to-wan3 passthrough=no src-address-list=WAN-3
add action=mark-connection chain=prerouting dst-address-type=!local in-interface=bridge1 new-connection-mark=WAN-4 passthrough=yes src-address-list=WAN-4
add action=mark-routing chain=prerouting dst-address-list="" in-interface=bridge1 new-routing-mark=to-wan4 passthrough=no src-address-list=WAN-4
}
#setting up mange rules for marking connection and marking routing
{
ip firewall mangle
add action=mark-connection chain=prerouting connection-state=new new-connection-mark=WAN-1 nth=4,1 passthrough=yes src-address=10.16.0.0/20
add action=add-src-to-address-list address-list=WAN-1 address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN-1 src-address=10.16.0.0/20 src-address-list=!ASSIGNED
add action=add-src-to-address-list address-list=ASSIGNED address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN-1 src-address=10.16.0.0/20
add action=mark-routing chain=prerouting connection-mark=WAN-1 new-routing-mark=to-wan1 passthrough=no src-address=10.16.0.0/20
add action=mark-connection chain=prerouting connection-state=new new-connection-mark=WAN-2 nth=4,2 passthrough=yes src-address=10.16.0.0/20
add action=add-src-to-address-list address-list=WAN-2 address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN-2 src-address=10.16.0.0/20 src-address-list=!ASSIGNED
add action=add-src-to-address-list address-list=ASSIGNED address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN-2 src-address=10.16.0.0/20
add action=mark-routing chain=prerouting connection-mark=WAN-2 new-routing-mark=to-wan2 passthrough=no src-address=10.16.0.0/20
add action=mark-connection chain=prerouting connection-state=new new-connection-mark=WAN-3 nth=4,3 passthrough=yes src-address=10.16.0.0/20
add action=add-src-to-address-list address-list=WAN-3 address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN-3 src-address=10.16.0.0/20 src-address-list=!ASSIGNED
add action=add-src-to-address-list address-list=ASSIGNED address-list-timeout=none-dynamic chain=prerouting connection-mark=WAN-3 src-address=10.16.0.0/20
add action=mark-routing chain=prerouting connection-mark=WAN-3 new-routing-mark=to-wan3 passthrough=no src-address=10.16.0.0/20
add action=mark-connection chain=prerouting comment=nano connection-state=new new-connection-mark=WAN-4 nth=4,4 passthrough=yes src-address=10.16.0.0/20
add action=add-src-to-address-list address-list=WAN-4 address-list-timeout=none-dynamic chain=prerouting comment=nano connection-mark=WAN-4 src-address=10.16.0.0/20 src-address-list=!ASSIGNED
add action=add-src-to-address-list address-list=ASSIGNED address-list-timeout=none-dynamic chain=prerouting comment=nano connection-mark=WAN-4 src-address=10.16.0.0/20
add action=mark-routing chain=prerouting comment=nano connection-mark=WAN-4 new-routing-mark=to-wan4 passthrough=no src-address=10.16.0.0/20
}
