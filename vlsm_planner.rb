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

# /32:1, /31:2, /30:4, /29:8, /28:16, /27:32, /26:64, /25:128, /24:256

sizes = ARGV[1]

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

# --- Returning ---

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
