extends Node2D

var move
var tile_map
var frame = 0

func start(position, move):
	self.position = position
	self.move = move

func _process(delta):
	position -= move
	frame += 1
	if(frame == 16):
		queue_free()
