extends Sprite

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("KinematicBody2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + (player.position - position) / .05 * delta
	#position = player.position
