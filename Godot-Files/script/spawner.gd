extends Node2D

var snake = preload("res://scene/snake.tscn")
var scorp = preload("res://scene/scorpio.tscn")
var ghost = preload("res://scene/ghost.tscn")
var wolf = preload("res://scene/wolf.tscn")
var egypt = preload("res://scene/egypt.tscn")
var on = true
var player_in_area = false

func _process(_delta: float):
	if on and player_in_area:
		on = false
		$Timer.start()
		spawn()

func spawn():
	var snake_inst = snake.instantiate()
	var scorp_inst = scorp.instantiate()
	var ghost_inst = ghost.instantiate()
	var wolf_inst = wolf.instantiate()
	var egypt_inst = egypt.instantiate()
	
	snake_inst.global_position = Vector2(1017,25)
	scorp_inst.global_position = Vector2(617,26)
	ghost_inst.global_position = Vector2(1094,16)
	wolf_inst.global_position = Vector2(1098,-64)
	egypt_inst.global_position = Vector2(811,33)
	
	add_child(scorp_inst)
	await get_tree().create_timer(1).timeout
	add_child(snake_inst)
	await get_tree().create_timer(1).timeout
	add_child(wolf_inst)
	await get_tree().create_timer(1).timeout
	add_child(egypt_inst)
	await get_tree().create_timer(1).timeout
	add_child(ghost_inst)
	await get_tree().create_timer(1).timeout

func _on_timer_timeout():
	on = true

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
