extends Node

signal stat_changed


var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_changed.emit()


var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_changed.emit()


var health = 100: 
	set(value):
		health = min(value, 100)
		stat_changed.emit()


var player_position: Vector2


func custom_timer():
	# Creating timer in code instead of a node in the tree
	# We're not using this. It's just for future reference
	await get_tree().create_timer(0.5).timeout
