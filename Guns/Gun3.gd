extends AnimatedSprite


onready var ammobar =  get_parent().get_parent().get_parent().get_node("Player/Control/AmmoBar")

#-----------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------#
###GUN IS THE AUTOMATIC GUN TEMPLATE USE FOR AUTOMATIC GUNS###


#change wepon stats
#max ammo and ammo should be the same(how much ammo a gun holds
onready var ammo = 30
var maxammo = 30
#changes how fast the gun reloades
var reloadspeed = 15
#Adds delay befor use of gun when pulling it out(do whatever u feel is best 0 is the most fun for me)
var guncooldown = 0
#Fire speed (lower is better)
var firespeed = 0.07
#Damage will increase Damage of weapon
var Damage = 10
#-----------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------------------------#



#keep 0
var reload = 0



var Bullet = preload("res://TSCN/Bullet.tscn")

func _ready():
	ammobar.value = ammo
	ammobar.max_value = maxammo


func _process(delta):
	ammobar.value = ammo
	if Input.is_action_just_pressed("switch"):
		queue_free()
	get_parent().get_parent().get_node("WeponManager").look_at(get_global_mouse_position())
	guncooldown -= delta
	reload -= delta * reloadspeed
	if Input.is_action_just_pressed("Reload"):
		ammo = 0
	if Input.is_action_pressed("click") and guncooldown <=0 and ammo > 0:
		reload= maxammo
		shoot()
	elif ammo <= 0:
		$GunSFX.stop()
		play("Idle")
		ammobar.value = maxammo-reload
		if reload < 0:
			ammo = maxammo
			ammobar.value = ammo
	elif Input.is_action_pressed("click") == false:
		$GunSFX.stop()
	if ammo > 0:
		reload = maxammo
	if Input.is_action_just_released("click"):
		play("Idle")

func shoot():
		
	$GunSFX.play()
	#GUN SOUND
		
	ammobar.value = ammo
	play("Gun")
	
	#Change how fast a gun shoots
	guncooldown = firespeed
	
	ammo -=1
		
	var bulInst = Bullet.instance()
	get_parent().get_parent().get_parent().add_child(bulInst)
	bulInst.position = get_parent().get_node("Muzzle").global_position
	bulInst.velocity = bulInst.position - get_parent().get_parent().position 
	bulInst.damage = Damage
