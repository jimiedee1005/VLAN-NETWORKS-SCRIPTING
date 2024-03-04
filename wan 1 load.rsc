{
    :local rmark "to_wan1"
    :local count [/ip route print count-only where comment="to_wan1"]
    :if ($bound=1) do={
        :if ($count = 0) do={
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping routing-mark=to_wan1 comment="to_wan1"
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping comment="to_wan1"
        } else={
            :if ($count = 1) do={
                :local test [/ip route find where comment="to_wan1"]
                :if ([/ip route get $test gateway] != $"gateway-address") do={
                    /ip route set $test gateway=$"gateway-address"
                }
            } else={
                :error "Multiple routes found"
            }
        }
    } else={
        /ip route remove [find comment="to_wan1"]
    }
}