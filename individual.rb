# Atributes
# id:           int
# col_numbers:  int
# info_numbers: int
# type:         ENUM: { :int, :int_per, :bin, :uni }

require 'matrix'

# Individual
class Individual
  attr_reader :id, :informations, :centroid_value, :fitness_value

  @@last_id = 0

  TYPES_OPTIONS = %i[int int_perm bin uni].freeze

  def initialize(type_data, info_numbers, lim_inf = nil, lim_sup = nil, informations = nil)
    @@last_id += 1
    @id           = @@last_id
    @info_numbers = info_numbers
    @lim_inf      = lim_inf
    @lim_sup      = lim_sup
    @type_data    = type_data

    validate_params

    @informations = informations.nil? ? informations_init : informations
  end

  def informations_(informations)
    @informations = informations
  end

  def calculate_centroid_value
    @centroid_value = @informations.inject(:+) / @info_numbers.to_f
  end

  def calculate_fitness_value
    last_index = informations[0]
    @fitness_value = 0
    for i in 1..@info_numbers
      if informations[i] != last_index
        @fitness_value +=1
        last_index = informations[i]
      end
    end
    @fitness_value = @fitness_value / @info_numbers.to_f
    @fitness_value
  end

  def informations=(new_informations)
    @informations = new_informations
  end

  private

  def validate_params
    validate_id
    validate_info_numbers
    validate_type_data
  end

  def validate_id
    pop_error(:id_not_Integer) unless id.is_a?(Integer)
  end

  def validate_info_numbers
    pop_error(:info_numbers_not_Integer) unless @info_numbers.is_a?(Integer)
  end

  def validate_type_data
    pop_error(:type_data_not_Symbol) unless @type_data.is_a?(Symbol)
    pop_error(:type_data_not_valid) unless TYPES_OPTIONS.include?(@type_data)
  end

  def informations_init
    case @type_data
    when :int
      Array.new(@info_numbers) { rand(@lim_inf..@lim_sup) }
    when :int_perm
      Array.new(@info_numbers) { |col| col + 1 }.shuffle
    when :bin
      Array.new(@info_numbers) { rand(0..1) }
    when :uni
      Array.new(@info_numbers) { rand(@lim_inf.to_f..@lim_sup.to_f) }
    end
  end

  def pop_error(error)
    p error.to_s.gsub('_', ' ')
    exit
  end
end
