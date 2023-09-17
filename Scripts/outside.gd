extends LevelParent



func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "move_speed", 0, 0.3)
	get_tree().change_scene_to_file("res://Scenes/Levels/inside.tscn")
