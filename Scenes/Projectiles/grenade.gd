extends RigidBody2D

@export var blast_radius: int = 250

const speed = 750


func explode():
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("Explosion")
	deal_damage()


func deal_damage():
	var damagable_things = get_tree().get_nodes_in_group("Containers") + get_tree().get_nodes_in_group("Entities")
	
	for thing in damagable_things:
			if "hit" in thing and position.distance_to(thing.position) <= blast_radius:
				thing.hit("grenade")
