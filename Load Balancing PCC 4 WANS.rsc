/interface ethernet
set [ find default-name=ether1 ] name=WAN1
set [ find default-name=ether2 ] name=WAN2
set [ find default-name=ether3 ] name=WAN3
set [ find default-name=ether4 ] name=wan4

#Setting up dhcp-client for WAN1, WAN2 WAN3 and wan4




{
/ip dhcp-client
add add-default-route=no disabled=no interface=WAN3 script="{\r\
    \n    :local rmark \"to_WAN3\"\r\
    \n    :local count [/ip route print count-only where comment=\"to_WAN3\"]\
    \r\
    \n    :if (\$bound=1) do={\r\
    \n        :if (\$count = 0) do={\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping routing-mark=to_WAN3 comment=\"to_WAN3\"\r\
    \n            /ip route add distance=3 gateway=\$\"gateway-address\" check\
    -gateway=ping comment=\"to_WAN3\"\r\
    \n\t} else={\r\
    \n            :if (\$count = 1) do={\r\
    \n                :local test [/ip route find where comment=\"to_WAN3\"]\r\
    \n                :if ([/ip route get \$test gateway] != \$\"gateway-addre\
    ss\") do={\r\
    \n                    /ip route set \$test gateway=\$\"gateway-address\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :error \"Multiple routes found\"\r\
    \n            }\r\
    \n        }\r\
    \n    } else={\r\
    \n        /ip route remove [find comment=\"to_WAN3\"]\r\
    \n    }\r\
    \n}" 
 

}

{
/ip dhcp-client
add add-default-route=no disabled=no interface=WAN4 script="{\r\
    \n    :local rmark \"to_wan4\"\r\
    \n    :local count [/ip route print count-only where comment=\"to_wan4\"]\
    \r\
    \n    :if (\$bound=1) do={\r\
    \n        :if (\$count = 0) do={\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping routing-mark=to_wan4 comment=\"to_wan4\"\r\
    \n            /ip route add distance=3 gateway=\$\"gateway-address\" check\
    -gateway=ping comment=\"to_wan4\"\r\
    \n\t} else={\r\
    \n            :if (\$count = 1) do={\r\
    \n                :local test [/ip route find where comment=\"to_wan4\"]\r\
    \n                :if ([/ip route get \$test gateway] != \$\"gateway-addre\
    ss\") do={\r\
    \n                    /ip route set \$test gateway=\$\"gateway-address\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :error \"Multiple routes found\"\r\
    \n            }\r\
    \n        }\r\
    \n    } else={\r\
    \n        /ip route remove [find comment=\"to_wan4\"]\r\
    \n    }\r\
    \n}" 
 
}


/ip firewall mangle
add action=mark-connection chain=input in-interface=WAN1 new-connection-mark=WAN1_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN2 new-connection-mark=WAN2_conn passthrough=yes
add action=mark-connection chain=input in-interface=WAN3 new-connection-mark=WAN3_conn passthrough=yes
add action=mark-connection chain=input in-interface=wan4 new-connection-mark=wan4_conn passthrough=yes

add action=mark-routing chain=output connection-mark=WAN1_conn new-routing-mark=to_WAN1 passthrough=yes
add action=mark-routing chain=output connection-mark=WAN2_conn new-routing-mark=to_WAN2 passthrough=yes
add action=mark-routing chain=output connection-mark=WAN3_conn new-routing-mark=to_wan4 passthrough=yes
add action=mark-routing chain=output connection-mark=wan4_conn new-routing-mark=to_wan4 passthrough=yes

add action=accept chain=prerouting dst-address=192.168.1.0/24 in-interface=LAN
add action=accept chain=prerouting dst-address=192.168.2.0/24 in-interface=LAN
add action=accept chain=prerouting dst-address=192.168.3.0/24 in-interface=LAN
add action=accept chain=prerouting dst-address=192.168.4.0/24 in-interface=LAN

add action=mark-connection chain=prerouting dst-address-type=!local in-interface=LAN new-connection-mark=WAN1_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/0
add action=mark-connection chain=prerouting dst-address-type=!local in-interface=LAN new-connection-mark=WAN2_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/1
add action=mark-connection chain=prerouting dst-address-type=!local in-interface=LAN new-connection-mark=WAN3_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/2
add action=mark-connection chain=prerouting dst-address-type=!local in-interface=LAN new-connection-mark=wan4_conn passthrough=yes per-connection-classifier=both-addresses-and-ports:4/3

add action=mark-routing chain=prerouting connection-mark=WAN1_conn in-interface=LAN new-routing-mark=to_WAN1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN2_conn in-interface=LAN new-routing-mark=to_WAN2 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=WAN3_conn in-interface=LAN new-routing-mark=to_wan4 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=wan4_conn in-interface=LAN new-routing-mark=to_wan4 passthrough=yes


/ip firewall nat
add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface=WAN1
add action=masquerade chain=srcnat out-interface=WAN2
add action=masquerade chain=srcnat out-interface=WAN3
add action=masquerade chain=srcnat out-interface=wan4
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.0.0/24


/ip hotspot user
add name=admin password=admin


/ip route
add check-gateway=ping distance=1 gateway=192.168.1.1 routing-mark=to_WAN1 scope=255
add check-gateway=ping distance=1 gateway=192.168.2.1 routing-mark=to_WAN2 scope=255
add check-gateway=ping distance=1 gateway=192.168.3.1 routing-mark=to_wan4 scope=255
add check-gateway=ping distance=1 gateway=192.168.4.1 routing-mark=to_wan4 scope=255
add check-gateway=ping distance=1 gateway=192.168.1.1 scope=255
add check-gateway=ping distance=2 gateway=192.168.2.1 scope=255
add check-gateway=ping distance=3 gateway=192.168.3.1 scope=255
add check-gateway=ping distance=4 gateway=192.168.4.1 scope=255
