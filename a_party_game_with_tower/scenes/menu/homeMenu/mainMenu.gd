extends Control

var BackgroundNode
var SettingButton : Button
var PlayingButton : Button
var ScreenModeButton : Button
var TitleLabel : Label
var buttons = []

const BUTTON_WIDTH_RATIO = 0.1
const BUTTON_HEIGHT_RATIO = 0.08
const BUTTON_POSITION_X_RATIO = 0.85
const BUTTON_POSITION_Y_RATIO = 0.85

# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundNode = $background
	SettingButton = $settingsButton
	PlayingButton = $playingButton
	TitleLabel = $title
	ScreenModeButton = $fullscreenButton
	
	buttons.append(PlayingButton)
	buttons.append(SettingButton)
	
	change_button_font_size()
	Global.syncMenuTitle(TitleLabel)
	Global.syncMenuButtonsSize(buttons)
	
	var callable = Callable(self, "_on_size_changed")
	get_viewport().connect("size_changed", callable)

func _on_size_changed():
	change_button_font_size()
	
	Global.syncMenuTitle(TitleLabel)
	Global.syncMenuButtonsSize(buttons)

func _on_playing_button_pressed():
	get_tree().change_scene_to_file(Global.gamemodeScene)

func _process(delta: float) -> void:
	handle_user_input_screen_size()

func handle_user_input_screen_size():
	if Input.is_action_just_pressed("fullscreen"):
		Global.change_screen_mode()
		changeText()

func change_button_font_size():
	ScreenModeButton.add_theme_font_size_override("font_size", get_viewport().size.y / 45)
	
	var width = get_viewport().size.x * BUTTON_WIDTH_RATIO
	var heigth = get_viewport().size.y * BUTTON_HEIGHT_RATIO
	ScreenModeButton.size= Vector2(width, heigth)
	
	ScreenModeButton.position.x = get_viewport().size.x * BUTTON_POSITION_X_RATIO
	ScreenModeButton.position.y = get_viewport().size.y * BUTTON_POSITION_Y_RATIO

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


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.parameterScene)
