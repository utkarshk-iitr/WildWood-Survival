extends CharacterBody2D

var speed = 100
var player_state

@export var inv: Inv = preload("res://inventory/playerinv.tres")
var bow_equiped = false
var bow_cooldown = true
var sword_equiped = false
var sword_cooldown = true
var arrow = preload("res://scene/arrow.tscn")
var sword = preload("res://scene/sword.tscn")
var mlfp
var health = 150
var armour = 150
	
func _physics_process(_delta):
	var direction = Input.get_vector("left","right","up","down")	
	if direction.x==0 and direction.y==0: player_state = "idle"
	elif direction.x!=0 or direction.y!=0: player_state = "walking"

	mlfp = get_global_mouse_position() - self.position
	velocity = direction*speed
	move_and_slide()
	
	if position.x>520 and position.y<=150:
		$Camera2D.limit_left = 520
		$Camera2D.limit_bottom = 149
		$Camera2D.limit_right = 1240
		
	if Input.is_action_just_pressed("right_mouse") and check("Bow"):
		bow_equiped = !bow_equiped
		if sword_equiped: sword_equiped = false
	if Input.is_action_just_pressed("space") and check("Sword"):
		sword_equiped = !sword_equiped
		if bow_equiped: bow_equiped = false
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_inst = arrow.instantiate()
		arrow_inst.rotation = $Marker2D.rotation
		arrow_inst.global_position = $Marker2D.global_position
		$audio/bow.play()
		add_child(arrow_inst)
		
		var theta = atan(mlfp.y/mlfp.x)
		if mlfp.y<0 and abs(theta)>=1.125: $AnimatedSprite2D.play("n-attack")
		elif mlfp.x<0 and abs(theta)<=0.375: $AnimatedSprite2D.play("w-attack")
		elif mlfp.x>0 and abs(theta)<=0.375: $AnimatedSprite2D.play("e-attack")
		elif mlfp.y>0 and abs(theta)>=1.125: $AnimatedSprite2D.play("s-attack")
		elif mlfp.y<0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("ne-attack")
		elif mlfp.y>0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("se-attack")
		elif mlfp.y>0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("sw-attack")
		elif mlfp.y<0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("nw-attack")
		
		if !check("Thunder"): await get_tree().create_timer(0.5).timeout
		else: await get_tree().create_timer(0.2).timeout
		bow_cooldown = true

	if Input.is_action_just_pressed("left_mouse") and sword_equiped and sword_cooldown:
		sword_cooldown = false
		var sword_inst = sword.instantiate()
		sword_inst.rotation = $Marker2D.rotation
		sword_inst.global_position = $Marker2D.global_position
		add_child(sword_inst)
		$audio/sword.play()
		
		var theta = atan(mlfp.y/mlfp.x)
		if mlfp.y<0 and abs(theta)>=1.125: $AnimatedSprite2D.play("n-sword-attack")
		elif mlfp.x<0 and abs(theta)<=0.375: $AnimatedSprite2D.play("w-sword-attack")
		elif mlfp.x>0 and abs(theta)<=0.375: $AnimatedSprite2D.play("e-sword-attack")
		elif mlfp.y>0 and abs(theta)>=1.125: $AnimatedSprite2D.play("s-sword-attack")
		elif mlfp.y<0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("ne-sword-attack")
		elif mlfp.y>0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("se-sword-attack")
		elif mlfp.y>0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("sw-sword-attack")
		elif mlfp.y<0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("nw-sword-attack")
		
		await get_tree().create_timer(0.5).timeout
		sword_cooldown = true
		remove_child(sword_inst)
	
	if Input.is_action_just_pressed("e"):
		food_taken()
	if Input.is_action_just_pressed("j"):
		jewel_taken()
		
	play_anim(direction)

func play_anim(dir):
	var theta = atan(mlfp.y/mlfp.x)
	if bow_equiped and !Input.is_action_just_pressed("left_mouse"):
		speed = 35
		if mlfp.y<0 and abs(theta)>=1.125: $AnimatedSprite2D.play("n-bow")
		elif mlfp.x<0 and abs(theta)<=0.375: $AnimatedSprite2D.play("w-bow")
		elif mlfp.x>0 and abs(theta)<=0.375: $AnimatedSprite2D.play("e-bow")
		elif mlfp.y>0 and abs(theta)>=1.125: $AnimatedSprite2D.play("s-bow")
		elif mlfp.y<0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("ne-bow")
		elif mlfp.y>0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("se-bow")
		elif mlfp.y>0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("sw-bow")
		elif mlfp.y<0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("nw-bow")
	
	elif sword_equiped and !Input.is_action_just_pressed("left_mouse"):
		speed = 70
		if mlfp.y<0 and abs(theta)>=1.125: $AnimatedSprite2D.play("n-sword")
		elif mlfp.x<0 and abs(theta)<=0.375: $AnimatedSprite2D.play("w-sword")
		elif mlfp.x>0 and abs(theta)<=0.375: $AnimatedSprite2D.play("e-sword")
		elif mlfp.y>0 and abs(theta)>=1.125: $AnimatedSprite2D.play("s-sword")
		elif mlfp.y<0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("ne-sword")
		elif mlfp.y>0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("se-sword")
		elif mlfp.y>0 and theta<=-0.375 and theta>=-1.125: $AnimatedSprite2D.play("sw-sword")
		elif mlfp.y<0 and theta>=0.375 and theta<=1.125: $AnimatedSprite2D.play("nw-sword")		
		
	else:
		speed = 100
		if player_state == "idle": $AnimatedSprite2D.play("idle")
		elif player_state == "walking":
			if dir.x == 1: $AnimatedSprite2D.play("e-walk")
			elif dir.y == 1: $AnimatedSprite2D.play("s-walk")
			elif dir.x == -1: $AnimatedSprite2D.play("w-walk")
			elif dir.y == -1: $AnimatedSprite2D.play("n-walk")
			elif dir.x>0.5 and dir.y>0.5: $AnimatedSprite2D.play("se-walk")
			elif dir.x>0.5 and dir.y<-0.5: $AnimatedSprite2D.play("ne-walk")
			elif dir.x<-0.5 and dir.y>0.5: $AnimatedSprite2D.play("sw-walk")
			elif dir.x<-0.5 and dir.y<-0.5: $AnimatedSprite2D.play("nw-walk")
		
func collect(item):
	$audio/collect.play()
	inv.insert(item)

func player():
	pass

func check(it):
	for i in inv.slots: if i.item != null and i.item.name == it: return true
	return false

func food_taken():
	for i in inv.slots:
		if i.item!=null and i.item.name=="Chicken" and i.amount>0:
			$audio/food.play()
			i.amount -= 2
			inv.insert(i.item)
			inca(50)
			return
		elif i.item!=null and i.item.name=="Apple" and i.amount>0:
			$audio/food.play()
			i.amount -= 2
			inv.insert(i.item)
			inca(25)
			return

func jewel_taken():
	for i in inv.slots:
		if i.item!=null and i.item.name=="BlueGem" and i.amount>0:
			$audio/health.play()
			i.amount -= 2
			inv.insert(i.item)
			inch(50)
			return
		elif i.item!=null and i.item.name=="Coin" and i.amount>0:
			$audio/health.play()
			i.amount -= 2
			inv.insert(i.item)
			inch(25)
			return

func inch(v):
	health += v
	health = min(150,health)
func inca(v):
	armour += v
	armour = min(150,armour)
func deca(v):
	armour -= v
	armour = max(armour,0)
func dech(v):
	health -= v
	$AnimatedSprite2D.play("hurt")
	$audio/hurt.play()
	health = max(health,0)
