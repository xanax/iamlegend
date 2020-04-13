extends KinematicBody2D

var move
var step
var frame = 0

func start(position, move, step):
	self.position = position
	self.move = move
	self.step = step

func _process(delta):
	position -= move * step
	frame += step
	if(frame > 15):
		queue_free()
