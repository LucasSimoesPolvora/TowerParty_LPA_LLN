extends Control

var TitleLabel
var LocalButton : Button
var ChallengeButton : Button
var BackButton : Button
var buttons = []

const BACK_BUTTON_WIDTH_RATIO = 0.08
const BACK_BUTTON_HEIGHT_RATIO = 0.08
const BACK_BUTTON_POSITION_RATIO = 0.95

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LocalButton = $localButton
	ChallengeButton = $challengeButton
	TitleLabel = $title
	BackButton = $backButton
	
	buttons.append(LocalButton)
	buttons.append(ChallengeButton)
	
	Global.syncMenuButtonsSize(buttons)
	Global.syncMenuTitle(TitleLabel)
	
	change_back_size()
	
	var callable = Callable(self, "_on_size_changed")
	get_viewport().connect("size_changed", callable)

func _on_size_changed():
	Global.syncMenuButtonsSize(buttons)
	Global.syncMenuTitle(TitleLabel)
	change_back_size()

func change_back_size():
	var width = get_viewport().size.x * BACK_BUTTON_WIDTH_RATIO
	var height = get_viewport().size.x * BACK_BUTTON_HEIGHT_RATIO
	
	var screen_width = get_viewport().size.x
	var screen_heigth = get_viewport().size.y
	
	BackButton.position.y = get_viewport().size.y - get_viewport().size.y * BACK_BUTTON_POSITION_RATIO
	BackButton.position.x = get_viewport().size.x - get_viewport().size.x * BACK_BUTTON_POSITION_RATIO
	
	BackButton.size = Vector2(width, height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_user_input_screen_size()

func handle_user_input_screen_size():
	if Input.is_action_just_pressed("fullscreen"):
		Global.change_screen_mode()

func _on_local_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.playingScene)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.mainMenuScene)

func _on_fullscreen_button_pressed() -> void:
	Global.change_screen_mode()
	changeText()

func changeText():
	var buttonFullScreen = $fullscreenButton
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_WINDOWED:
		buttonFullScreen.text = "Plein écran"
	else:
		buttonFullScreen.text = "Fenêtrée"
