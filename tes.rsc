{
/ip dhcp-client
add add-default-route=no disabled=no interface=WAN1 script="{\r\
    \n    :local rmark \"to_WAN1\"\r\
    \n    :local count [/ip route print count-only where comment=\"to_WAN1\"]\
    \r\
    \n    :if (\$bound=1) do={\r\
    \n        :if (\$count = 0) do={\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping routing-mark=to_WAN1 comment=\"to_WAN1\"\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping comment=\"to_WAN1\"\r\
    \n        } else={\r\
    \n            :if (\$count = 1) do={\r\
    \n                :local test [/ip route find where comment=\"to_WAN1\"]\r\
    \n                :if ([/ip route get \$test gateway] != \$\"gateway-addre\
    ss\") do={\r\
    \n                    /ip route set \$test gateway=\$\"gateway-address\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :error \"Multiple routes found\"\r\
    \n            }\r\
    \n        }\r\
    \n    } else={\r\
    \n        /ip route remove [find comment=\"to_WAN1\"]\r\
    \n    }\r\
    \n}"
}

{
/ip dhcp-client
add add-default-route=no disabled=no interface=WAN2 script="{\r\
    \n    :local rmark \"to_WAN2\"\r\
    \n    :local count [/ip route print count-only where comment=\"to_WAN2\"]\
    \r\
    \n    :if (\$bound=1) do={\r\
    \n        :if (\$count = 0) do={\r\
    \n            /ip route add distance=1 gateway=\$\"gateway-address\" check\
    -gateway=ping routing-mark=to_WAN2 comment=\"to_WAN2\"\r\
    \n            /ip route add distance=2 gateway=\$\"gateway-address\" check\
    -gateway=ping comment=\"to_WAN2\"\r\
    \n\t} else={\r\
    \n            :if (\$count = 1) do={\r\
    \n                :local test [/ip route find where comment=\"to_WAN2\"]\r\
    \n                :if ([/ip route get \$test gateway] != \$\"gateway-addre\
    ss\") do={\r\
    \n                    /ip route set \$test gateway=\$\"gateway-address\"\r\
    \n                }\r\
    \n            } else={\r\
    \n                :error \"Multiple routes found\"\r\
    \n            }\r\
    \n        }\r\
    \n    } else={\r\
    \n        /ip route remove [find comment=\"to_WAN2\"]\r\
    \n    }\r\
    \n}"
}



{
/ip firewall mangle
add action=accept chain=prerouting in-interface=WAN1
add action=accept chain=prerouting in-interface=WAN2


add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan1_conn passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:2/0 src-address=10.224.0.0/16
add action=mark-connection chain=prerouting dst-address-type=!local new-connection-mark=wan2_conn passthrough=yes per-connection-classifier=\
    both-addresses-and-ports:2/1 src-address=10.224.0.0/16

    

add action=mark-routing chain=prerouting connection-mark=wan1_conn new-routing-mark=to_wan1 passthrough=yes src-address=10.224.0.0/16
add action=mark-routing chain=prerouting connection-mark=wan2_conn new-routing-mark=to_wan2 passthrough=yes src-address=10.224.0.0/16

}