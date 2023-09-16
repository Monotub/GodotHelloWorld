extends CharacterBody2D

var move_speed: int = 500
var can_shoot: bool = true
var can_grenade: bool = true

signal player_shooting(pos, dir)
signal player_grenading(pos, dir)


func _process(_delta):
	# Input
	var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = move_dir * move_speed
	move_and_slide()
	
	# Rotation
	look_at(get_global_mouse_position())
	
	
	var look_dir = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("Primary_Action") and can_shoot:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		can_shoot = false
		$ShootTimer.start()
		player_shooting.emit(selected_marker.global_position, look_dir)
		
	if Input.is_action_pressed("Secondary_Action") and can_grenade:
		var selected_marker = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$GrenadeTimer.start()
		player_grenading.emit(selected_marker, look_dir)


func _on_shoot_timer_timeout():
	can_shoot = true


func _on_grenade_timer_timeout():
	can_grenade = true
