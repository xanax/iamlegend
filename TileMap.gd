extends TileMap

const size = Vector2(100, 100)
const MoveAction = preload("res://MoveAction.gd")
const MoveBigAction = preload("res://MoveBigAction.gd")
const Tiles = preload("res://Tiles.gd")
const UpdateSemaphore = preload("res://semaphore.gd") 
var updateSemaphore = UpdateSemaphore.new(self, "update")
var movements = []
var sprites = []
var movementIndex = 0
var lastMovementIndex = 0
var frame = 0

func _ready():
	movements.resize(1000000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Start of step, make moves calculated last step
	if(frame == 0):
		print("Doing moves "+str(lastMovementIndex)+" to "+str(movementIndex))
		for m in range(lastMovementIndex, movementIndex):
			start(movements[m])
		
		# Update map in a separate thread
		lastMovementIndex = movementIndex
		updateSemaphore.increment_counter()
		
	frame += 1
	if(frame > 15):
		for s in sprites:
			remove_child(s)
		sprites.clear()
		frame = 0

func update():
	print("Updating")
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
	
func start(movement):
	var source = movement.target + movement.move
	var tile_id = get_cellv(source)
	set_cellv(movement.target, tile_id)
	var tile_sprite = Tiles.type(tile_id).instance()
	sprites.append(tile_sprite)
	tile_sprite.start(source * cell_size, movement.move)
	set_cellv(source, -1)
	add_child(tile_sprite)
