extends Node

@export var spawnBloc = true

@export var pieceSpeed = 100 #mock value

@export var playingScene = "res://scenes/level/mainGame.tscn"
@export var gamemodeScene = "res://scenes/menu/gamemode/gamemode.tscn"
@export var mainMenuScene = "res://scenes/menu/homeMenu/menu.tscn"
@export var parameterScene = "res://scenes/menu/parameter/parameter.tscn"

@export var pieces  = [ #we can use it to define specific value like color/style
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/I/piece_I.tscn"),
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/J/piece_J.tscn"),
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/L/piece_L.tscn"),
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/O/piece_O.tscn"),
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/S/piece_S.tscn"),
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/T/piece_T.tscn"),
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/Z/piece_Z.tscn"),
	}
]

func change_screen_mode():
	var mode = DisplayServer.window_get_mode()
	var new_mode
	
	if (mode == DisplayServer.WINDOW_MODE_WINDOWED):
		new_mode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
		
	else:
		new_mode = DisplayServer.WINDOW_MODE_WINDOWED
		
	DisplayServer.window_set_mode(new_mode)
	
func syncMenuButtonsSize(buttonArray: Array):
	var screen_size = get_viewport().size
	
	var width = get_viewport().size.x * 0.2
	var height = get_viewport().size.y * 0.08
	
	var initial_y = screen_size.y * 0.5 - (buttonArray.size() * height + (buttonArray.size() - 1) * screen_size.y * 0.05) / 2

	
	for index in range(buttonArray.size()):
		var button = buttonArray[index]
		
		button.add_theme_font_size_override("font_size", screen_size.x / 50)
		button.size = Vector2(width, height)
		
		button.position.x = screen_size.x / 2 - width / 2
		button.position.y = initial_y + index * (height + screen_size.y * 0.05)

func syncButtonsBottomRight(buttonArray: Array):
	var screen_size = get_viewport().size
	
	var width = screen_size.x * 0.2
	var height = screen_size.y * 0.08
	
	var spacing = screen_size.y * 0.05
	
	var initial_y = screen_size.y - (buttonArray.size() * height + (buttonArray.size() - 1) * spacing)
	
	var initial_x = screen_size.x - width
	
	for index in range(buttonArray.size()):
		var button = buttonArray[index]
		
		button.add_theme_font_size_override("font_size", screen_size.x / 50)
		button.size = Vector2(width, height)
		
		button.position.x = initial_x
		button.position.y = initial_y + index * (height + spacing)

func syncMenuTitle(title: Label):
	title.add_theme_font_size_override("font_size", get_viewport().size.x / 10)
	title.position.y = get_viewport().size.y - get_viewport().size.y * 0.95
