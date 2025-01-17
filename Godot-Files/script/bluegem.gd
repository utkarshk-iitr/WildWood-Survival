extends Node2D

var state = "item"
var player_in_area = false
var player = null
@export var item: InvItem

func _ready():
	if state == "no-item":
		state = "item" 

func _process(_delta):
	if state == "no-item":
		$AnimatedSprite2D.play("empty")
		queue_free()
	elif state == "item":
		$AnimatedSprite2D.play("bluegem")
		if player_in_area:
			state = "no-item"
			player.collect(item)

func _on_pickable_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body 

func _on_pickable_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
