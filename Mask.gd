extends Node2D


var collisions = []
var tileMap : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func _draw():
	if(tileMap != null):
		for m in range(tileMap.lastMovesStartIndex, tileMap.currentMovesStartIndex):
			var screen = tileMap.movements[m].target * tileMap.cell_size
			draw_rect(Rect2(screen, Vector2(16,16)), Color8(140,140,140))
	for c in collisions:
		draw_rect(Rect2(c, Vector2(2,2)), Color8(255,255,255))
