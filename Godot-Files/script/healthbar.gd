extends ProgressBar
@onready var timer = $Timer
@onready var dmg_bar = $Damagebar

var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value,new_health)
	value = health
		
	if health<prev_health:
		timer.start()
	else:
		dmg_bar.value = health

func init_health(_health):
	health = _health
	value = health
	max_value = 150
	dmg_bar.max_value = 150
	dmg_bar.value = health

func _on_timer_timeout():
	dmg_bar.value = health
