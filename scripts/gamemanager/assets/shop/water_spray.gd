extends StaticBody2D

var is_spraying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$waterSpraySprite.play("idle")

func _process(delta):
	if is_spraying:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)

func _input(event):
	if event is InputEventMouseButton:
		#checks if left click is no longer pressed
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed: 
			is_spraying = false


func _on_spray_water_area_entered(area):
		if area.name == "Zone" and not area.get_parent().plantgrowing: #growing zone area2d node
			Global.is_water_spraying = true
			$waterSpraySprite.play("spray")


func _on_spray_water_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"): #left click
		is_spraying = true
