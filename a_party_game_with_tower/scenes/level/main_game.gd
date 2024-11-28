extends Node2D

var smoothing_speed := 1.0

const SPAWNCHECKPOINT0 = 0
const SPAWNCHECKPOINT1 = -450
const SPAWNCHECKPOINT2 = -1000
var pieceSpawnPosY = SPAWNCHECKPOINT0

var camera
var timersCheckpoint1 = []
var timersCheckpoint2 = []
var timersCheckpointFinal = []

func _ready():
	camera = $Camera2D
	
	camera.position.y = Global.cameraPositionY

func _process(delta: float) -> void:
	inst()
	changeCamera(delta)
	print("Checkpoint 1 :")
	print(timersCheckpoint1)
	
	print("Checkpoint 2:")
	print(timersCheckpoint2)
	
	print("Checkpoint final")
	print(timersCheckpointFinal)

func changeCamera(delta: float):
	var target_y = float(Global.cameraPositionY)
	camera.position.y = lerp(camera.position.y, target_y, smoothing_speed * delta)

func inst():
	if Global.spawnBloc:
		var random_index = randi() % Global.pieces.size()  # Sélectionne une pièce aléatoirement
		var piece_data = Global.pieces[random_index]  # Récupère les données de la pièce
		var instance = piece_data["scene"].instantiate()  # Instancie la scène de la pièce
		
		instance.pos1 = piece_data["pos1"]
		instance.pos2 = piece_data["pos2"]
		instance.pos3 = piece_data["pos3"]
		instance.pos4 = piece_data["pos4"]
		instance.position = Vector2(540, pieceSpawnPosY)
		instance.set_meta("isFalling", true)
		
		add_child(instance)
		Global.spawnBloc = false

func _on_checkpoint_1_area_entered(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	pieceSpawnPosY = SPAWNCHECKPOINT1
	
	var new_timer = Timer.new()
	new_timer.wait_time = 3
	new_timer.one_shot = true
	new_timer.set_meta("name", area.get_parent().get_parent().name)
	new_timer.timeout.connect(Callable(self, "_on_checkpoint_1_timer_timeout").bind(new_timer))
	timersCheckpoint1.append(new_timer)
	add_child(new_timer)
	new_timer.start()

func _on_checkpoint_1_area_exited(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	for timer in timersCheckpoint1:
		if timer.get_meta("name") == area.get_parent().get_parent().name:
			timer.stop()
			timersCheckpoint1.erase(timer)
			
			if not timersCheckpoint1.size()>0 && not area.get_parent().get_parent().get_meta("isFalling"):
				Global.cameraPositionY = get_parent().position.y+60
			pieceSpawnPosY = SPAWNCHECKPOINT0
			timer.queue_free()

func _on_checkpoint_2_area_entered(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	pieceSpawnPosY = SPAWNCHECKPOINT2
	
	var new_timer = Timer.new()
	new_timer.wait_time = 3
	new_timer.one_shot = true
	new_timer.set_meta("name", area.get_parent().get_parent().name)
	new_timer.timeout.connect(Callable(self, "_on_checkpoint_2_timer_timeout").bind(new_timer))
	timersCheckpoint2.append(new_timer)
	add_child(new_timer)
	new_timer.start()

func _on_checkpoint_2_area_exited(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	for timer in timersCheckpoint2:
		if timer.get_meta("name") == area.get_parent().get_parent().name:
			timer.stop()
			timersCheckpoint2.erase(timer)
			
			if not timersCheckpoint2.size()>0 && not area.get_parent().get_parent().get_meta("isFalling"):
				Global.cameraPositionY = get_parent().position.y+60
			pieceSpawnPosY = SPAWNCHECKPOINT1
			timer.queue_free()

func _on_checkpoint_final_area_entered(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	var new_timer = Timer.new()
	new_timer.wait_time = 3
	new_timer.one_shot = true
	new_timer.set_meta("name", area.get_parent().get_parent().name)
	new_timer.timeout.connect(Callable(self, "_on_checkpoint_final_timer_timeout").bind(new_timer))
	timersCheckpointFinal.append(new_timer)
	add_child(new_timer)
	new_timer.start()

func _on_checkpoint_final_area_exited(area: Area2D) -> void:
	if not area.name == "piece":
		return
	
	for timer in timersCheckpointFinal:
		if timer.get_meta("name") == area.get_parent().get_parent().name:
			timer.stop()
			timersCheckpointFinal.erase(timer)
			timer.queue_free()

func _on_checkpoint_1_timer_timeout(_timer: Timer) -> void:
	Global.cameraPositionY = SPAWNCHECKPOINT0-111
	pieceSpawnPosY = SPAWNCHECKPOINT1

func _on_checkpoint_final_timer_timeout(_timer: Timer) -> void:
	queue_free()
	
	var label = Label.new()
	label.text = "You won" #TODO : new scene
	get_tree().root.add_child(label)

func _on_checkpoint_2_timer_timeout(_timer: Timer) -> void:
	Global.cameraPositionY = SPAWNCHECKPOINT1-111
	pieceSpawnPosY = SPAWNCHECKPOINT2
