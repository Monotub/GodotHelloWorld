extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://Scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/Projectiles/grenade.tscn")


func _ready():
	$UI.update_laser_text()
	$UI.update_grenade_text()

func _on_player_player_shooting(pos, dir):
	var laser = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	$Projectiles.add_child(laser)
	$UI.update_laser_text()


func _on_player_player_grenading(pos, dir):
	var grenade = grenade_scene.instantiate() as RigidBody2D # Allows linear_velocity to autocomplete
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # Ensures tweens run at the same time. Otherwise they're completed in order
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_CUBIC) # "set_trans" changes transition from linear
#	tween.tween_property($Player, "modulate:a", 0, 1).from(0.5) # "from()" sets a start value for the tween


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
#	tween.tween_property($Player, "modulate:a", 1, 1)
