class NumberToWords

  ONES = %w[ zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen ]
  TENS = %w[ "" "" twenty thirty forty fifty sixty seventy eighty ninety ]

  def self.convert(number)
    return ONES[0] if number == 0
    return convert_negative(-number) if number < 0
    
    convert_positive(number).strip
  end

  private

  def self.convert_negative(number)
    "negative #{convert_positive(number)}"
  end

  def self.convert_positive(number)
    case number
    when 0
      ""
    when 1..19
      ONES[number]
    when 20..99
      convert_tens(number)
    when 100..999
      convert_hundreds(number)
    when 1000..99_999
      convert_thousands(number)
    else
      "number too large (maximum: 99,999)"
    end
  end

  def self.convert_tens(number)
    tens_digit = number / 10
    ones_digit = number % 10
    
    result = TENS[tens_digit]
    result += " #{ONES[ones_digit]}" if ones_digit > 0
    result
  end

  def self.convert_hundreds(number)
    hundreds_digit = number / 100
    remainder = number % 100
    
    result = "#{ONES[hundreds_digit]} hundred"
    
    if remainder > 0
      result += " and #{convert_positive(remainder)}"
    end
    
    result
  end

  def self.convert_thousands(number)
    thousands_part = number / 1000
    remainder = number % 1000
    
    result = "#{convert_positive(thousands_part)} thousand"
    
    if remainder > 0
      if remainder < 100
        result += " and #{convert_positive(remainder)}"
      else
        result += ", #{convert_positive(remainder)}"
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
    number = Integer(ARGV[0])
    words = NumberToWords.convert(number)
    puts "#{number} = #{words}"
  rescue ArgumentError
    puts "Erro: Digite um número válido"
    exit 1
  end
end
