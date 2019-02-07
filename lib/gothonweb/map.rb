class Room

  def initialize(name, description)
    @name = name
    @description = description
    @paths = {}
  end

  attr_accessor :name, :description, :paths

  def go(direction)
    @paths[direction]
  end

  def add_paths(paths)
    @paths.update(paths)
  end

end
