This folder contains items related to inventory system of the game.

game_stats.tres = Resource file containing score and highscore
playerinv.tres = It contains 12 inventory slots , storing player's current holdings
inv_slot.tscn = Godot scene containing display of one slot
inv_ui.tscn = This scene contains 12 slots displaying full inventory
inventory_item.gd = This script contains class InvItem for a single item
inventory.gd = Godot script having class Inv for the full inventory , it also has a function to insert items to inventory
inv_ui.gd = This script deals this opening , closing and update in inventory
inv_slot.gd = This update the data in each slot of inventory
inv_cnt_slot.gd = This script has a class called InvSlot , it includes InvItem and its count
