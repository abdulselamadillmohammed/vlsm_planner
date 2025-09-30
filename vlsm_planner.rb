# Input: parent IPv4 network in CIDR format. e.g : 10.0.0.0/16 

# Smaple usecase: 
# vslm plan 10.0.0.0/16 --sizes 500, 200, 200, 50, 20 --names
# core, eng, sales, lab, iot

# --- Arg orders --- 
# 0 : subcommands
# 1 : parent IPv4 network
# (2n+1) : flags {1,3,5... 2n+1} where n = len(ARGV//2)
# 2n : arguments
# -------------------

# MOST BASIC USECASE
# ruby vlsm_planner.rb plan 10.0.0.0/16 --sizes 500,200,200,50,20

# You can create a hashmap to get 0(1) access but manually 
# computing upper bounds is relatively negligible since n is 
# pretty small 

# To allow for elegant formatting every sub box should be 
# 4(3)+ 4 = 16 cause => 255.255.255.255  

# --- Expected format ---
# label  | subnet        | prefix | usable_first | usable_last  | broadcast    | capacity | waste
# core   | 10.0.0.0      | /23    | 10.0.0.1     | 10.0.1.254   | 10.0.1.255   | 510      | 10
# eng    | 10.0.2.0      | /24    | 10.0.2.1     | 10.0.2.254   | 10.0.2.255   | 254      | 54
# sales  | 10.0.3.0      | /24    | 10.0.3.1     | 10.0.3.254   | 10.0.3.255   | 254      | 54
# lab    | 10.0.4.0      | /26    | 10.0.4.1     | 10.0.4.62    | 10.0.4.63    | 62       | 12
# iot    | 10.0.4.64     | /27    | 10.0.4.65    | 10.0.4.94    | 10.0.4.95    | 30       | 10
# ------------------------


def hosts_to_prefix(num_hosts)
    raise ArgumentError, "num_hosts must be >= 1" if num_hosts < 1

    num_hosts += 2 # for boardcast adress and network address 
    counter = 1
    iterator = 0
    while counter < num_hosts
        counter *= 2
        iterator += 1
    end
    return 32 - iterator
end

def subnet_capacity(prefix)
    return (2 ** (32 - prefix)) - 2 # watch out for network and broadcast address
end

def wasted_spots(prefix, num_hosts)
    return (subnet_capacity(prefix) - num_hosts)
end
# /32:1, /31:2, /30:4, /29:8, /28:16, /27:32, /26:64, /25:128, /24:256

sizes = ARGV[3]

# Implementation of RFC1918 (basic subnetting)
puts ("Here are the sizes: #{sizes}")
puts ("Type of sizes: #{sizes.class}")

# Parser for sizes
sizes = sizes.split(",")
puts ("Here are the sizes: #{sizes}")
puts ("Type of sizes: #{sizes.class}")
# Here are the sizes: ["500", "200", "200", "50", "20"]
# Type of sizes: Array
sizes = sizes.map { |x| x.to_i}

# --- Test CIDR ---
required_test_1 = hosts_to_prefix(500)
required_test_2 = hosts_to_prefix(1)
puts ("the amount you are required for 500 hosts: #{required_test_1}")
puts ("the amount you are required for 1 hosts: #{required_test_2}")

# --- Prep prefixes --- 
prefixes = []
sizes.each do |num_hosts|
    prefixes << hosts_to_prefix(num_hosts)
end
puts ("Here are the Prefixes: #{prefixes}")
# -----------------------

# --- Prep capacity --- 
capacities = []
prefixes.each do |prefix|
    capacities << subnet_capacity(prefix)
end
puts ("Here are the Capacitiies: #{capacities}")
# --- Returning ---

# --- Prep wasted spots ---
wasted_spots_count = []
# Iterate in the same length as 
for i in 0..prefixes.length - 1
    wasted_spots_count << wasted_spots(prefixes[i], sizes[i])
end
puts ("Here are the Wasted spots: #{wasted_spots_count}")
# -------------------------

# --- Deal with subnetting rules ---
# Simple fix: choose by 8 counting

# 1. get the hostadress cidr prefix
network_address = ARGV[1].split("/")
network_address_cidr_prefix = network_address[1].to_i

# 2. Split the host address into approptiate 8 bit blocks
network_address = network_address[0].split(".").map{ |x|  x.to_i }

# 3. Since we assume that requirements are passed by largest first, we will
# Practically /16 is the max needed to worry about but /24 will be implemented incase of simulation needs

headers = [
  "label",
  "subnet",
  "prefix",
  "usable_first",
  "usable_last",
  "broadcast",
  "capacity",
  "waste"
]
# pad each header to 16 chars (spaces added if shorter)
puts headers.map { |h| h.ljust(16) }.join
