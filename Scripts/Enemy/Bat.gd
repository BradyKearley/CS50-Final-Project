extends KinematicBody2D

var velocity = Vector2(0,1)
var speed = 600
var movecooldown = 0

var bar_red = preload("res://Sprites/Health Bars/barHorizontal_red.png")
var bar_green = preload("res://Sprites/Health Bars/barHorizontal_green.png")
var bar_yellow = preload("res://Sprites/Health Bars/barHorizontal_yellow.png")
var enemyposition = Vector2(0,0)
onready var healthbar = $HealthBar
	
var hp = 50

var maxhp = 50

	
func _ready():
	healthbar.max_value = maxhp
	enemyposition = Vector2(rand_range(-1600,2400),rand_range(-400,600))
	while enemyposition.x < 640 and enemyposition.x > -100 or enemyposition.y < 360 and enemyposition.y > -45:
		enemyposition = Vector2(rand_range(-1600,2400),rand_range(-400,600)) 
		position = enemyposition
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

func _process(delta):
	movecooldown -= delta
func _physics_process(delta):
	velocity = get_parent().get_node("Player").position - position
	var collision = move_and_collide(velocity.normalized() * speed * delta)
	
	
	if collision:
		if collision.collider.is_in_group("Bullets"):
			collision.collider.queue_free()
			hp -= collision.collider.damage
			update_healthbar(hp)
		if hp <= 0:
			Global.score += 5
			queue_free()
