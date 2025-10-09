# Allocating this file for dealing with the fixed flag

# Sample input:

# ruby vlsm_planner.rb plan 192.168.0.0/20 \
#   --fixed /24:mgmt,/27:wan,/32:loop1 \
#   --sizes 400,60 \
#   --names srv,dmz

# Sample output:

# label | subnet         | prefix | usable_first  | usable_last   | broadcast     | capacity | waste |
# mgmt  | 192.168.0.0    | /24    | 192.168.0.1   | 192.168.0.254 | 192.168.0.255 | 254      | 0     |
# srv   | 192.168.1.0    | /23    | 192.168.1.1   | 192.168.2.254 | 192.168.2.255 | 510      | 110   |
# dmz   | 192.168.3.0    | /26    | 192.168.3.1   | 192.168.3.62  | 192.168.3.63  | 62       | 2     |
# wan   | 192.168.3.64   | /27    | 192.168.3.65  | 192.168.3.94  | 192.168.3.95  | 30       | 0     |
# loop1 | 192.168.3.96   | /32    | N/A           | N/A           | N/A           | 1        | 0     |

# ---- 

# Basic logic: Priority allocate subnets for fixed subnets then give remaining hosts to non fixed subnets 
