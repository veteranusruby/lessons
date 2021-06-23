# підключити файл data_reader
require_relative 'data_reader'

module Arta
  class Gun

    # додати методи класу з модуля DataReader
    extend DataReader

    # константа яка зберігає ім'я файлу з даними по гарматам
    DATA_FILE = 'guns.dat'
    PI = 3.14
    G = 9.8

    # властивості гармати
    attr_reader :id, :name, :start_speed, :min_angle, :max_angle, :bullet_count, :current_angle

    #################################################
    # Далі ідуть методи екземплярів класу Arta::Gun #
    #################################################

    # ініціалізувати об'єкт класу Гармата
    def initialize(row)
      @id, @name, @start_speed, @min_angle, @max_angle, @bullet_count = row.split(',')
      @id = @id.to_i
      @start_speed = @start_speed.to_f
      @min_angle = @min_angle.to_f
      @max_angle = @max_angle.to_f
      @bullet_count = @bullet_count.to_i
      @current_angle = @min_angle
    end

    # вивести текстову інформацію про гармату
    def inspect
      "#{id}: #{name}" +
        ", кут відхилу від: #{min_angle} до: #{max_angle} градусів" +
        ", початкова швидкість снаряду: #{start_speed} м/c" +
        ", діапазон ураження від #{min_distance_for_target} до #{max_distance_for_target} метрів" +
        ", боєзапас: #{bullet_count}"
    end

    # є набої?
    def exist_bullet?
      bullet_count > 0
    end

    # мінімально допустима відстань до цілі
    def min_distance_for_target
      @min_distance_for_target ||= [shot_distance(min_angle), shot_distance(max_angle)].min
    end

    # максимально допустима відстань до цілі
    def max_distance_for_target
      @max_distance_for_target ||= [shot_distance(min_angle), shot_distance(max_angle)].max
    end

    # отримати діапазон зони ураження гармати від..до в залежності від
    # допустимих значень кута відхилу та початкової швидкості снаряду
    def distance_range
      min_distance_for_target..max_distance_for_target
    end

    # отримати дальність пострілу в залежності від кута відхилу
    def shot_distance(angle)
      angle = 0 if angle < 0
      ((start_speed ** 2 * Math.sin(angle * PI / 90)) / G).round(2)
    end

    # перевірити чи можливе ураження заданої цілі даним типом гармати
    def can_shot_by_target?(target)
      distance_range.include?(target.distance)
    end

    # спрогнозувати кут відхилу для пострілу по цілі
    def angle_oracul(target)
      (Math.asin((target.distance * G) / (start_speed ** 2)) * 90 / PI).round(1)
    end

    # введення та перевірка значення куту відхилу гармати при пострілі
    def set_angle(target)
      p "!!!"
      p "Прогнозований кут відхилу: #{angle_oracul(target)} або #{90.0 - angle_oracul(target)} градусів!"
      3.times do
        p "Введіть кут відхилу від: #{min_angle} до: #{max_angle} градусів:"
        angle = gets.chomp().to_f
        if angle >= min_angle && angle <= max_angle
          "Ви встановили кут відхилу гармати #{angle} градусів"
          p '...'
          @current_angle = angle
          break
        else
          p "WARNING: Кут відхилу = #{angle} за межами допустимого діапазону цієї гармати!"
        end
      end
    end

    # вогонь!
    def fire(target)
      if bullet_count < 1
        p 'WARNING: Закінчилися набої у гарматі!'
        return false

      end

      p 'ВОГОНЬ!'
      # зменшуємо кількість набоїв у гарматі
      @bullet_count -= 1
      p '...'

      # вираховуємо відстань між влучанням снаряду та ціллю
      delta = target.distance - shot_distance(current_angle)

      # перевіряємо чи знищено ціль?
      target.input_fire(delta)

      # повертаємо результат
      target.destroyed?
    end

    ############################################
    # Далі ідуть методи класу Arta::Gun (self) #
    ############################################

    # зчитати дані з файлу та ініціалізувати перелік об'єктів (гармат)
    def self.items
      @@items ||= read_objects_from_file
    end

    # роздрукувати інформацію по гарматах в яких лишилися набої
    def self.inspect_guns
      p 'Доступні гармати:'
      items.each do |gun|
        p gun if gun.exist_bullet?
      end
      p '...'
    end
  end
end  
