extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var item_num: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		item_num.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_num.visible = true
		item_num.text = str(slot.amount)
