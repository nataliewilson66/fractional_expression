def fractional_expression(str)
  expression = str.split(" ")
  legal_operators = "+-*/"
  operator = expression[1]
  operand_x, operand_y = expression[0], expression[2]

  numer_x, denom_x = string_to_frac_array(operand_x)
  numer_y, denom_y = string_to_frac_array(operand_y)

  if denom_x == 0 || denom_y == 0
    puts "Invalid input: 0 denominator"
    return
  elsif operator == "/" && numer_y == 0
    puts "Invalid input: cannot divide by 0"
    return
  end

  if operator == "+" || operator == "-"
    result_denom = lcm(denom_x, denom_y)
    mult_x = result_denom / denom_x
    mult_y = result_denom / denom_y
    numer_x *= mult_x
    numer_y *= mult_y

    if operator == "+"
      result_numer = numer_x + numer_y
    else
      result_numer = numer_x - numer_y
    end
  elsif operator == "*" || operator == "/"
    numer_y, denom_y = denom_y, numer_y if operator == "/"
    result_numer = numer_x * numer_y
    result_denom = denom_x * denom_y
  else
    puts "Illegal operator"
    return
  end

  if result_numer >= result_denom
    return impr_frac_to_mixed_num(result_numer, result_denom)
  else
    result_numer, result_denom = reduce_frac(result_numer, result_denom)
    return "#{result_numer}/#{result_denom}"
  end
end


# Helper methods below:

def string_to_frac_array(str)
  if str.include?("_")
    return mixed_num_to_impr_frac(str)
  else
    return str.split("/").map { |n| n.to_i }
  end
end

def mixed_num_to_impr_frac(mixed_num)
  mixed_num = mixed_num.split("_")
  int = mixed_num[0].to_i
  numer, denom = mixed_num[1].split("/").map { |n| n.to_i }
  numer += int * denom

  [numer, denom]
end

def impr_frac_to_mixed_num(numer, denom)
  int = numer / denom
  numer -= int * denom
  numer, denom = reduce_frac(numer, denom)
  return "#{int}_#{numer}/#{denom}"
end

def reduce_frac(numer, denom)
  factor = gcd(numer, denom)
  if factor > 1
    numer /= factor
    denom /= factor
  end

  return [numer, denom]
end

def gcd(x, y)
  min = 1
  max = x < y ? x : y

  (min..max).reverse_each do |n|
    if x % n == 0 && y % n == 0
      return n
    end
  end

  return min
end

def lcm(x, y)
  max = x * y
  min = x > y ? x : y

  (min..max).each do |n|
    if n % x == 0 && n % y == 0
      return n
    end
  end

  return max
end


# Positive Tests:

test_1_str = "1/2 * 3_3/4"
puts "test 1: #{test_1_str} = #{fractional_expression(test_1_str)}"
test_2_str = "2_3/8 + 9/8"
puts "test 2: #{test_2_str} = #{fractional_expression(test_2_str)}"
test_3_str = "1/2 - 3/4"
puts "test 3: #{test_3_str} = #{fractional_expression(test_3_str)}"
test_4_str = "2_3/8 / 9/8"
puts "test 4: #{test_4_str} = #{fractional_expression(test_4_str)}"

# Negative Tests:

test_5_str = "1/2 ^ 3"
fractional_expression(test_5_str)
test_6_str = "2/0 + 1/2"
fractional_expression(test_6_str)
test_7_str = "3_1/2 / 0/3"
fractional_expression(test_7_str) 