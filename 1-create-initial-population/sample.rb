load 'population.rb'

puts '-'
puts 'Pop: 10, Type: :int, Gen: 6, Bound: [0, 100]'
puts '-'

Population.new(10, :int, 6, 0, 100).individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end

puts '-'
puts 'Pop: 10, Type: :int, Gen: 6'
puts '-'

Population.new(10, :int_perm, 6).individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end

puts '-'
puts 'Pop: 10, Type: :bin, Gen: 6'
puts '-'

Population.new(10, :bin, 6).individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end

puts '-'
puts 'Pop: 10, Type: :uni, Gen: 6, Bound: [0, 999]'
puts '-'

Population.new(10, :uni, 6, 0, 999).individuals.each do |individual|
  puts "#{individual.id} - #{individual.informations}"
end
