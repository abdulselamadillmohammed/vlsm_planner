original_martix = []

original_martix[0] = ["a"]
original_martix[1] = ["b"]
original_martix[2] = ["c"]

puts "#{original_martix}"

deep_copied_matrix = []
for _ in 0..(original_martix.length - 1)
    deep_copied_matrix << []
end

for i in 0..(original_martix.length - 1)
    for j in 0..(original_martix[i].length - 1)
        deep_copied_matrix[i] << original_martix[i][j]
    end
end
puts "#{deep_copied_matrix}"

