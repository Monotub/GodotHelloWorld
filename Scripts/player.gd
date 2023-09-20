extends CharacterBody2D

@export var max_speed: int = 800

var move_speed: int = max_speed # 500 is default
var can_shoot: bool = true
var can_grenade: bool = true

signal player_shooting(pos, dir)
signal player_grenading(pos, dir)


func _process(_delta):
	Globals.player_position = global_position
	
	# Input
	var move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = move_dir * move_speed
	move_and_slide()
	
	# Rotation
	look_at(get_global_mouse_position())
	var look_dir = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("Primary_Action") and can_shoot and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		can_shoot = false
		$ShootTimer.start()
		$LaserParticles.restart()
		player_shooting.emit(selected_marker.global_position, look_dir)
		
	if Input.is_action_pressed("Secondary_Action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var selected_marker = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$GrenadeTimer.start()
		player_grenading.emit(selected_marker, look_dir)


func hit(type: String):
	if type == "laser":
		Globals.health -= 10
	elif type == "grenade":
		Globals.health -= 30
	elif type == "drone":
		Globals.health -= 50
	
	
func _on_shoot_timer_timeout():
	can_shoot = true


func _on_grenade_timer_timeout():
	can_grenade = true
