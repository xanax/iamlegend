extends KinematicBody2D

var velocity = Vector2.ZERO
var max_speed = 300
var bullet = preload("res://Bullet.tscn")
var is_right = true
var fired_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
		scale.x = -1	

func get_input():
	if Input.is_action_pressed("ui_accept"):
		shoot()
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		if(!is_right):
			scale.x = -1
		is_right = true
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		if(is_right):
			scale.x = -1
		is_right = false
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
		
func shoot():
	var time = OS.get_system_time_msecs()
	if(time - fired_time > 100):
		OS.get_system_time_msecs()
		var b = bullet.instance()
		b.start($Muzzle.global_position, is_right)
		get_parent().add_child(b)
		fired_time = time

func _physics_process(delta):
	get_input()
	velocity = velocity.normalized() * delta * max_speed
	move_and_collide(velocity)
	velocity = Vector2.ZERO
