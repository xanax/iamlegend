extends KinematicBody2D

var max_speed = 300
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
		faceRight()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		faceLeft()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
	if(velocity.x != 0 || velocity.y != 0):
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.stop()
	return velocity
		
func _physics_process(delta):
	var velocity = get_input()
	velocity = velocity.normalized() * delta * max_speed
	move_and_collide(velocity)
	velocity = Vector2.ZERO

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
