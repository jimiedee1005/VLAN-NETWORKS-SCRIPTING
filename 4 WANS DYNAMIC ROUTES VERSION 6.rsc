#wan1
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
#wan2
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

#wan3
{
    :local rmark "to_wan3"
    :local count [/ip route print count-only where comment="to_wan3"]
    :if ($bound=1) do={
        :if ($count = 0) do={
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping routing-mark=to_wan3 comment="to_wan3"
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping comment="to_wan3"
        } else={
            :if ($count = 1) do={
                :local test [/ip route find where comment="to_wan3"]
                :if ([/ip route get $test gateway] != $"gateway-address") do={
                    /ip route set $test gateway=$"gateway-address"
                }
            } else={
                :error "Multiple routes found"
            }
        }
    } else={
        /ip route remove [find comment="to_wan3"]
    }
}

#wan4
{
    :local rmark "to_wan4"
    :local count [/ip route print count-only where comment="to_wan4"]
    :if ($bound=1) do={
        :if ($count = 0) do={
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping routing-mark=to_wan4 comment="to_wan4"
            /ip route add distance=1 gateway=$"gateway-address" check-gateway=ping comment="to_wan4"
        } else={
            :if ($count = 1) do={
                :local test [/ip route find where comment="to_wan4"]
                :if ([/ip route get $test gateway] != $"gateway-address") do={
                    /ip route set $test gateway=$"gateway-address"
                }
            } else={
                :error "Multiple routes found"
            }
        }
    } else={
        /ip route remove [find comment="to_wan4"]
    }
}