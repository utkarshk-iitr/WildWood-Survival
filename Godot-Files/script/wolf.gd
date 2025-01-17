extends CharacterBody2D

var speed = 300
var health = 100
var dead = false
var player = null
var player_in_area = false
var attackable = false
var damage = true

func _ready():
	dead = false

func _physics_process(_delta):
	if !dead:
		if player_in_area:
			position += (player.position - position)/speed
			if position.x>player.position.x: $wolf.flip_h = false
			else: $wolf.flip_h = true
		if attackable: $wolf.play("attack")
		else: $wolf.play("move")
	else:
		$wolf.play("death")
	
	move_and_slide()

func _process(_delta):
	if attackable and damage:
		player.dech(20)
		damage = false
		$Timer.start()

func _on_hitbox_area_entered(area):
	var damag = 0
	if area.has_method("arrow_damage"): damag = 50
	elif area.has_method("sword_damage"): damag = 50
	$wolf.play("hurt")
	take_damage(damag)
	
func take_damage(dmg):
	health -= dmg
	if health<=0 and !dead: death()

func death():
	dead = true
	$wolf.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_timer_timeout():
	damage = true

func _on_attack_body_entered(body):
	if body.has_method("player"):
		attackable = true
		player = body

func _on_attack_body_exited(body):
	if body.has_method("player"):
		attackable = false

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body
