extends Control

const BACK_BUTTON_WIDTH_RATIO = 0.08
const BACK_BUTTON_HEIGHT_RATIO = 0.08
const BACK_BUTTON_POSITION_RATIO = 0.95
const BUTTON_WIDTH_RATIO = 0.1
const BUTTON_HEIGHT_RATIO = 0.08
const BUTTON_POSITION_X_RATIO = 0.85
const BUTTON_POSITION_Y_RATIO = 0.85

var back_button : Button
var buttons = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defineValue()
	Global.syncMenuButtonsSize(buttons)
	change_back_size()

func defineValue():
	back_button = $backButton
	buttons.append(back_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_user_input_screen_size()

func handle_user_input_screen_size():
	if Input.is_action_just_pressed("fullscreen"):
		Global.change_screen_mode()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.mainMenuScene)

func change_back_size():
	var width = get_viewport().size.x * BACK_BUTTON_WIDTH_RATIO
	var height = get_viewport().size.x * BACK_BUTTON_HEIGHT_RATIO
	
	var screen_width = get_viewport().size.x
	var screen_heigth = get_viewport().size.y
	
	back_button.position.y = get_viewport().size.y - get_viewport().size.y * BACK_BUTTON_POSITION_RATIO
	back_button.position.x = get_viewport().size.x - get_viewport().size.x * BACK_BUTTON_POSITION_RATIO
	
	back_button.size = Vector2(width, height)

func _on_fullscreen_button_pressed() -> void:
	Global.change_screen_mode()
