extends StaticBody2D

#planting
var plant = Global.plantselected
var plantgrowing = false
var plant_growth = false

var plant_health = 10

#cutting
var is_axe_cut = Global.is_axe_cutting
var is_scizzor_cut = Global.is_scizzor_cutting

func _physics_process(delta):
	#print(Global.plantselected)
	#to have last selected seedbag be selected
	if plantgrowing == false: #whem there is no plant growing in the growing zone
		plant = Global.plantselected 
	#update lumbering bool variables
	is_axe_cut = Global.is_axe_cutting
	is_scizzor_cut = Global.is_scizzor_cutting

func _on_area_2d_area_entered(area:Area2D):
	#check if area is seedpack
	if area.name == "Okame" or area.name == "Weeping":
		if not plantgrowing :
			if Global.is_water_spraying:
				$okame_timer.wait_time = 5
				$weeping_timer.wait_time = 5
				Global.is_water_spraying = false
			if plant == 1: #1-> okame cherry blossom
				plantgrowing = true
				$okame_timer.start()
				$plant.play("okame_growth")
			if plant == 2: #2-> weeping cherry blossom
				plantgrowing = true
				$weeping_timer.start()
				$plant.play("weeping_growth")
		else:
			print("palnt is already growing here") #plant already growing in that growing zone
			
	#check if area is cutting tool
	#check for axe cutting (lumbering)


func _on_okame_timer_timeout():
	var okame_plant = $plant
	if okame_plant.frame == 0 or okame_plant.frame == 1 or okame_plant.frame == 2: #during seedling
		okame_plant.frame+= 1 #increment by 1 frame
		$okame_timer.start()
	elif okame_plant.frame == 3:
		okame_plant.frame = 4 #final frame when the tree grows complete
		plant_growth = true #plant growth complete
		


func _on_weeping_timer_timeout():
	var weeping_plant = $plant
	if weeping_plant.frame == 0 or weeping_plant.frame == 1 or weeping_plant.frame == 2 : #during seedling
		weeping_plant.frame+= 1 #increment by 1 frame
		$weeping_timer.start()
	elif weeping_plant.frame == 3:
		weeping_plant.frame = 4 #final frame when the tree grows complete
		plant_growth = true #plant growth complete

#when mouse hovers over this area2d node
func _on_zone_mouse_entered():
	if is_axe_cut:
		if plant_growth:
			if plant == 1: #okame
				plantHealth()
			if plant == 2: #weeping
				plantHealth()
	
	if is_scizzor_cut:
		if plant_growth:
			if plant == 1: #okame
				petalsHealth(plant)
			if plant == 2: #weeping
				petalsHealth(plant)

func plantHealth():
	is_scizzor_cut = false
	
	plant_health -=1
	Global.numWood +=1
	if plant_health == 0:
		plantgrowing = false
		plant_growth = false
		is_axe_cut = false
		plant_health = 10
		$plant.play("none")
		#print(Global.numWood)
		
func petalsHealth(plant):
	is_axe_cut = false
	
	if plant == 1:
		Global.numPetalsOkame +=1
		#print(Global.numPetalsOkame)
	elif plant == 2:
		Global.numPetalsWeeping +=1
		#print(Global.numPetalsWeeping)
	else:
		is_scizzor_cut = false
