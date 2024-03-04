{
    :local rmark "to_wan2"
    :local count [/ip route print count-only where comment="to_wan2"]
    :if ($bound=1) do={
        :if ($count = 0) do={
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping routing-mark=to_wan2 comment="to_wan2"
            /ip route add distance=2 gateway=$"gateway-address" check-gateway=ping comment="to_wan2"
	} else={
            :if ($count = 1) do={
                :local test [/ip route find where comment="to_wan2"]
                :if ([/ip route get $test gateway] != $"gateway-address") do={
                    /ip route set $test gateway=$"gateway-address"
                }
            } else={
                :error "Multiple routes found"
            }
        }
    } else={
        /ip route remove [find comment="to_wan2"]
    }
}