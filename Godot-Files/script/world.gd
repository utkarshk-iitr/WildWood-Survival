extends Node2D

@onready var healthbar = $CanvasLayer/Healthbar
@onready var armourbar = $CanvasLayer/Armourbar
@onready var player = $player
var cooldown = true

func _ready():
	$CanvasLayer/PauseMenu.visible = false
	healthbar.init_health(player.health)
	armourbar.init_health(player.armour)

func _process(_delta: float):
	healthbar.health = player.health
	armourbar.health = player.armour
	if $player.position.x>=520 and $player.position.y<=150 and $CanvasModulate.visible:
		$CanvasModulate.visible = false
		$fall.play()
		
	if Input.is_action_just_pressed("pause") and get_tree().paused==false:
		$CanvasLayer/PauseMenu.visible = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused==true:
		$CanvasLayer/PauseMenu.visible = false
	
	if player.health<=0:
		get_tree().change_scene_to_file("res://scene/gameover.tscn")
		
	if cooldown:
		cooldown = false
		$CanvasLayer/Timer.start()

func _on_timer_timeout():
	cooldown = true
	if player.armour>0:
		$CanvasLayer/Timer.wait_time = 10
		player.deca(10)
		player.inch(10)
	else:
		$CanvasLayer/Timer.wait_time = 15
		player.dech(10)
