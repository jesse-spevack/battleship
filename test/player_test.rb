require './test/test_helper'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_player_starts_with_no_shots_fired
    p1 = Player.new([2, 3])
    assert_equal 0, p1.shots_fired
  end

  def test_player_starts_not_winning_the_game
    p1 = Player.new([2, 3])
    refute p1.winner
  end

  def test_player_starts_not_knowing_any_spaces
    p1 = Player.new([2, 3])
    assert_equal [], p1.known_spaces
  end

  def test_play_can_fire_shots
    p1 = Player.new([2, 3])
    initial = p1.shots_fired
    p1.fire
    one_shot_fired = p1.shots_fired
    p1.fire
    two_shots_fired = p1.shots_fired
    p1.fire
    three_shots_fired = p1.shots_fired

    assert_equal 0, initial
    assert_equal 1, one_shot_fired
    assert_equal 2, two_shots_fired
    assert_equal 3, three_shots_fired
  end

  def test_player_can_learn_new_spaces
    p1 = Player.new([2, 3])
    expected = []
    expected1 = ["A1"]
    expected2 = ["A1", "B4"]
    expected3 = ["A1", "B4", "D2"]
    expected4 = ["A1", "B4", "D2", "K12"]

    actual = p1.known_spaces
    assert_equal expected, actual

    p1.uncover("A1")
    actual1 = p1.known_spaces
    assert_equal expected1, actual1

    p1.uncover("B4")
    actual2 = p1.known_spaces
    assert_equal expected2, actual2

    p1.uncover("D2")
    actual3 = p1.known_spaces
    assert_equal expected3, actual3

    p1.uncover("K12")
    actual4 = p1.known_spaces
    assert_equal expected4, actual4
  end

  def test_player_starts_with_given_number_of_ships
    p1 = Player.new([2, 3])
    p2 = Player.new([2, 3, 4])
    p3 = Player.new([2, 3, 4, 5])

    assert_equal 2, p1.ship_count
    assert_equal 3, p2.ship_count
    assert_equal 4, p3.ship_count
  end

  def test_player_instantiates_ships_upon_instantiation
    p1 = Player.new([2, 3])
    p2 = Player.new([2, 3, 4])
    p3 = Player.new([2, 3, 4, 5])

    actual1 = p1.assemble_the_fleet.map do |ship|
      [ship.class, ship.length]
    end
    expected1 = [[Ship, 2], [Ship, 3]]

    actual2 = p2.assemble_the_fleet.map do |ship|
      [ship.class, ship.length]
    end
    expected2 = [[Ship, 2], [Ship, 3], [Ship, 4]]

    actual3 = p3.assemble_the_fleet.map do |ship|
      [ship.class, ship.length]
    end
    expected3 = [[Ship, 2], [Ship, 3], [Ship, 4], [Ship, 5]]

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3

  end


  def test_player_can_place_ship
    p1 = Player.new([2, 3])
    p2 = Player.new([2, 3, 4])
    p3 = Player.new([2, 3, 4, 5])
    expected1_start = "A1"
    expected1_end = "B1"
    expected2_start = "C5"
    expected2_end = "C7"
    expected3_start = "K12"
    expected3_end = "K7"

    ship1a = p1.fleet[0]
    p1.place_ship(ship1a, "A1", "B1")
    actual1_start = ship1a.start_space
    actual1_end = ship1a.end_space

    ship2a = p2.fleet[1]
    p2.place_ship(ship2a, "C5", "C7")
    actual2_start = ship2a.start_space
    actual2_end = ship2a.end_space

    ship3a = p3.fleet[3]
    p3.place_ship(ship3a, "K12", "K7")
    actual3_start = ship3a.start_space
    actual3_end = ship3a.end_space

    assert_equal expected1_start, actual1_start
    assert_equal expected1_end, actual1_end

    assert_equal expected2_start, actual2_start
    assert_equal expected2_end, actual2_end

    assert_equal expected3_start, actual3_start
    assert_equal expected3_end, actual3_end
  end

end
