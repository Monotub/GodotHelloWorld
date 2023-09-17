extends StaticBody2D
class_name ItemParent


@onready var current_dir: Vector2 = Vector2.DOWN.rotated(rotation)

var opened: bool = false

signal open(pos, dir)
