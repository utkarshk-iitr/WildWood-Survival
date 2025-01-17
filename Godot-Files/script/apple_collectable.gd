extends StaticBody2D

func _ready() -> void:
	fall()

func fall():
	$AnimationPlayer.play("animationtree")
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("fade")
	await  get_tree().create_timer(0.3).timeout
	queue_free()
