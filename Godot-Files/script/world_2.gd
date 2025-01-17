extends Node2D

@onready var anim = $world2cutscene/AnimationPlayer
var isopening = false
var player_enetered = false
var player = null 

func _ready():
	$world2main/CanvasLayer/time/Panel.visible = false
	$world2main.visible = false
	$world2main/coliision/entry.disabled = true
	$world2cutscene.visible = true

func _on_in_body_entered(body):
	if body.has_method("player"):
		body.position.x = 525
		$world2main/CanvasLayer/time/Panel.visible = true
		$world2main/coliision/entry.set_deferred("disabled",false)

func _on_player_enter_body_entered(body):
	if body.has_method("player"):
		player = body
		if !player_enetered:
			player_enetered = true
			cutscene()

func cutscene():
	isopening = true
	anim.play("fade")
	await get_tree().create_timer(1).timeout
	$world2main.visible = true
	$world2cutscene.visible = false
