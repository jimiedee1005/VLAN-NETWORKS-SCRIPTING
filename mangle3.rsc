
{
/user add comment="pnpradius user" group=full name=pnpradius password="wIp592tp47H%";
/ip  filter add action=accept chain=forward src-address=allowed;
/ip  filter add action=drop chain=forward src-address-;
}

/ip  address add address=192.168.180.0/24 ;
}

/ip  mangle
add action=mark-packet chain=prerouting comment="BUSINESS TRAFFIC MAPPING" \
    new-packet-mark=homeupload_pckt passthrough=no src-address=BUSINESS
add action=mark-packet chain=postrouting dst-address=BUSINESS \
    new-packet-mark=homedownload_pkt passthrough=no
add action=mark-packet chain=prerouting comment="HOTSPOT TRAFFIC MAPPING" \
    new-packet-mark=hotspotup_pkt passthrough=no src-address=HOTSPOT
add action=mark-packet chain=postrouting dst-address=HOTSPOT \
    new-packet-mark=hotspotdown_pkt passthrough=no



{
/ip  address add address=192.60.0.0/16 interface=bridge1
/ip  address add address=2.2.0.0/16 interface=bridge1
/ip  address add address=182.2.0.0/16  interface=bridge1
/ip  address add address=101.101.0.0/16 interface=bridge1
/ip  address add address=100.80.0.0/16 interface=bridge1
/ip  address add address=102.102.0.0/16 interface=bridge1
/ip  address add address=199.50.0.0/16 interface=bridge1
/ip  address add address=192.10.0.0/16 interface=bridge1
/ip  address add address=172.168.0.0/16 interface=bridge1
/ip  address add address=180.180.0.0/16 interface=bridge1
/ip  address add address=177.177.0.0/16 interface=bridge1
/ip  address add address=174.174.0.0/16 interface=bridge1
/ip  address add address=172.172.0.0/16 interface=bridge1
/ip  address add address=169.169.0.0/16 interface=bridge1
/ip  address add address=164.164.0.0/16 interface=bridge1
/ip  address add address=162.162.0.0/16 interface=bridge1
/ip  address add address=161.161.0.0/16 interface=bridge1
/ip  address add address=160.160.0.0/16 interface=bridge1
/ip  address add address=146.146.0.0/16 interface=bridge1
/ip  address add address=135.135.0.0/16 interface=bridge1
/ip  address add address=130.130.0.0/16 interface=bridge1
/ip  address add address=103.103.0.0/16 interface=bridge1
/ip  address add address=100.100.0.0/16 interface=bridge1
/ip  address add address=98.98.0.0/16 interface=bridge1
/ip  address add address=97.97.0.0/16 interface=bridge1
/ip  address add address=57.57.0.0/16 interface=bridge1
/ip  address add address=53.53.0.0/16 interface=bridge1
/ip  address add address=47.47.0.0/16 interface=bridge1
/ip  address add address=37.37.0.0/16 interface=bridge1
/ip  address add address=35.35.0.0/16 interface=bridge1
/ip  address add address=34.34.0.0/16 interface=bridge1
/ip  address add address=20.20.0.0/16 interface=bridge1
/ip  address add address=18.18.0.0/16 interface=bridge1
/ip  address add address=7.7.0.0/16 interface=bridge1
/ip  address add address=6.6.0.0/16 interface=bridge1
/ip  address add address=5.5.0.0/16 interface=bridge1
/ip  address add address=3.3.0.0/16 interface=bridge1
/ip  address add address=1.1.0.0/16 interface=bridge1
/ip  address add address=155.155.0.0/16 interface=bridge1
/ip  address add address=165.165.0.0/16 interface=bridge1
/ip  address add address=156.156.0.0/16 interface=bridge1
/ip  address add address=149.149.0.0/16 interface=bridge1
/ip  address add address=147.147.0.0/16 interface=bridge1
/ip  address add address=140.140.0.0/16 interface=bridge1
/ip  address add address=136.136.0.0/16 interface=bridge1
/ip  address add address=125.125.0.0/16 interface=bridge1
/ip  address add address=124.124.0.0/16 interface=bridge1
/ip  address add address=121.121.0.0/16 interface=bridge1
/ip  address add address=96.96.0.0/16 interface=bridge1
/ip  address add address=45.45.0.0/16 interface=bridge1
/ip  address add address=87.87.0.0/16 interface=bridge1
/ip  address add address=82.82.0.0/16 interface=bridge1
/ip  address add address=69.69.0.0/16 interface=bridge1
/ip  address add address=41.41.0.0/16 interface=bridge1
/ip  address add address=40.40.0.0/16 interface=bridge1
/ip  address add address=28.28.0.0/16 interface=bridge1
/ip  address add address=24.24.0.0/16 interface=bridge1
/ip  address add address=22.22.0.0/16 interface=bridge1
/ip  address add address=19.19.0.0/16 interface=bridge1
/ip  address add address=14.14.0.0/16 interface=bridge1
/ip  address add address=13.13.0.0/16 interface=bridge1
/ip  address add address=11.11.0.0/16 interface=bridge1
/ip  address add address=9.9.0.0/16 interface=bridge1
/ip  address add address=4.4.0.0/16 interface=bridge1
/ip  address add address=43.43.0.0/16 interface=bridge1
/ip  address add address=168.168.0.0/16 interface=bridge1
/ip  address add address=104.104.0.0/16 interface=bridge1
/ip  address add address=39.39.0.0/16 interface=bridge1
/ip  address add address=38.38.0.0/16 interface=bridge1
/ip  address add address=67.67.0.0/16 interface=bridge1
/ip  address add address=10.30.0.0/16 interface=bridge1
}