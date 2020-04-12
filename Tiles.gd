extends Object

const Rock = preload("res://Rock.tscn")
const Dirt = preload("res://Dirt.tscn")

const DROP = 1
const VOID = 2
const DIG =  4
 
static func type(id):
	match id:
		1:
			return Rock
		2:
			return Dirt

static func attrib(id):
	match id:
		-1:
			return VOID
		1:
			return DROP
		2:
			return DIG


