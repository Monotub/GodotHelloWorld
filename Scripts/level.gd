extends Node2D

var laser_scene: PackedScene = preload("res://Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Projectiles/grenade.tscn")


func _on_gate_player_entered_gate():
	print("Player has entered gate!!!")


func _on_player_player_shooting(pos, dir):
	var laser = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	$Projectiles.add_child(laser)


func _on_player_player_grenading(pos, dir):
	var grenade = grenade_scene.instantiate() as RigidBody2D # Allows linear_velocity to autocomplete
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$Projectiles.add_child(grenade)


