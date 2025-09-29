# Input: parent IPv4 network in CIDR format. e.g : 10.0.0.0/16 

# Smaple usecase: 
# vslm plan 10.0.0.0/16 --sizes 500, 200, 200, 50, 20 --names
# core, eng, sales, lab, iot

sizes = ARGV[1]

# Implementation of RFC1918 (basic subnetting)
puts ("Here are the sizes: #{sizes}")
puts ("Type of sizes: #{sizes.class}")