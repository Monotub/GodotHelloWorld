extends CharacterBody2D

signal laser(pos, direction)

var player_nearby: bool = false
var can_laser: bool = true
var fire_left_gun:bool = true
var health: int = 30


func _process(_delta):
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var marker_pos = $LaserSpawnPositions.get_child(fire_left_gun)
			var pos: Vector2 = marker_pos.global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			fire_left_gun = !fire_left_gun
			can_laser = false
			$LaserCooldown.start()


func hit(type: String):
	if type == "laser":
		health -= 10
	elif type == "grenade":
		health -= 30
	
#	$Sprite2D.material.set_shader_parameter("progress", 0.7)
		
	if health <= 0:
		queue_free()
	
	
func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true
