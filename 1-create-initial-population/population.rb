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
    @type_data             = type_data
    @diversity             = []
    @centroid_values       = []
    @individuals = Array.new(@number_of_individuals) do
      Individual.new(type_data, info_numbers, lim_inf, lim_sup)
    end
  end

  def evoluate
    @diversity += [calculate_diversity]
  end

  def gen_graphyc
    p @diversity
  end

  private

  def calculate_diversity
    calculate_centroid_values
  end

  def calculate_centroid_values
    @individuals.each do |individual|
      @centroid_values += [individual.calculate_centroid_value]
    end
  end
end
