class Map
  attr_reader :map
  def initialize
    @map = []
  end

  def set(key, value)
    if map.any? { |pair| pair[0] == key }
      map.each do |pair|
        pair[1] = value if pair[0] == key
      end
    else
      map << [key, value]
    end
  end

  def get(key)
    map.each { |pair| return pair[1] if pair[0] == key }
    nil
  end

  def delete(key)
    map.reject { |pair| pair[0] == key }
  end

  def show
    map
  end
end
