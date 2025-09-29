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

# You can create a hashmap to get 0(1) access but manually 
# computing upper bounds is relatively negligible since n is 
# pretty small 


# To allow for elegant formatting every sub box should be 
# 4(3)+ 4 = 16 cause => 255.255.255.255  

