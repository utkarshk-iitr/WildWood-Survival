extends CharacterBody2D

var speed = 80
var health = 100
var dead = false
var player_in_area = false
var player = null
var attackable = false
var damage = true

func _ready():
	dead = false

func _physics_process(_delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position)/speed
			if position.x>player.position.x: $AnimatedSprite2D.flip_h = true
			else: $AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("idle")
	else:
		$detection_area/CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("death")
	
	move_and_slide()

func _process(_delta):
	if attackable and damage:
		player.dech(15)
		damage = false
		$Timer.start()

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func _on_hitbox_area_entered(area):
	var damag = 0
	if area.has_method("arrow_damage"): damag = 50
	elif area.has_method("sword_damage"): damag = 100
	take_damage(damag)
	
func take_damage(dmg):
	health -= dmg
	if health<=0 and !dead: death()

func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		attackable = true
		player = body

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		attackable = false

func _on_timer_timeout():
	damage = true
