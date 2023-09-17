extends CharacterBody2D

var move_speed: int = 200
var is_enemy: bool = true


func _process(_delta):
	velocity = Vector2.RIGHT * move_speed
	move_and_slide()
	

func hit():
	print("Drone hit")
