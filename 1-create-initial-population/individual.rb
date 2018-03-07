# Atributes
# id:          int
# col_numbers: int
# row_numbers: int
# type:        ENUM: { :int, :int_per, :bin, :uni }

require 'matrix'

class Individual
  attr_reader :id, :col_numbers, :row_numbers, :type_data, :informations

  TYPES_OPTIONS = [:int, :int_perm, :bin, :uni]

  def initialize(id, col_numbers, row_numbers, type_data, informations = nil)
    @id           = id
    @col_numbers  = col_numbers
    @row_numbers  = row_numbers
    @type_data    = type_data

    validate_params

    @informations = informations.nil? ? informations_init : informations
  end

  private

  def validate_params
    validate_id
    validate_col_numbers
    validate_row_numbers
    validate_type_data
  end

  def validate_id
    pop_error(:id_not_Integer) unless id.is_a?(Integer)
  end
  def validate_col_numbers
    pop_error(:col_numbers_not_Integer) unless col_numbers.is_a?(Integer)
  end
  def validate_row_numbers
    pop_error(:row_numbers_not_Integer) unless row_numbers.is_a?(Integer)
  end
  def validate_type_data
    pop_error(:type_data_not_Symbol) unless type_data.is_a?(Symbol)
    pop_error(:type_data_not_valid) unless TYPES_OPTIONS.include?(type_data)
  end

  def informations_init
    matrix = Matrix.build(row_numbers, col_numbers) { |row, col| gen_info }
  end

  def gen_info
    case type_data
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
    0
  end

  def gem_info_int_prm
    1
  end

  def gem_info_bin
    2
  end

  def gem_info_uni
    3
  end

  def pop_error(error)
    p error.to_s.gsub('_', ' ')
    exit
  end
end
