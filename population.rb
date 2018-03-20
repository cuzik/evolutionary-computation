# Atributes
# id:                     int
# number_of_individuals:  int
# individuals:            Individual

load 'individual.rb'

# Population
class Population
  attr_reader :id, :number_of_individuals, :individuals, :fitness

  @@last_id = 0

  def initialize(number_of_individuals, type_data, info_numbers, lim_inf = 0, lim_sup = 1)
    @@last_id += 1
    @id                    = @@last_id
    @number_of_individuals = number_of_individuals
    @type_data             = type_data
    @diversity             = []
    @fitness               = []
    @individuals = Array.new(@number_of_individuals) do
      Individual.new(type_data, info_numbers, lim_inf, lim_sup)
    end
  end

  def evoluate
    @diversity += [calculate_diversity]
    @fitness   += [calculate_fitness_of_population]
  end

  def gen_graphyc
    p "Diversity: #{@diversity}"
    p "Fitness:   #{@fitness}"
  end

  private

  def calculate_diversity
    calculate_centroid_values
    hamming_distance
  end

  def hamming_distance
    indice = 0
    @individuals.each do |individual|
      individual.informations.each do |information|
        indice += (information - individual.centroid_value) ** 2
      end
    end
    indice
  end

  def calculate_centroid_values
    @individuals.each do |individual|
      individual.calculate_centroid_value
    end
  end

  def calculate_fitness_of_population
    fitness_list = []
    @individuals.each do |individual|
      fitness_list += [individual.calculate_fitness_value]
    end
    fitness_list.max
  end
end
