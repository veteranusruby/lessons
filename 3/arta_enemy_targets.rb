# підключити файл data_reader
require_relative 'data_reader'

module Arta
  class EnemyTarget

    # додати методи класу з модуля DataReader
    extend DataReader

    # константа яка зберігає ім'я файлу з даними по цілям
    DATA_FILE = 'targets.dat'

    # властивості  цілі
    attr_reader :id, :name, :distance, :max_radius, :destroyed

    #########################################################
    # Далі ідуть методи екземплярів класу Arta::EnemyTarget #
    #########################################################

    # ініціалізувати об'єкт класу Ціль
    def initialize(row)
      @id, @name, @distance, @max_radius = row.split(',')
      @id = @id.to_i
      @distance = @distance.to_f
      @max_radius = @max_radius.to_f
      @destroyed = false
    end

    # знищити ціль
    def destroy
      @destroyed = true
    end
    
    # ціль знищена?
    def destroyed?
      @destroyed
    end

    # вивести текстову інформацію про ціль
    def inspect
      "#{id}: #{name}" +
      ", відстань до цілі: #{distance} метрів" +
      ", максимальна похибка для ураження цілі (в метрах): #{max_radius}"
    end

    # прилетіло
    def input_fire(delta)
      # знищуємо ціль якщо похибка менша за максимальний радіус ураження цілі
      destroy if max_radius > delta.abs
        
      # роздруковуємо результати 
      print_input_fire_results(delta)
    end
    
    # роздрукувати інформацію після тогроо як прилетіло
    def print_input_fire_results(delta)
      if destroyed?
        p "Снаряд влучив у ціль на відстані #{delta.abs.round(2)} метрів!"
        p "#{name} ворога знищено!"
        p 'Смерть Ворогам!'
        p 'Слава Україні!'
      elsif delta > 0
        p "WARNING: Снаряд не долетів до цілі на #{delta.abs.round(2)} метрів!"
        p '...'
      else
        p "WARNING: Снаряд перелетів ціль на #{delta.abs.round(2)} метрів!"
        p '...'
      end
    end

    # зчитати дані з файлу та ініціалізувати перелік об'єктів (цілей)
    def self.items
      @@items ||= read_objects_from_file
    end

    # отримати список не знищених цілей
    def self.non_destroyed_targets_list
      items.keep_if { |target_lalala| !target_lalala.destroyed }
    end

    # отримати список знищених цілей
    def self.destroyed_targets_list
      items.keep_if { |target| target.destroyed }
    end

    # роздрукувати інформацію по незнищених цілях
    def self.inspect_targets
      p 'Доступні цілі:'
      non_destroyed_targets_list.each do |target|
        p target unless target.destroyed
      end
      p '...'
    end
  end
end  
