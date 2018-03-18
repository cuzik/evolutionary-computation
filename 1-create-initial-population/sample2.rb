load 'population.rb'

population_one = Population.new(10, :int, 10, -5, 10)

puts '-'
puts "População #{population_one.id} :int"

4.times do
  population_one.evoluate
end
population_one.gen_graphyc

population_two = Population.new(10, :int_perm, 10)

puts '-'
puts "População #{population_two.id} :int_perm"

4.times do
  population_two.evoluate
end
population_two.gen_graphyc

population_three = Population.new(10, :bin, 10)

puts '-'
puts "População #{population_three.id} :bin"

4.times do
  population_three.evoluate
end
population_three.gen_graphyc

population_four = Population.new(10, :uni, 10, -10, 10)

puts '-'
puts "População #{population_four.id} :uni"

4.times do
  population_four.evoluate
end
population_four.gen_graphyc
