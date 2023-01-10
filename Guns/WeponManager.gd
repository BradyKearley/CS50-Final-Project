extends Node2D
onready var Gun1 = preload("res://Guns/Gun1.tscn")
onready var Gun2 = preload("res://Guns/Gun2.tscn")
onready var Gun3 = preload("res://Guns/Gun3.tscn")
onready var Gun4 = preload("res://Guns/Gun4.tscn")
onready var Gun5 = preload("res://Guns/Gun5.tscn")
onready var ammobar =  get_parent().get_node("Control/AmmoBar")
onready var AllGuns = [Gun1, Gun2, Gun3, Gun4, Gun5]
onready var CurrentGuns = [null, null]

var GuninHand = 2
var Gun = null
var Gunammo = null
var Gunammo1 = 5

var firstswap = true
func _ready():
	randomize()
	CurrentGuns[0] = AllGuns[rand_range(0,len(AllGuns))]
	while CurrentGuns[0] == CurrentGuns[1] or CurrentGuns[1] == null:
		CurrentGuns[1] = AllGuns[rand_range(0,len(AllGuns))]
	Gun = CurrentGuns[0].instance()
	add_child(Gun)
	Gunammo = Gun.ammo

func _process(_delta):
		
	
	if Input.is_action_just_pressed("switch"):
		if GuninHand ==1:
			GuninHand = 2
			Gun = CurrentGuns[0].instance()
			add_child(Gun)
			Gun.ammo = Gunammo
			
		else:
			if firstswap:
				GuninHand = 1
				Gun1 = CurrentGuns[1].instance()
				add_child(Gun1)
				Gunammo1 = Gun1.ammo 
				firstswap = false
			else:
				GuninHand = 1
				Gun1 = CurrentGuns[1].instance()
				add_child(Gun1)
				Gun1.ammo = Gunammo1

	if GuninHand== 1:
		Gunammo1= ammobar.value
	else:
		Gunammo=  ammobar.value
