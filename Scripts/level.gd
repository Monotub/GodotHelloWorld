extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://Scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/Projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://Scenes/Items/item.tscn")


func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)
		
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)


func _on_container_opened(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = dir
	$Items.call_deferred("add_child", item)
	

func _on_player_player_shooting(pos, dir):
	create_laser(pos, dir)


func _on_player_player_grenading(pos, dir):
	var grenade = grenade_scene.instantiate() as RigidBody2D # Allows linear_velocity to autocomplete
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$Projectiles.add_child(grenade)


func _on_scout_laser(pos, dir):
	create_laser(pos, dir)
	

func create_laser(pos, dir):
	var laser = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	$Projectiles.add_child(laser)
