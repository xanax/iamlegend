extends TileMap

var size = Vector2(100, 100)
var Movement = preload("res://Movement.gd")
var Rock = preload("res://Rock.tscn")
var UpdateSemaphore = preload("res://semaphore.gd") 
var updateSemaphore  = UpdateSemaphore.new(self, "update")
var movements = []
var movementIndex = 0
var currentMovementsIndex = 0
var lastMovementIndex = 0
var frame

func _ready():
	movements.resize(1000000)
	frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Start of step, make moves calculated last step
	if(frame == 0):
		print("Doing moves "+str(lastMovementIndex)+" to "+str(movementIndex))
		for m in range(lastMovementIndex, movementIndex):
			start(movements[m])
		lastMovementIndex = movementIndex
		updateSemaphore.increment_counter()
	frame += 1
	if(frame > 15):
		#for m in range(lastMovementIndex, movementIndex):
	#		end(m)
		frame = 0

func update():
	print("Updating")
	for y in range(size.y):
		for x in range(size.x):
			if(self.get_cell(x, y) == -1 && self.get_cell(x, y - 1) == 1):
				var move = Movement.new(Vector2(x,y), Vector2(0,-1))
				movements[movementIndex] = move
				movementIndex+=1
	
func start(movement):
	set_cellv(movement.target, 1)
	var rock = Rock.instance()
	var source = (movement.target + movement.move) * cell_size
	rock.start(source, movement.move)
	set_cell(movement.target.x, movement.target.y + movement.move.y, -1)
	add_child(rock)
	
	
	

