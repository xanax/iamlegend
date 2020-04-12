extends Object

var target
var move

func _init(target, move):
	self.target = target
	self.move = move

func do(tileMap : TileMap):
	var source = target + move
	var tile_id = tileMap.get_cellv(source)
	tileMap.set_cellv(source, -1)
	tileMap.set_cellv(target, tile_id)

func undo():
	pass
