extends Node2D

onready var capitals: Array = get_tree().get_nodes_in_group("capitals")

var speed = 20
var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	prep_for_war()

func _process(delta):
	vel = Vector2(speed, 0)
	$Sprite.translate(vel * delta)

func prep_for_war():
	for c in capitals:
		c.get_random_enemy()

func war_time():
	for c in capitals:
		c.fight()

func _on_Button_button_up():
	war_time()
