extends CharacterBody2D

var move_speed: int = 400


func _process(_delta):
	velocity = Vector2.RIGHT * move_speed
	move_and_slide()
