# Atributes
# id:                     int
# number_of_individuals:  int
# individuals:            Individual

load 'individual.rb'

# Population
class Population
  attr_reader :id, :number_of_individuals, :individuals, :fitness

  @@last_id = 0

  def initialize(number_of_individuals, type_data, info_numbers, crossover_taxa, mutation_taxa, number_of_geration, lim_inf = 0, lim_sup = 1)
    @@last_id += 1
    @id                      = @@last_id
    @number_of_individuals   = number_of_individuals
    @type_data               = type_data
    @info_numbers            = info_numbers
    @mutation_taxa           = mutation_taxa
    @crossover_taxa           = crossover_taxa
    @number_of_geration      = number_of_geration
    @diversity               = []
    @fitness_list            = []
    @bests_individuals       = []
    @average_fitness         = []
    @individulas_to_populate = []
    @new_sequences           = []
    @individuals = Array.new(@number_of_individuals) do
      Individual.new(type_data, info_numbers, lim_inf, lim_sup)
    end
  end

  def run
    index = 0
    if @number_of_geration == 0
      evoluate
      while(@best_individual.fitness_value != 1) do
        evoluate
        p index
        index += 1
        # p "Best: #{@best_individual.informations} : #{@best_individual.fitness_value}"
      end
    else
      @number_of_geration.times do
        p index
        index += 1
        evoluate
        # p "Best: #{@best_individual.informations} : #{@best_individual.fitness_value}"
      end
    end

    p "Best: #{@best_individual.informations} : #{@best_individual.fitness_value}"
    gen_logs
    gen_graphics
  end

  def gen_graphics
    system("python gen_graphics.py")
  end

  def gen_logs
    # escrevendo @diversity
    system("mkdir -p logs")
    File.open('logs/log_diversity', 'w') do |f|
      @diversity.each do |line|
        f.puts line
      end
    end

    # escrevendo @bests_individuals
    File.open('logs/log_bests_individuals_fitness', 'w') do |f|
      @bests_individuals.map{|item| item.fitness_value}.each do |line|
        f.puts line
      end
    end

    # escrevendo @average_fitness
    File.open('logs/log_average_fitness', 'w') do |f|
      @average_fitness.each do |line|
        f.puts line
      end
    end
  end

  private

  def evoluate
    @diversity += [calculate_diversity]
    calculate_fitness_of_population
    select_best_individual
    change_new_individuals
    crossover_uniforme
    mutation_bit_flip
    individuals[rand(0...@number_of_individuals)] = @best_individual
  end

  def mutation_bit_flip
    index = 0
    @new_sequences.each do |new_sequence|
      for i in 0...@info_numbers
        a = rand(0.to_f..1.to_f)
        if a < @mutation_taxa
          new_sequence[i] = (new_sequence[i] - 1).abs
        end
      end
      individuals[index] = Individual.new(@type_data, @info_numbers, @lim_inf, @lim_sup, new_sequence)
      index +=1
    end
  end
  
  def crossover_uniforme
    @new_sequences = []
    for i in 0...@number_of_individuals
      @new_sequences += [cruzate(i, (i+1) % @number_of_individuals)]
    end
  end

  def cruzate(index_1, index_2)
    new_sequence = []
    for i in 0...@info_numbers
      new_sequence += [rand(0.to_f..1.to_f) < @crossover_taxa ? @individulas_to_populate[index_1].informations[i] : @individulas_to_populate[index_2].informations[i]]
    end
    new_sequence
  end

  def select_best_individual
    @best_individual = individuals[0]
    @individuals.each do |individual| 
      @best_individual = individual if individual.fitness_value > @best_individual.fitness_value
    end
    @bests_individuals += [@best_individual]
    @average_fitness += [@fitness_list.inject(:+) / Float(@number_of_individuals)]
  end

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
    @individuals.each do |individual|
      individual.calculate_fitness_value
    end
    @fitness_list = individuals.map { |item| item.fitness_value }
  end

  def change_new_individuals
    create_roulette
    @individulas_to_populate = []
    for i in 1...@number_of_individuals
      @individulas_to_populate += [@individuals[change_individual_index]]
    end
    @individulas_to_populate += [@best_individual]
  end

  def create_roulette
    @roulette = []
    total_fitness = @fitness_list.inject(:+)
    total = 0
    @fitness_list.each do |fitness|
      total += (fitness / total_fitness)
      @roulette += [total]
    end
  end

  def change_individual_index
    a = rand(0.to_f..1.to_f)
    index = 0
    @roulette.each do |item|
      return index if item > a
      index =+ 1
    end
    return index
  end
end
