# GdUnit generated TestSuite
class_name MainGameTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://scenes/level/main_game.gd'


func test_on_reset_button_pressed() -> void:
	var runner = scene_runner("res://scenes/level/mainGame.tscn")
	var mainGame = runner.invoke("find_child", "MainGame")
	var pieces_node = runner.find_child("pieces")
	var has_fallen_node = pieces_node.get_node("hasFallen")
	for i in range(4):
		has_fallen_node.add_child(Node2D.new())
	
	assert_int(has_fallen_node.get_child_count()).is_equal(0)
