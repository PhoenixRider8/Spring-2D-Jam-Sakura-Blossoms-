extends StaticBody2D

func _ready():
	$ShopMenu.visible = false
	
func _process(delta):
	#handle buy
	if $ShopMenu.waterSprayOwned == true: #water
		$Items/buy/WaterSpray.visible = true
		
	if $ShopMenu.landOwned == true: #land
		$Items/buy/land.visible = true
		

#handle collision with player
func _on_area_2d_body_entered(body):
	if body.has_method("_player"):
		$ShopMenu.visible = true

func _on_area_2d_body_exited(body):
	if body.has_method("_player"):
		$ShopMenu.visible = false
