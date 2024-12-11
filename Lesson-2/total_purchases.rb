# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".



goods = {}
total_price = []

loop do
  puts "Для остановки введите слово 'Стоп'"
  puts "Введите название товара:"
  product = gets.chomp
  break if product == "Стоп"
  puts "Укажите цену за единицу:"
  price = gets.chomp.to_i
  puts "Укажите количество этого товара:"
  quantity = gets.chomp.to_f

  goods[product] = { price: quantity }
  total_price.push([ product, price * quantity ])
end

puts goods
total_price.each {|price| puts "Итоговая сумма за #{price[0]} #{price[1]}" }
puts "Итоговая сумма покупок в корзине #{ total_price.map {|price| price[1]}.sum}"