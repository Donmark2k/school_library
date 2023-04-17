require_relative 'refactor'

def main
  puts "Welcome to School library App!\n"
  refactor = Refactor.new
  loop do
    refactor.display_selection
    option = gets.chomp.to_i
    case option
    when 1..6
      refactor.list_holder(option)
    else
      puts 'Thank you for using this app!'
      break
    end
  end
end

main
