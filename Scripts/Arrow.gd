extends KinematicBody2D

var speed = 50
var vel: Vector2 = Vector2()
var start: Vector2
var des: Vector2
var pointing: bool
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('arrows_' + get_parent().name)

func _physics_process(delta):
	if pointing:
		velocity = (des - start).normalized() * speed
		look_at(des)
		if (des - get_global_position()).length() > 5:
			velocity = move_and_slide(velocity)
		else:
			queue_free()

func direct(_start, _des):
	pointing = true
	start = _start
	des = _des.get_global_position()
	
func stop():
	pointing = false
