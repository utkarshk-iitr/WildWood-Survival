extends Area2D

var speed = 400

func _ready() -> void:
	set_as_top_level(true)

func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation)*delta

func arrow_damage():
	pass
	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.has_method("player"): pass
	else: queue_free()
