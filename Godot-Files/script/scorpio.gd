extends CharacterBody2D

var speed = 400
var health = 100
var dead = false
var player = null
var attackable = false
var player_in_area = false
var damage = true

func _ready():
	dead = false

func _physics_process(_delta):
	if !dead:
		if player_in_area:
			position += (player.position - position)/speed
			if position.x>player.position.x: $scorpio.flip_h = false
			else: $scorpio.flip_h = true
		if attackable: $scorpio.play("attack")
		else: $scorpio.play("move")
	else:
		$scorpio.play("death")
	
	move_and_slide()

func _process(_delta):
	if attackable and damage:
		player.dech(18)
		damage = false
		$Timer.start()

func _on_hitbox_area_entered(area):
	var damag = 0
	if area.has_method("arrow_damage"): damag = 50
	elif area.has_method("sword_damage"): damag = 50
	$scorpio.play("hurt")
	take_damage(damag)
	
func take_damage(dmg):
	health -= dmg
	if health<=0 and !dead: death()

func death():
	dead = true
	$scorpio.play("death")
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
