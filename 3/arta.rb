require_relative 'arta_guns'
require_relative 'arta_enemy_targets'

module Arta

  # обрати ціль
  def self.select_target
    target = nil
    Arta::EnemyTarget.inspect_targets
    3.times do
      p 'Оберіть ціль'
      id = gets.chomp().to_i
      target = Arta::EnemyTarget.items_by_id(id)
      if target
        p "Ви обрали ціль: #{target.inspect}"
        p '...'
        break
      else
        p "WARNIG цілі з id = #{id} не існує!"
      end
    end
    target
  end
  
  # обрати гармату!
  def self.select_gun(target)
    gun = nil
    Arta::Gun.inspect_guns
    3.times do
      p 'Оберіть гармату'
      id = gets.chomp().to_i
      gun = Arta::Gun.items_by_id(id)
      if gun
        if gun.can_shot_by_target?(target)
          p "Ви обрали гармату: #{gun.inspect}"
          p '...'
          break
        else
          p 'WARNING Обрана вами ціль знаходиться поза зоною ураження даної гармати!'
        end
      else
        p "WARNING Гармати з id = #{id} не існує!"
      end
    end
    gun
  end
  
  def self.run
    # обираємо ціль
    target = select_target
    unless target
      p 'ERROR: Ви не обрали ціль!'
      return

    end
    
    # обираємо гармату
    gun = select_gun(target)
    unless gun
      p 'ERROR: Ви не обрали гармату!'
      return 
      
    end
    
    target_destroyed = false
    
    # поки є набої і ціль не знищена
    while gun.exist_bullet? && !target_destroyed
      p "У гарматі лишилося набоїв: #{gun.bullet_count} - зробіть постріл!"
      
      # встановлюємо кут нахилу гармати
      gun.set_angle(target)
      
      # стріляємо
      target_destroyed = gun.fire(target)
    end
    p "WARNING: Ціль не знищено:( у гарматі скінчилися набої!" unless target_destroyed
  end

  def self.run
    p 'lalala'
  end
end

Arta.run

