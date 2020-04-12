extends Node2D

var move

func start(position, move):
	self.position = position
	self.move = move

func _process(delta):
	position -= move
