extends Node2D

var move
var tile_map

func start(tile_map, position, move):
	self.position = position
	self.move = move
	self.tile_map = tile_map

func _process(delta):
	position -= move
	if(tile_map.frame >= 15):
		queue_free()
