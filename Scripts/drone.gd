extends CharacterBody2D

var move_speed: int = 0
var active: bool = false
var health: int = 50
var blast_radius: int = 250


func _ready():
	$Explosion.hide()
	$Sprite2D.show()
	

func _process(delta):
	
	if active: 
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * move_speed
		var tween = get_tree().create_tween()
		tween.tween_property(self, "move_speed", 900, 2)
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("Explosion")


func explody_damage():
	var targets = get_tree().get_nodes_in_group("Entities") + get_tree().get_nodes_in_group("Containers")
	for target in targets:
		if position.distance_to(target.position) < blast_radius:
			if target.is_in_group("Player"):
				target.hit("drone")
			else:
				target.hit("grenade")


func hit(type: String):
	if type == "laser":
		health -= 10
	elif type == "grenade":
		health -= 30
	
	if health <= 0:
		$CollisionShape2D.disabled = true
		active = false
		$AnimationPlayer.play("Explosion")


func _on_notice_area_body_entered(_body):
	active = true
