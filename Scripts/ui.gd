extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_label: Label = $GenadeCounter/VBoxContainer/Label
@onready var grenade_icon: TextureRect = $GenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

var green: Color = Color("6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)


func _ready():
	Globals.connect("stat_changed", update_stat_text)
	update_health_text()
	update_laser_text()
	update_grenade_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount) #casting the int as a string
	if Globals.laser_amount > 0:
		laser_label.modulate = green
		laser_icon.modulate = green
	else:
		laser_label.modulate = red
		laser_icon.modulate = red


func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	if Globals.grenade_amount > 0:
		grenade_label.modulate = green
		grenade_icon.modulate = green
	else:
		grenade_label.modulate = red
		grenade_icon.modulate = red


func update_health_text():
	health_bar.value = Globals.health
	
	
func update_stat_text():
	update_grenade_text()
	update_health_text()
	update_laser_text()
