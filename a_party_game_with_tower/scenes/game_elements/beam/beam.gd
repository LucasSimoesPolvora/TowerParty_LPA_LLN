extends Node2D

var max_X = null
var min_X = null
var cpt = 0

func updateBeam(fallingPiece, beam):
	max_X = null
	min_X = null
	cpt = 0

	for piece in fallingPiece.get_children():
		var coners_list = piece.get_node("coners_list")
		print("Corners list for ", piece.name, ": ")
		for corner in coners_list.get_children():
			cpt += 1
			var rotated_position = to_global(corner.position)
			print(cpt, " ", rotated_position)
			if max_X == null or max_X < rotated_position.x:
				max_X = rotated_position.x
			if min_X == null or min_X > rotated_position.x:
				min_X = rotated_position.x
			print("max x : ", max_X, " min x : ", min_X)   
	beam.position.x = (min_X + max_X) / 2
	beam.scale.x = abs(max_X - min_X) / beam.texture.get_width()
	beam.scale.y = 20000
	print("beam position : ", beam.position)
