#Name interfaces
{
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-ISP1
set [ find default-name=ether2 ] disable-running-check=no name=ether2-ISP2
}
#Setting up dhcp-client
#ISP1
{
/ip dhcp-client
add add-default-route=no disabled=no interface=ether1-ISP1 script="{\r\
    \n    :local rmark \"to_wan1\"\r\
    \n    :local count [/ip route print count-only where comment=\"to_wan1\"]\
    \r\
    \n    :if (\$bound=1) do={\r\
    \n        :if (\$count = 0) do={\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping routing-mark=to_wan1 comment=\"to_wan1\"\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping comment=\"to_wan1\"\r\
    \n        } else={\r\
    \n            :if (\$count = 1) do={\r\
    \n                :local test [/ip route find where comment=\"to_wan1\"]\r\
    \n                :if ([/ip route get \$test gateway] != \$\"gateway-addre\
    ss\") do={\r\
    \n                    /ip route set \$test gateway=\$\"gateway-address\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :error \"Multiple routes found\"\r\
    \n            }\r\
    \n        }\r\
    \n    } else={\r\
    \n        /ip route remove [find comment=\"to_wan1\"]\r\
    \n    }\r\
    \n}"
}
#ISP2
{
/ip dhcp-client
add add-default-route=no disabled=no interface=ether2-ISP2 script="{\r\
    \n    :local rmark \"to_wan2\"\r\
    \n    :local count [/ip route print count-only where comment=\"to_wan2\"]\
    \r\
    \n    :if (\$bound=1) do={\r\
    \n        :if (\$count = 0) do={\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping routing-mark=to_wan2 comment=\"to_wan2\"\r\
    \n            /ip route add distance=2 gateway=\$\"gateway-address\" check\
    -gateway=ping comment=\"to_wan2\"\r\
    \n\t} else={\r\
    \n            :if (\$count = 1) do={\r\
    \n                :local test [/ip route find where comment=\"to_wan2\"]\r\
    \n                :if ([/ip route get \$test gateway] != \$\"gateway-addre\
    ss\") do={\r\
    \n                    /ip route set \$test gateway=\$\"gateway-address\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :error \"Multiple routes found\"\r\
    \n            }\r\
    
    \n        }\r\
    \n    } else={\r\
    \n        /ip route remove [find comment=\"to_wan2\"]\r\
    \n    }\r\
    \n}"
}



#Mangle rules
{
/ip firewall mangle
add action=mark-connection chain=prerouting connection-state=new in-interface=ether_LAN new-connection-mark=Con1 nth=2,1 passthrough=yes
add action=mark-connection chain=prerouting connection-state=new in-interface=ether_LAN new-connection-mark=Con2 nth=2,2 passthrough=yes

add action=mark-routing chain=prerouting connection-mark=Con1 in-interface=ether_LAN new-routing-mark=to_wan1 passthrough=no
add action=mark-routing chain=prerouting connection-mark=Con2 in-interface=ether_LAN new-routing-mark=to_wan2 passthrough=no
}

#Natting
{
/ ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-ISP1 connection-mark=Con1
add action=masquerade chain=srcnat out-interface=ether2-ISP2 connection-mark=Con2
}
#Routing
{
/routing table add disabled=no fib name=wan1
/routing table add disabled=no fib name=wan2

/ip route
add distance=1 gateway=192.168.50.1 routing-table=wan1
add distance=1 gateway=172.16.20.1 routing-table=wan2
}
