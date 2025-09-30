# vlsm_planner

## Currently basic version with only RFC1918 capability

Expected use case:

vlsm plan 10.0.0.0/16 --sizes 500,200,200,50,20 --names core,eng,sales,lab,iot

Output:

label | subnet | prefix | usable_first | usable_last | broadcast | capacity | waste
mgmt | 192.168.0.0 | /24 | 192.168.0.1 | 192.168.0.254 | 192.168.0.255 | 254 | 0
srv | 192.168.1.0 | /23 | 192.168.1.1 | 192.168.2.254 | 192.168.2.255 | 510 | 110
dmz | 192.168.3.0 | /26 | 192.168.3.1 | 192.168.3.62 | 192.168.3.63 | 62 | 2
wan | 192.168.3.64 | /27 | 192.168.3.65 | 192.168.3.94 | 192.168.3.95 | 30 | 0
