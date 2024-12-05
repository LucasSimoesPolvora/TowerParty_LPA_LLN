extends Node

var move_sound : AudioStreamPlayer
var rotation_sound : AudioStreamPlayer
var start_game_sound : AudioStreamPlayer
var touch_floor_sound : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_sound = AudioStreamPlayer.new()
	rotation_sound = AudioStreamPlayer.new()
	start_game_sound = AudioStreamPlayer.new()
	touch_floor_sound = AudioStreamPlayer.new()
	
	self.add_child(move_sound)
	self.add_child(rotation_sound)
	self.add_child(start_game_sound)
	self.add_child(touch_floor_sound)
	
	move_sound.stream = load("res://Assets/Sounds/move.mp3")
	rotation_sound.stream = load("res://Assets/Sounds/rotation.mp3")
	start_game_sound.stream = load("res://Assets/Sounds/startGame.mp3")
	touch_floor_sound.stream = load("res://Assets/Sounds/touchFloor.mp3")

func moveSound():
	move_sound.play()
	pass

func rotationSound():
	rotation_sound.play()
	pass

func startGameSound():
	start_game_sound.play()
	pass

func touchFloorSound():
	touch_floor_sound.play()
	pass
