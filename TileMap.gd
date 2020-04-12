extends TileMap

const size = Vector2(100, 100)
const MoveAction = preload("res://MoveAction.gd")
const MoveBigAction = preload("res://MoveBigAction.gd")
const Tiles = preload("res://Tiles.gd")
const UpdateSemaphore = preload("res://semaphore.gd") 
var updateSemaphore = UpdateSemaphore.new(self, "update")
var movements = []
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
			start_sprite(movements[m])
			movements[m].do(self)

		
		# Update map in a separate thread
		lastMovementIndex = movementIndex
		updateSemaphore.increment_counter()
		
	frame = (frame + 1) % 16

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
	
func start_sprite(movement):
	var source = movement.target + movement.move
	var tile_id = get_cellv(source)
	var tile_sprite = Tiles.type(tile_id).instance()
	tile_sprite.start(self, source * cell_size, movement.move)
	add_child(tile_sprite)
	
