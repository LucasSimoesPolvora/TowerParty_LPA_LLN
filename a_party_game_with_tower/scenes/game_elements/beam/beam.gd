extends Node2D

var max_X = null
var min_X = null
var cpt = 0

func updateBeam(fallingPiece, beam):
	max_X = null
	min_X = null
	cpt = 0

	for piece in fallingPiece.get_children():
		var coners_list = piece.get_node("border")
		for corner in coners_list.get_children():
			cpt += 1
			print("Piece : ", piece.position)
			print("Corner : ",cpt)
			print("X,Y : ", corner.position)
			var rotated_position = piece.to_global(corner.position)
			print("Rotate X : ",rotated_position.x," Rotate Y : ",rotated_position.y)

			if max_X == null or max_X < rotated_position.x:
				max_X = rotated_position.x
			if min_X == null or min_X > rotated_position.x:
				min_X = rotated_position.x
 
	beam.position.x = (min_X + max_X) / 2
	beam.scale.x = abs(max_X - min_X) / beam.texture.get_width()
	beam.scale.y = 20000
	print("beam position : ", beam.position)
