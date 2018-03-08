# Atributes
# id:                     int
# number_of_individuals:  int
# individuals:            Individual

load 'individual.rb'

# Population
class Population
  attr_reader :id, :number_of_individuals, :individuals

  @@last_id = 0

  def initialize(number_of_individuals, type_data, info_numbers, lim_inf = 0, lim_sup = 1)
    @@last_id += 1
    @id                    = @@last_id
    @number_of_individuals = number_of_individuals
    @individuals = Array.new(@number_of_individuals) {
      Individual.new(type_data, info_numbers, lim_inf, lim_sup)
    }
  end
end
