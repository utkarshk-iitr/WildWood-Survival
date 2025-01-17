extends Node2D

var state = "apples"
var player_in_area = false
var player = null
var appl = preload("res://scene/apple_collectable.tscn")
@export var item: InvItem

func _ready():
	if state == "no-apples":
		$growth_time.start()

func _process(_delta):
	if state == "no-apples":
		$AnimatedSprite2D.play("no-apples")
	
	elif state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			state = "no-apples"
			drop_apple()

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func _on_growth_time_timeout():
	state = "apples"

func drop_apple():
	var apple_inst = appl.instantiate()
	apple_inst.global_position = $Marker2D.global_position
	get_parent().add_child(apple_inst)
	player.collect(item)
	await get_tree().create_timer(1).timeout
	$growth_time.start()
