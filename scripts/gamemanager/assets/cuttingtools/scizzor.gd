extends StaticBody2D

var is_cutting = false

func _ready():
	$scizzorSprite.play("idle")

func _physics_process(delta):
	if is_cutting:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		
func _input(event):
	if event is InputEventMouseButton:
		#checks if left click is no longer pressed
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed: 
			is_cutting = false

func _on_scizzor_cut_area_entered(area:Area2D):
	if area.name == "Zone" and area.get_parent().plant_growth: #growing zone area2d node
		Global.is_scizzor_cutting = true
		$scizzorSprite.play("cut")

func _on_scizzor_cut_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"): #left click
		is_cutting = true
