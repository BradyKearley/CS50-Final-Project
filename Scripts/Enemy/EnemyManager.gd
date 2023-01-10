extends Node2D
var Slime = preload("res://TSCN/Enemys/Slime.tscn")
var Bat = preload("res://TSCN/Enemys/Bat.tscn")
var Mr_Bones = preload("res://TSCN/Enemys/Mr.Bones.tscn")
var SlimeBoss = preload("res://TSCN/Enemys/SlimeBoss.tscn")
var Mr_BonesBoss = preload("res://TSCN/Enemys/Mr.BonesBoss.tscn")
var slimecooldown = 0
var batcooldown = 0
var mrbonecooldown = 0
var slimebosscooldown = 0
var bonesbosscooldown = 0
var enemypos = Vector2(1023,1232)
var rng = RandomNumberGenerator.new()
var ranx = 1364
var rany = 1234
var slimebossspawn = false
var Mrbonesboss = false
func slimebossspawn():
	rng.randomize()
	var slimeInst = SlimeBoss.instance()
	get_parent().get_parent().add_child(slimeInst)
	rany = rng.randi_range(-1600,1600)
	ranx = rng.randi_range(-1824,1824)
	if rany > 1000 or rany <-1000 or ranx > 1424 or ranx < -1424:
		enemypos = Vector2(ranx,rany)
	slimeInst.position = enemypos + global_position


func slimespawn():
	rng.randomize()
	var slimeInst = Slime.instance()
	get_parent().get_parent().add_child(slimeInst)
	rany = rng.randi_range(-1600,1600)
	ranx = rng.randi_range(-1824,1824)
	if rany > 1000 or rany <-1000 or ranx > 1424 or ranx < -1424:
		enemypos = Vector2(ranx,rany)
	slimeInst.position = enemypos + global_position
	
func mrbonespawn():
	var mrbones = Mr_Bones.instance()
	get_parent().get_parent().add_child(mrbones)
	rng.randomize()
	rany = rng.randi_range(-1600,1600)
	ranx = rng.randi_range(-1824,1824)
	if rany > 1000 or rany <-1000 or ranx > 1424 or ranx < -1424:
		enemypos = Vector2(ranx,rany)
	mrbones.position = enemypos + global_position
	
func mrbonebossspawn():
	var mrbones = Mr_BonesBoss.instance()
	get_parent().get_parent().add_child(mrbones)
	rng.randomize()
	rany = rng.randi_range(-1600,1600)
	ranx = rng.randi_range(-1824,1824)
	if rany > 1000 or rany <-1000 or ranx > 1424 or ranx < -1424:
		enemypos = Vector2(ranx,rany)
	mrbones.position = enemypos + global_position
func batspawn():
	var batInst = Bat.instance()
	get_parent().get_parent().add_child(batInst)
	rng.randomize()
	rany = rng.randi_range(-1600,1600)
	ranx = rng.randi_range(-1824,1824)
	if rany > 1000 or rany <-1000 or ranx > 1424 or ranx < -1424:
		enemypos = Vector2(ranx,rany)
	batInst.position = enemypos + global_position
func _process(delta):
	mrbonecooldown -= delta
	batcooldown -= delta
	slimecooldown -= delta
	bonesbosscooldown -= delta
	slimebosscooldown -= delta
	if Global.score >= 0 and Global.score <= 10:
		if slimecooldown < 0:
			slimecooldown = 1.5
			slimespawn()
	elif Global.score > 10 and Global.score <= 50:
		if slimecooldown < 0:
			slimecooldown = 4
			slimespawn()
		if mrbonecooldown < 0:
			mrbonecooldown = 5
			mrbonespawn()
				
	elif Global.score > 50 and Global.score <= 70:
		if slimecooldown < 0:
			slimecooldown = 2
			slimespawn()
		if batcooldown < 0:
			batcooldown = 7
			batspawn()
	elif Global.score > 70 and Global.score <= 99:
		if slimecooldown < 0:
			slimecooldown = 2
			slimespawn()
		if batcooldown < 0:
			batcooldown = 10
			batspawn()
		if mrbonecooldown < 0:
			mrbonecooldown = 8
			mrbonespawn()
	elif Global.score >= 100 and Global.score <= 150:	
		if slimecooldown < 0:
			slimecooldown = 3
			slimespawn()
		if slimebossspawn == false:
			slimebossspawn = true
			slimebossspawn()
		
	elif  Global.score > 150 and Global.score <= 170:
		if slimecooldown < 0:
			slimecooldown = 3
			slimespawn()
		if batcooldown < 0:
			batcooldown = 10
			batspawn()
		if mrbonecooldown < 0:
			mrbonecooldown = 8
			mrbonespawn()
	elif  Global.score > 170 and Global.score <= 200:
		if mrbonecooldown < 0:
			mrbonecooldown = 4
			mrbonespawn()
	elif  Global.score > 200 and Global.score <= 300:
		if Mrbonesboss == false:
			Mrbonesboss = true
			mrbonebossspawn()
		if mrbonecooldown < 0:
			mrbonecooldown = 8
			mrbonespawn()
	elif  Global.score > 300:
		if Mrbonesboss == true and slimebossspawn == true:
			slimebosscooldown = 20
			bonesbosscooldown = 50
		if slimecooldown < 0:
			slimecooldown = 3
			slimespawn()
		if mrbonecooldown < 0:
			mrbonecooldown = 8
			mrbonespawn()
		if batcooldown < 0:
			batcooldown = 10
			batspawn()
		if slimebosscooldown < 0:
			slimebosscooldown = 50
			slimebossspawn()
		if bonesbosscooldown < 0:
			bonesbosscooldown = 50
			mrbonebossspawn()
