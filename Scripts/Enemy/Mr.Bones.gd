extends KinematicBody2D
var velocity = Vector2(0,1)
var speed = 300
var movecooldown = 0

var bar_red = preload("res://Sprites/Health Bars/barHorizontal_red.png")
var bar_green = preload("res://Sprites/Health Bars/barHorizontal_green.png")
var bar_yellow = preload("res://Sprites/Health Bars/barHorizontal_yellow.png")
onready var healthbar = $HealthBar
var hp = 300

var maxhp = 300

	
func _ready():
	healthbar.max_value = maxhp
	position = Vector2(rand_range(-160,670),rand_range(-90,390))

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
	if velocity.x > 0:
		$AnimatedSprite.play("Moveright")
	else:
		$AnimatedSprite.play("Moveleft")
	var collision = move_and_collide(velocity.normalized() * speed * delta)
	
	
	if collision:
		if collision.collider.is_in_group("Bullets"):
			collision.collider.queue_free()
			hp -= collision.collider.damage
			update_healthbar(hp)
		if hp <= 0:
			Global.score += 5
			queue_free()
