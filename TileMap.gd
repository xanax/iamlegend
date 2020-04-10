extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.get_cell(0,0)
	var p = $KinematicBody2D.position/16
	print(self.get_cell(int(p.x), int(p.y)))
