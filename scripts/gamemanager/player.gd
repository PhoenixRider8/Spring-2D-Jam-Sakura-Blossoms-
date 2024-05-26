extends CharacterBody2D

var isFront : bool = true
const speed = 300.0

func _ready():
	$Camera2D/PlayerCanvas/Collected.visible = true
	$Camera2D/PlayerCanvas/PauseMenu.visible = false

func _physics_process(delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	handle_anim(direction)
	handle_labels()
	
	move_and_slide()
	
func handle_anim(direction):
	#right direction
	if direction == Vector2(1,0): 
		%player_sprite.play("walkRight")
		%player_sprite.flip_h = false
		isFront = false
		
	#left direction
	elif direction == Vector2(-1,0):
		%player_sprite.play("walkRight")
		%player_sprite.flip_h = true
		isFront = false
		
	#down direction
	elif direction == Vector2(0,1):
		%player_sprite.play("walkFront")
		%player_sprite.flip_h = false
		isFront = true

	#up direction
	elif direction == Vector2(0,-1):
		%player_sprite.play("walkBack")
		%player_sprite.flip_h = true
		isFront = false
		
	#idle animation
	else:
		if isFront:
			%player_sprite.play("idleFront")
		else:
			%player_sprite.play("idleBack")
		
func handle_labels():
	$"Camera2D/PlayerCanvas/Collected/1_ OkamaPetals/Label2".text = str(Global.numPetalsOkame)
	$"Camera2D/PlayerCanvas/Collected/2_ WeepingPetals/Label2".text = str(Global.numPetalsWeeping)
	$"Camera2D/PlayerCanvas/Collected/3_ Wood/Label2".text = str(Global.numWood)
	$"Camera2D/PlayerCanvas/Collected/4_ Coin/Label2".text = str(Global.numCoins)

func _player():
	pass

#buttons
func _on_texture_button_pressed():
	$Camera2D/PlayerCanvas/Collected.visible = false
	$Camera2D/PlayerCanvas/PauseMenu.visible = true
	get_tree().paused = true

func _on_return_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu/main_manu.tscn")
	

func _on_quit_pressed():
	get_tree().quit()

func _on_continue_pressed():
	get_tree().paused = false
	$Camera2D/PlayerCanvas/Collected.visible = true
	$Camera2D/PlayerCanvas/PauseMenu.visible = false
