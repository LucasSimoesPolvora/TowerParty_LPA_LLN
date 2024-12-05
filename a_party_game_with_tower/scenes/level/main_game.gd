extends Node2D

var sounds = preload("res://library/sound.gd").new()

var smoothing_speed := 1.0

const SPAWNCHECKPOINT0 = 0
const SPAWNCHECKPOINT1 = -450
const SPAWNCHECKPOINT2 = -1000
var piece_spawn_position_y = SPAWNCHECKPOINT0

var camera
var checkpoint1_timers = []
var checkpoint2_timers = []
var checkpoint3_timers = []
var nextPieceNumber = generateRandomNumber()

@onready var beam = $Beam
@onready var isFalling = $pieces/isFalling

func _ready():
	InitializeCamera()
	InitializeSound()

func InitializeSound():
	add_child(sounds)

func InitializeCamera():
	camera = $Camera2D
	camera.position.y = Global.cameraPositionY

func _process(delta: float) -> void:
	inst()
	handle_user_input_screen_size()
	changeCamera(delta)
	beam.updateBeam(isFalling,beam)

func handle_user_input_screen_size():
	if Input.is_action_just_pressed("fullscreen"):
		Global.change_screen_mode()

func changeCamera(delta: float):
	var target_y = float(Global.cameraPositionY)
	camera.position.y = lerp(camera.position.y, target_y, smoothing_speed * delta)

func generateRandomNumber():
	return randi() % Global.pieces.size()  # Sélectionne une pièce aléatoirement

func inst():
	if Global.spawnBloc:
		var pieces_node = $pieces
		var is_falling_node = pieces_node.get_node("isFalling")
		var has_fallen_node = pieces_node.get_node("hasFallen")

		for piece in is_falling_node.get_children():
			is_falling_node.remove_child(piece)
			has_fallen_node.add_child(piece)
		var piece_data = Global.pieces[nextPieceNumber]  # Récupère les données de la pièce
		nextPieceNumber = generateRandomNumber()
		var piece_instance = piece_data["scene"].instantiate()  # Instancie la scène de la pièce
		
		var next_piece_data = Global.pieces[nextPieceNumber]
		display_next_piece(next_piece_data)
		
		piece_instance.position = Vector2(540, piece_spawn_position_y)
		piece_instance.set_meta("isFalling", true)
		
		is_falling_node.add_child(piece_instance)
		Global.spawnBloc = false

func display_next_piece(next_piece_data):
	var next_piece_preview_node = $nextPiecePreview
	#clean old piece
	for child in next_piece_preview_node.get_children():
		next_piece_preview_node.remove_child(child)
		child.queue_free()
	
	var next_piece_instance = next_piece_data["scene"].instantiate()
	next_piece_instance.set_meta("isPreview", true)
	next_piece_instance.set_meta("isFalling", false)
	next_piece_instance.position = Vector2(0, 0)
	
	next_piece_preview_node.add_child(next_piece_instance)

func appendTimer(timer, checkpointNumber):
	match checkpointNumber:
		1:
			checkpoint1_timers.append(timer)
		2:
			checkpoint2_timers.append(timer)
		3:
			checkpoint3_timers.append(timer)

func _on_checkpoint_timer_timeout(piece_spawn_position_y):
	print("piece_spawn_position_y")
	print(piece_spawn_position_y)
	print("cameraPositionY")
	print(Global.cameraPositionY)
	Global.cameraPositionY = piece_spawn_position_y-150
	print("cameraPositionY after")
	print(Global.cameraPositionY)
	piece_spawn_position_y = piece_spawn_position_y-475
	print("piece_spawn_position_y")
	print(piece_spawn_position_y)

func getPieceSpawnPosition(checkpointNumber: int):
	match checkpointNumber:
		1:
			return SPAWNCHECKPOINT0
		2:
			return SPAWNCHECKPOINT1
		3:
			return SPAWNCHECKPOINT2

func getCheckpointNumber(area: Area2D) -> int:
	var area_position = area.get_parent().position.y
	if area_position > SPAWNCHECKPOINT0:
		return 1
	elif area_position > SPAWNCHECKPOINT1:
		return 2
	else:
		return 3

func _on_checkpoint_area_entered(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	var checkpointNumber = getCheckpointNumber(area)
	var potential_piece_spawn_position_y = getPieceSpawnPosition(checkpointNumber)
	if potential_piece_spawn_position_y<piece_spawn_position_y:
		piece_spawn_position_y = potential_piece_spawn_position_y
	
	var timer = Timer.new()
	timer.wait_time = 3
	timer.one_shot = true
	timer.set_meta("name", area.get_parent().get_parent().name)
	timer.timeout.connect(Callable(self, "_on_checkpoint_timer_timeout").bind(timer, piece_spawn_position_y))
	appendTimer(timer, checkpointNumber)
	add_child(timer)
	timer.start()

func _on_checkpoint_area_exited(area: Area2D):
	if not area.name == "piece":
		return
	
	var checkpointNumber = getCheckpointNumber(area)
	removeTimer(checkpointNumber, area)

func removeTimer(checkpointNumber, area):
	match checkpointNumber:
		1:
			for timer in checkpoint1_timers:
				if timer.get_meta("name") == area.get_parent().get_parent().name:
					timer.stop()
					checkpoint1_timers.erase(timer)
			
					if not checkpoint1_timers.size()>0 && not area.get_parent().get_meta("isFalling"):
						Global.cameraPositionY = get_parent().position.y+60
						timer.queue_free()
		2:
			for timer in checkpoint2_timers:
				if timer.get_meta("name") == area.get_parent().get_parent().name:
					timer.stop()
					checkpoint2_timers.erase(timer)
			
					if not checkpoint2_timers.size()>0 && not area.get_parent().get_meta("isFalling"):
						Global.cameraPositionY = get_parent().position.y+60
						timer.queue_free()
		3:
			for timer in checkpoint3_timers:
				if timer.get_meta("name") == area.get_parent().get_parent().name:
					timer.stop()
					checkpoint3_timers.erase(timer)
			
					if not checkpoint3_timers.size()>0 && not area.get_parent().get_meta("isFalling"):
						Global.cameraPositionY = get_parent().position.y+60
						timer.queue_free()


func _on_reset_button_pressed() -> void:
	var hasFallen = $pieces/hasFallen
	for child in hasFallen.get_children():
		child.queue_free()
