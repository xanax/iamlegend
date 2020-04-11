extends Node2D

var _move
var frame = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(start : Vector2, move : Vector2):
	position = start
	_move = move
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += _move
	frame+=1
	if(frame == 16):
		queue_free()
