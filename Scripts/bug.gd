extends CharacterBody2D

@export var move_speed: int = 400
@export var health: int = 20

var noticing_player: bool = false
var attacking_player: bool = false
var can_walk: bool = true
var can_attack: bool = true

var target


func _process(_delta):
	if noticing_player and can_walk:
		$AnimatedSprite2D.play("walk")
		look_at(Globals.player_position)
		var move_dir = (Globals.player_position - global_position).normalized()
		velocity = move_dir * move_speed
		move_and_slide()
	
	if attacking_player:
		if can_attack:
			can_walk = false
			$AnimatedSprite2D.play("attack")
			can_attack = false
			print("Attacking Player")
			$AttackCooldown.start()


func hit(type: String):
	$Particles/HitParticles.restart()
	if type == "laser":
		health -= 10
	elif type == "grenade":
		health -= 30
		
	if health <= 0:
		can_walk = false
		can_attack = false
		await get_tree().create_timer(0.2).timeout
		queue_free()


func _on_notice_area_2d_body_entered(_body):
	noticing_player = true


func _on_notice_area_2d_body_exited(_body):
	noticing_player = false
	$AnimatedSprite2D.stop()

func _on_attack_area_2d_2_body_entered(body):
	attacking_player = true
	target = body


func _on_attack_area_2d_2_body_exited(_body):
	attacking_player = false
	can_walk = true
	$AnimatedSprite2D.stop()


func _on_attack_cooldown_timeout():
	can_attack = true
	can_walk = true


func _on_animated_sprite_2d_animation_finished():
	if "hit" in target and attacking_player:
		target.hit("laser")
