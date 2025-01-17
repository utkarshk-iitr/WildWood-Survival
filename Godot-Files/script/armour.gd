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
		$Sprite2D.visible = false
		queue_free()
	elif state == "item":
		$Sprite2D.visible = true
		if player_in_area:
			state = "no-item"
			player.collect(item)
			
func _on_pickable_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body 
		player.armour = 150

func _on_pickable_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
