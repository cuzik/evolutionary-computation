load 'individual.rb'

class Population
  attr_reader :number_of_individuals, :individuals

  def initialize(number_of_individuals, type_data, info_numbers, lim_inf = 0, lim_sup = 1)
    @number_of_individuals = number_of_individuals
    @individuals = []
    @number_of_individuals.times do
      @individuals += [Individual.new(type_data, info_numbers, lim_inf, lim_sup)]
    end
  end
end

Population.new(10, :int_perm, 6, 0, 10).individuals.each do |individual|
  p "#{individual.id} - #{individual.informations}"
end
