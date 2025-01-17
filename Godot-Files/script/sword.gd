extends Area2D

func _ready() -> void:
	set_as_top_level(true)
	
func sword_damage():
	queue_free()
