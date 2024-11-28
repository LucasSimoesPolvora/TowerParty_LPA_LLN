extends Node

@export var spawnBloc = true
@export var nbrPiece = 1

@export var cameraPositionY = 300
@export var pieces_pos_y = []
@export var highestPiece = 450 #random value

@export var pieces  = [ #we can use it to define specific value like color/style
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/I/piece_I.tscn"),
		"pos1": 2, #number of square higher than the rigidbody
		"pos2": 0.5,
		"pos3": 2,
		"pos4": 0.5,
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/J/piece_J.tscn"),
		"pos1": 1,
		"pos2": 2,
		"pos3": 1,
		"pos4": 1,
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/L/piece_L.tscn"),
		"pos1": 1,
		"pos2": 1.5,
		"pos3": 1,
		"pos4": 1.5,
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/O/piece_O.tscn"),
		"pos1": 1,
		"pos2": 1,
		"pos3": 1,
		"pos4": 1,
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/S/piece_S.tscn"),
		"pos1": 1,
		"pos2": 2,
		"pos3": 1,
		"pos4": 1,
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/T/piece_T.tscn"),
		"pos1": 1,
		"pos2": 2,
		"pos3": 1,
		"pos4": 1,
	},
	{
		"scene": preload("res://scenes/game_elements/pieces/basics/Z/piece_Z.tscn"),
		"pos1": 1,
		"pos2": 2,
		"pos3": 1,
		"pos4": 1,
	}
]
