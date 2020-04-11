extends Object

var _target
var _move
var Rock = preload("res://Rock.tscn")

func _init(target, move):
	self._target = target
	self._move = move
	
func do(tile_map : TileMap):
	
	var rock = Rock.instance()
	var source = (_target) * tile_map.cell_size
	rock.start(source, _move)
	tile_map.set_cell(_target.x, _target.y + _move.y, -1)
	tile_map.add_child(rock)
	#print("Move to "+str(_target)+" using "+str(_move))
	
