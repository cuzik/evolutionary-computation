# Atributes
# id:           int
# col_numbers:  int
# info_numbers: int
# type:         ENUM: { :int, :int_per, :bin, :uni }

require 'matrix'
require 'faker'

class Individual
  attr_reader :id, :informations

  @@last_id = 0

  TYPES_OPTIONS = %i[int int_perm bin uni]

  def initialize(type_data, info_numbers, lim_inf = 0, lim_sup = 1, informations = nil)
    @@last_id += 1
    @id            = @@last_id
    @info_numbers  = info_numbers
    @type_data     = type_data
    @lim_inf       = lim_inf
    @lim_sup       = lim_sup

    validate_params

    @informations = informations.nil? ? informations_init : informations
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
    Matrix.build(1, @info_numbers) { gen_info }
  end

  def gen_info
    case @type_data
    when :int
      gem_info_int
    when :int_perm
      gem_info_int_prm
    when :bin
      gem_info_bin
    when :uni
      gem_info_uni
    end
  end

  def gem_info_int
    Faker::Number.between(@lim_inf, @lim_sup)
  end

  def gem_info_int_prm
    Faker::Number.between(1, @info_numbers)
  end

  def gem_info_bin
    Faker::Number.between(@lim_inf, @lim_sup)
  end

  def gem_info_uni
    Faker::Number.between(@lim_inf.to_f, @lim_sup)
  end

  def pop_error(error)
    p error.to_s.gsub('_', ' ')
    exit
  end
end
