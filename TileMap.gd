extends TileMap

const size = Vector2(100, 100)
const MoveAction = preload("res://MoveAction.gd")
const MoveBigAction = preload("res://MoveBigAction.gd")
const Tiles = preload("res://Tiles.gd") 
var updateThread = preload("res://UpdateThread.gd").new(self, "updateTiles")
var movements = []
var sprites = []
var movementIndex = 0
var currentMovesStartIndex = 0
var lastMovesStartIndex = 0
var frame = 0
var step = 1

func _ready():
	get_node("Mask").tileMap = self
	movements.resize(1000000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Start of step, make moves calculated last step
	if(frame == 0):
		sprites.clear()

		#print("Doing moves "+str(currentMovesStartIndex)+" to "+str(movementIndex))
		for m in range(currentMovesStartIndex, movementIndex):
			start_sprite(movements[m])
			movements[m].do(self)

		
		# Update map in a separate thread
		lastMovesStartIndex = currentMovesStartIndex
		currentMovesStartIndex = movementIndex
		updateThread.spawnUpdate()
		
	frame = (frame + step) % 16
	
func updateTiles():
	#print("Updating")
	for y in range(size.y):
		for x in range(size.x):
			var on = Tiles.attrib(get_cell(x, y))
			var up = Tiles.attrib(get_cell(x, y - 1))
			var move
			if(on == Tiles.VOID && up == Tiles.DROP):
				move = MoveAction.new(Vector2(x,y), Vector2(0,-1))
			
			if(move):
				movements[movementIndex] = move
				movementIndex+=1
	#TODO Conflict resolution
	
func start_sprite(movement):
	var source = movement.target + movement.move
	var tile_id = get_cellv(source)
	var tile_sprite = Tiles.type(tile_id).instance()
	sprites.append(tile_sprite)
	tile_sprite.start( source * cell_size, movement.move, step)
	add_child(tile_sprite)
	
