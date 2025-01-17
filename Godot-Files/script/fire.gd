extends Node2D

var damage = true
var attackable = false
var player = null

func _process(_delta):
	if attackable and damage:
		player.dech(20)
		damage = false
		$Timer.start()
		
func _on_burning_body_entered(body):
	if body.has_method("player"):
		attackable = true
		player = body

func _on_burning_body_exited(body):
	if body.has_method("player"):
		attackable = false

func _on_timer_timeout():
	damage = true
