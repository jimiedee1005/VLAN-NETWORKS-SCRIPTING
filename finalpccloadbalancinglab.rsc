{
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=172.16.0.2-172.16.0.254
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether3 name=dhcp1
/ip address
add address=172.16.0.1/24 interface=ether3 network=172.16.0.0
/ip dhcp-client
add disabled=no interface=ether1
add disabled=no interface=ether2
/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.127.0/24
add action=accept chain=prerouting dst-address=192.168.122.0/24
add action=accept chain=prerouting dst-address=172.16.0.0/24
add action=mark-connection chain=prerouting in-interface=ether3 \
    new-connection-mark=ISP1-conn passthrough=yes per-connection-classifier=\
    both-addresses:2/0
add action=mark-connection chain=prerouting in-interface=ether3 \
    new-connection-mark=ISP2-conn passthrough=yes per-connection-classifier=\
    both-addresses:2/1
add action=mark-routing chain=prerouting in-interface=ether3 \
    new-routing-mark=ISP1 passthrough=no routing-mark=ISP1-conn
add action=mark-routing chain=prerouting in-interface=ether3 \
    new-routing-mark=ISP2 passthrough=no routing-mark=ISP2-conn
add action=mark-connection chain=prerouting in-interface=ether1 \
    new-connection-mark=ISP1-conn passthrough=yes
add action=mark-connection chain=prerouting in-interface=ether2 \
    new-connection-mark=ISP2-conn passthrough=yes
add action=mark-routing chain=output connection-mark=ISP2-conn \
    new-routing-mark=ISP1 passthrough=no
add action=mark-routing chain=output connection-mark=ISP2-conn \
    new-routing-mark=ISP2 passthrough=no
/ip route
add distance=2 gateway=192.168.122.2 routing-mark=ISP1
add distance=1 gateway=192.168.122.2 routing-mark=ISP2
add distance=2 gateway=192.168.127.2 routing-mark=ISP2
}