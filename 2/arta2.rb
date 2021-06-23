module Arta
  class Gun

    attr :id, :name, :start_speed, :min_angle, :max_angle, :bullet_count

    def initialize(row)
      @id, @name, @start_speed, @min_angle, @max_angle, @bullet_count = row.split(",")      
    end

  end
end

file = File.open("guns.dat")
file.readline.chomp

guns = []

while !file.eof?
  row = file.readline.chomp
  gun = Arta::Gun.new(row)
  guns << gun
  p gun.name + ' ' + gun.bullet_count
end

file.close
p ''
p guns
