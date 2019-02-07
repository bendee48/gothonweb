require "./lib/gothonweb/map.rb"
require "test/unit"
require "rack/test"

class TestMap < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_room
    gold = Room.new("Gold Room", "This room has gold in it you can grab.")
    assert_equal("Gold Room", gold.name)
    assert_equal({}, gold.paths)
  end

  def test_room_paths
    center = Room.new("Center", "Test room in the center.")
    north = Room.new("North", "Test room in the north.")
    south = Room.new("South", "Test room in the south.")

    center.add_paths({'north' => north, 'south'=> south})
    assert_equal(north, center.go('north'))
    assert_equal(south, center.go('south'))
  end

  def test_map
    start = Room.new("Start", "You can go west and down a hole.")
    west = Room.new("Trees", "There are trees here and you can go east.")
    down = Room.new("Dungeon", "It's dark down here, you can go up.")

    start.add_paths({'west'=> west, 'down'=> down})
    west.add_paths({'east'=> start})
    down.add_paths({'up'=> start})

    assert_equal(west, start.go('west'))
    assert_equal(start, start.go('west').go('east'))
    assert_equal(start, start.go('down').go('up'))
  end

  def test_mygame
    lev1 = Room.new("Level 1", "Where you battle Depression.")
    lev1_map = {'level1' => lev1}

    assert_equal(lev1.name, "Level 1")
    assert_equal(lev1.description, "Where you battle Depression.")

    lev1.add_paths(lev1_map)
    assert_equal(lev1, lev1.go('level1'))

  end

end
