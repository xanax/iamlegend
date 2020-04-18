extends KinematicBody2D

var max_speed = 5000
var bullet = preload("res://Bullet.tscn")
var facing_right = false
var last_fired_time = 0
var fire_delay = 50

# Called when the node enters the scene tree for the first time.
#func _ready():

func get_input():
	var velocity: Vector2
	if Input.is_action_pressed("ui_accept"):
		shoot()
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		position.y = round(position.y / 16.0) * 16 
		#faceRight()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		position.y = round(position.y / 16.0) * 16 
		#faceLeft()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
		position.x = round((position.x - 8) / 16.0) * 16 + 8
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
		position.x = round((position.x - 8) / 16.0) * 16 + 8
	##if(velocity.x != 0 || velocity.y != 0):
	#	$AnimatedSprite.play("run")
	#else:
#		$AnimatedSprite.stop()
	return velocity
		
func _physics_process(delta):
	var velocity = get_input()
	velocity = velocity.normalized() * delta * max_speed
	move_and_slide(velocity)
	#print(get_slide_count())
	#if(get_slide_count() > 2):
	#move_and_slide(-velocity)
	velocity = Vector2.ZERO
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("Collided with: ", collision.position)
		# Confirm the colliding body is a TileMap
		if collision.collider is TileMap:
			# Find the character's position in tile coordinates
			var tile_pos = collision.collider.world_to_map(collision.position)
			#collision.collider.get_node("Mask").collisions.append(collision.position)
			#tile_pos -= collision.normal
			# Get the tile id
			var tile_id = collision.collider.get_cellv(tile_pos)
			if(tile_id == 4):
				#collision.collider.dig_tiles.append(tile_pos)
				collision.collider.set_cellv(tile_pos, -1)

		
func shoot():
	var time = OS.get_system_time_msecs()
	if(time - last_fired_time > fire_delay):
		var b = bullet.instance()
		b.start($Muzzle.global_position, facing_right)
		get_parent().add_child(b)
		last_fired_time = time

func faceLeft():
	if(facing_right):
		scale.x = -1
		facing_right = false
	
func faceRight():
	if(!facing_right):
		scale.x = -1
		facing_right = true
