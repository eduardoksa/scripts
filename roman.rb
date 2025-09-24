class RomanConverter

  MAPPINGS = [ [1000, 'M'], [900,  'CM'], [500,  'D'], [400,  'CD'], [100,  'C'], [90,   'XC'], [50,   'L'], [40,   'XL'], [10,   'X'], [9,    'IX'], [5,    'V'], [4,    'IV'], [1,    'I'] ]

  def self.convert(number)
    raise ArgumentError, "Número deve estar entre 1 e 3999" unless (1..3999).include?(number)
    
    result = ''
    remaining = number

    MAPPINGS.each do |value, numeral|
      count = remaining / value
      if count > 0
        result += numeral * count
        remaining -= value * count
      end
    end

    result
  end
end

if __FILE__ == $0
  if ARGV.empty?
    puts "Uso: ruby #{$0} <número>"
    puts "Exemplo: ruby #{$0} 2025"
    exit 1
  end

  begin
    number = ARGV[0].to_i
    roman = RomanConverter.convert(number)
    puts "#{number} = #{roman}"
  rescue ArgumentError => e
    puts "Erro: #{e.message}"
    exit 1
  end
end
