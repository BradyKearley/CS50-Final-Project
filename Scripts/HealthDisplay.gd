extends Node2D

var bar_red = preload("res://Sprites/Health Bars/barHorizontal_red.png")
var bar_green = preload("res://Sprites/Health Bars/barHorizontal_green.png")
var bar_yellow = preload("res://Sprites/Health Bars/barHorizontal_yellow.png")

onready var healthbar = $HealthBar
func _ready():
	hide()
	
	healthbar.max_value = get_parent().slimehp
		
func _process(delta):
	global_rotation = 0

func update_healthbar(value):
	healthbar.texture_progress = bar_green
	if value < 70:
		healthbar.texture_progress = bar_yellow
	if value < 35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		show()
	healthbar.value = value
