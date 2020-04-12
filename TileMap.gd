extends TileMap

var size = Vector2(100, 100)
var Movement = preload("res://Movement.gd")
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
	if(frame == 0):
		updateSemaphore.increment_counter()
		for m in range(lastMovementIndex, movementIndex):
			movements[m].do(self)
	frame += 1
	if(frame > 15):
		frame = 0

func update():
	print("Updating")
	lastMovementIndex = movementIndex
	for y in range(size.y):
		for x in range(size.x):
			if(self.get_cell(x, y) == -1 && self.get_cell(x, y - 1) == 1):
				var move = Movement.new(Vector2(x,y), Vector2(0,-1))
				movements[movementIndex] = move
				movementIndex+=1
	
