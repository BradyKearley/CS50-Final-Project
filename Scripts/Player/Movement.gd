extends KinematicBody2D

export (int) var speed = 600

var velocity = Vector2()
var BulSpeed = 1000
onready var dash = true

var bar_red = preload("res://Sprites/Health Bars/barHorizontal_red.png")
var bar_green = preload("res://Sprites/Health Bars/barHorizontal_green.png")
var bar_yellow = preload("res://Sprites/Health Bars/barHorizontal_yellow.png")
onready var healthbar = $PlayerHealth
var maxhp = 5

var Playerhp = 5
var invinciblity = 0
var enemys = ["Slime","MrBones","Bat", "SlimeBoss", "Mr.BonesBoss"]
func update_healthbar(value):
	healthbar.show()
	healthbar.texture_progress = bar_green
	if value < maxhp * .7:
		healthbar.texture_progress = bar_yellow
	if value < maxhp *.35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		healthbar.show()
	healthbar.value = value
func dash():
	speed *= 3
	yield(get_tree().create_timer(.2),"timeout")
	dash = false
	yield(get_tree().create_timer(1),"timeout")
	dash = true
	
func hit():
	Playerhp -=1
	if Playerhp == 0:
		get_tree().change_scene("res://TSCN/Death.tscn")
	invinciblity= 1
	healthbar.show()
	print(Playerhp)
	update_healthbar(Playerhp)
func _process(delta):
	invinciblity -= delta
	
	
	
func get_input():
		
	velocity = velocity.normalized() * speed

	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$AnimatedSprite.play("Walk Right")
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimatedSprite.play("Walk Left")
	elif Input.is_action_pressed("down"):
		velocity.y += 1
		$AnimatedSprite.play("Walk Down")
	elif Input.is_action_pressed("up"):
		velocity.y -= 1
		$AnimatedSprite.play("Walk Up")
	else:
		$AnimatedSprite.play("Idle")
	#Roll
	if Input.is_action_pressed("Roll") and dash == true:
		dash()
	velocity = velocity.normalized() * speed
	speed = 600
func _physics_process(delta):
	get_input()
	var collision = move_and_collide(velocity * delta)
	if collision:
		if invinciblity < 0:
			hit()
