# gladiator.rb

class Gladiator
  attr :name

  def initialize(name)
    @name = name
  end

  def say_hello
    puts "Вклоняємося тобі, Цезарю!"
   
    yield if block_given?
    
    puts "Ті що йдуть на смерть вітають тебе!"
  end

end

spartak = Gladiator.new("Спартак")
spartak.say_hello do  
 p "Я, #{spartak.name} вітаю вас!"
end













#spartak.say_hello do
#puts "ЗАПОВІТ"
 # puts "Я, #{spartak.name}, заповідаю..."
#end
