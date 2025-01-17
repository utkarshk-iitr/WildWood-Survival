extends CharacterBody2D

var speed = 100
var health = 100
var dead = false
var player_in_area = false
var player = null
var damage = true
var attackable = false

@onready var loot = $bluegem
@export var itemRes: InvItem

func _ready():
	$bluegem.visible = false
	dead = false
	
func _physics_process(_delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position)/speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$detection_area/CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("death")
	move_and_slide()

func _process(_delta):
	if attackable and damage:
		player.dech(10)
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
	drop_loot()
	$AnimatedSprite2D.visible = false
	$hitbox/CollisionShape2D.disabled = true
	$detection_area/CollisionShape2D.disabled = true
	
func drop_loot():
	if player!=null:
		loot.visible = true
		await get_tree().create_timer(1).timeout
		player.collect(itemRes)
		loot.visible = false
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
