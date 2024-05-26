extends StaticBody2D

var is_plow = false
var GROWING_ZONE = preload("res://scenes/gamemanager/assets/growing_zone.tscn") #growing zone
var gamescene_GrowingZones

func _ready():
	$landSprite.play("idle")
	gamescene_GrowingZones = get_tree().current_scene.get_node("GrowingZones")
	

func _physics_process(delta):
	if is_plow:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		
	if Global.is_plowing == true:
		var zone = GROWING_ZONE.instantiate()
		zone.position.x = position.x
		zone.position.y = position.y
		gamescene_GrowingZones.add_child(zone)
		visible = false

func _input(event):
	if event is InputEventMouseButton:
		#checks if left click is no longer pressed
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed: 
			is_plow = false
			Global.is_plowing = false

func _on_plow_land_area_entered(area:Area2D):
	if area.name == "GrowingArea" and area.name !="Zone": #growing zone area2d node
		#Global.is_plowing = true
		pass


func _on_plow_land_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"): #left click
		is_plow = true
