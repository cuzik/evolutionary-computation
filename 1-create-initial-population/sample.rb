load 'population.rb'

population_one = Population.new(10, :int, 10, -5, 10)

puts '-'
puts "População #{population_one.id}"
puts 'Pop: 10, Type: :int, Gen: 10, Bound: [-5, 10]'
puts '-'

population_one.individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end

population_two = Population.new(10, :int_perm, 10)

puts '-'
puts "População #{population_two.id}"
puts 'Pop: 10, Type: :int_perm, Gen: 10'
puts '-'

population_two.individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end

population_three = Population.new(10, :bin, 10)

puts '-'
puts "População #{population_three.id}"
puts 'Pop: 10, Type: :bin, Gen: 10'
puts '-'

population_three.individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end

population_four = Population.new(10, :uni, 10, -10, 10)

puts '-'
puts "População #{population_four.id}"
puts 'Pop: 10, Type: :uni, Gen: 10, Bound: [-10, 10]'
puts '-'

population_four.individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end
