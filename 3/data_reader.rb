module DataReader

  # зчитати інформацію з файла та ініціалізувати об'єкти
  def read_objects_from_file
    results = []
    file = File.open(self::DATA_FILE)

    while !file.eof?
      row = file.readline.chomp
      next if row[0..1] == 'id'

      results << new(row)
    end
    file.close
    results
  end

  # отримати Hash об'єктів для швидкого пошуку по id
  def items_hash
    result = {}
    items.each do |item|
      result[item.id] = item
    end
    result
  end

  # знайти об'єкт по id
  def items_by_id(id)
    items_hash[id]
  end
end