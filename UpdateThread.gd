extends Object

var counter = 0
var mutex
var semaphore
var thread
var exit_thread = false
var tile_map
var function

# The thread will start here.
func _init(tile_map : TileMap, function : String):
	self.tile_map = tile_map
	self.function = function
	mutex = Mutex.new()
	semaphore = Semaphore.new()
	exit_thread = false

	thread = Thread.new()
	thread.start(self, "_thread_function")
	#print("started UpdateThread")

func _thread_function(userdata):
	while true:
		semaphore.wait() # Wait until posted.

		mutex.lock()
		var should_exit = exit_thread # Protect with Mutex.
		mutex.unlock()

		if should_exit:
			break

		mutex.lock()
		counter += 1 # Increment counter, protect with Mutex.
		tile_map.call(function)
		mutex.unlock()

func spawnUpdate():
	semaphore.post() # Make the thread process.

func get_counter():
	mutex.lock()
	# Copy counter, protect with Mutex.
	var counter_value = counter
	mutex.unlock()
	return counter_value

# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
	# Set exit condition to true.
	mutex.lock()
	exit_thread = true # Protect with Mutex.
	mutex.unlock()

	# Unblock by posting.
	semaphore.post()

	# Wait until it exits.
	thread.wait_to_finish()

	# Print the counter.
	#print("Counter is: ", counter)
	
