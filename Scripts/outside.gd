extends LevelParent



func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($Player, "move_speed", 0, 0.3)
	TransitionLayer.change_scene("res://Scenes/Levels/inside.tscn")


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_CUBIC) # "set_trans" changes transition from linear


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
