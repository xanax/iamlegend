extends TileMap

var size = Vector2(100, 100)
var Movement = preload("res://Movement.gd")
var movements = []
var frame

func _ready():
	frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(frame == 0):
		movements = []
		for y in range(size.y):
			for x in range(size.x):
				if(self.get_cell(x, y) == -1 && self.get_cell(x, y - 1) == 1):
					var move = Movement.new(Vector2(x,y), Vector2(0,-1))
					movements.append(move)
	var p = $KinematicBody2D.position/16
	if(frame == 15):
		frame = 0
		for m in movements:
			m.do(self)
	else:
		frame += 1
