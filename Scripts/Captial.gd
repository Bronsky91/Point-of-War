extends Node2D

export (PackedScene) var arrow

onready var target_capital: Node2D
onready var map: Node2D = get_parent()
onready var a_slider: VSlider = $AttackSlider
onready var d_slider: VSlider = $DefendSlider
onready var a_label: Label = $AttackLabel
onready var d_label: Label = $DefendLabel

var capitals: Array = []
var attack_points: int
var defend_points: int

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_tree().get_nodes_in_group("capitals"):
		if c != self:
			capitals.append(c)
	randomize()
	attack_points = randi()%11+1
	defend_points = randi()%11+1
	print(name)
	print(attack_points)
	print(defend_points)
#func _process(delta):
#	pass

func get_random_enemy():
	randomize()
	point(capitals[randi()%len(capitals)-1])

func fight():
	var tc_defend = margin_for_victory(target_capital.defend_points)
	var c_attack = margin_for_victory(attack_points)
	print(target_capital.name)
	if c_attack > tc_defend:
		declare("WON")
	else:
		declare("LOST")
	$ArrowTimer.stop()
	
func point(c):
	target_capital = c
	var new_arrow = arrow.instance()
	add_child(new_arrow)
	new_arrow.direct(position, c)

func _on_ArrowTimer_timeout():
	point(target_capital)

func margin_for_victory(points):
	randomize()
	var maxP = float(points) * .12
	var minP = maxP * -1
	var margin = rand_range(minP, maxP)
	return points + margin
	
func declare(outcome):
	$Label.text = outcome
