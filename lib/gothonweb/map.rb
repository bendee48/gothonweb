require 'byebug'

module Map

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

  CENTRAL_CORRIDOR = Room.new("Central Corridor",
    """
    The Gothons of Planet Percal #25 have invaded your ship and destroyed
    your entire crew.  You are the last surviving member and your last
    mission is to get the neutron destruct bomb from the Weapons Armory,
    put it in the bridge, and blow the ship up after getting into an
    escape pod.

    You're running down the central corridor to the Weapons Armory when
    a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown costume
    flowing around his hate filled body.  He's blocking the door to the
    Armory and about to pull a weapon to blast you.
    """
  )
  LASER_WEAPON_ARMORY = Room.new("Laser Weapon Armory", "This is the laser weapon armory")
  THE_BRIDGE = Room.new("The Bridge", "This is the bridge")
  ESCAPE_POD = Room.new("Escape Pod", "This is the escape pod")
  THE_END_WINNER = Room.new("The End", "This is the end if you win")
  THE_END_LOSER = Room.new("The End", "This is the end if you lose")

  ESCAPE_POD.add_paths({
    "2" => THE_END_WINNER,
    "*" => THE_END_LOSER
    })


  GENERIC_DEATH = Room.new("death", "You died.")


  THE_BRIDGE.add_paths({
    "throw the bomb" => GENERIC_DEATH,
    "slowly place the bomb" => ESCAPE_POD
    })

  LASER_WEAPON_ARMORY.add_paths({
        '0132' => THE_BRIDGE,
        '*' => GENERIC_DEATH
    })

  CENTRAL_CORRIDOR.add_paths({
        'shoot!' => GENERIC_DEATH,
        'dodge!' => GENERIC_DEATH,
        'tell a joke' => LASER_WEAPON_ARMORY
    })

  START = CENTRAL_CORRIDOR

  # A whitelist of allowed room names. We use this so that
    # bad people on the internet can't access random variables
    # with names.  You can use Test::constants and Kernel.const_get
    # too.
  ROOM_NAMES = {
      'CENTRAL_CORRIDOR' => CENTRAL_CORRIDOR,
      'LASER_WEAPON_ARMORY' => LASER_WEAPON_ARMORY,
      'THE_BRIDGE' => THE_BRIDGE,
      'ESCAPE_POD' => ESCAPE_POD,
      'THE_END_WINNER' => THE_END_WINNER,
      'THE_END_LOSER' => THE_END_LOSER,
      'START' => START,
  }

  def Map::load_room(session)
      # Given a session this will return the right room or nil
      return ROOM_NAMES[session[:room]]
  end

  def Map::save_room(session, room)
      # Store the room in the session for later, using its name
      session[:room] = ROOM_NAMES.key(room)
  end

  def Map::deaths
    ["Ouch, that looked painful. :-(",
    "Man, you suck.",
    "Better luck next time!",
    "Keep the faith soldier and try again."
  ][rand(0..2)]
  end

end
