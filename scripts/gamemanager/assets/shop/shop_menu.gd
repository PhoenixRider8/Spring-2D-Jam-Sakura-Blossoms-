extends StaticBody2D

#check for buy or sell
var isbuy : bool = true
var buyPrices = [200,100]
var sellPrices = [10,10,30]
var itemPrice

#buy 1-> water spray & 2-> land (only 2 items)
var itemBuy = 1
var waterSprayOwned = false
var landOwned = false
var numBuyItems = 2 #2 items in buy section

#sell 1-> okama , 2-> white, 3-> wood
var itemSell = 1
var numSellItems = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShopItems/Buy_items.play("water")
	itemBuy = 1 #1-> water spray

func _physics_process(delta):
	if self.visible == true:
		#buy section
		if isbuy:
			handleBuyLabel()
			handleBuy()
			handleBuyButton()
		else:
			handleSellLabel()
			handleSell()
			handleSellButton()

#nav buttons setup
func _on_left_pressed():
	swap_items_back()


func _on_right_pressed():
	swap_items_foward()

#buy & sell setup
func _on_buy_pressed():
	isbuy = true


func _on_sell_pressed():
	isbuy = false

#swap items
func swap_items_foward():
	if itemBuy == numBuyItems:
		itemBuy = 1
	else:
		itemBuy +=1
	
	if itemSell == numSellItems:
		itemSell = 1
	else:
		itemSell +=1

func swap_items_back():
	if itemBuy == numBuyItems:
		itemBuy = 1
	else:
		itemBuy -=1
	
	if itemSell == numSellItems:
		itemSell = 1
	else:
		itemSell -=1

#handle animations
func handleBuy():
	if itemBuy == 1:
		$ShopItems/Buy_items.play("water")
		$Prices/buy/Label1.visible = true
		$Prices/buy/Label2.visible = false
		
	if itemBuy == 2:
		$ShopItems/Buy_items.play("land")
		$Prices/buy/Label1.visible = false
		$Prices/buy/Label2.visible = true
		
func handleSell():
	if itemSell == 1:
		$ShopItems/Sell_items.play("okame")
		$Prices/sell/Label1.visible = true
		$Prices/sell/Label2.visible = false
		
	if itemSell == 2:
		$ShopItems/Sell_items.play("white")
		$Prices/sell/Label1.visible = true
		$Prices/sell/Label2.visible = false
		
	if itemSell == 3:
		$ShopItems/Sell_items.play("wood")
		$Prices/sell/Label1.visible = false
		$Prices/sell/Label2.visible = true
		
func handleBuyLabel():
	$"Nav Buttons/Ok".text = "CONFIRM BUY"
	
	$ShopItems/Buy_items.visible = true
	$ShopItems/Sell_items.visible = false
	
	$Prices/buy/Label1.visible = true
	$Prices/buy/Label2.visible = false
	$Prices/sell/Label1.visible = false
	$Prices/sell/Label2.visible = false
	
func handleSellLabel():
	$"Nav Buttons/Ok".text = "CONFIRM SELL"
	
	$ShopItems/Buy_items.visible = false
	$ShopItems/Sell_items.visible = true
	
	$Prices/sell/Label1.visible = true
	$Prices/sell/Label2.visible = false
	$Prices/buy/Label1.visible = false
	$Prices/buy/Label2.visible = false
	
func handleBuyButton():
	#waterSpray
	if itemBuy == 1:
		if Global.numCoins >=buyPrices[0]:
			if waterSprayOwned == false:
					$"Nav Buttons/OkColor".color = "1daf1d" #green
			else:
					$"Nav Buttons/OkColor".color = "d42a46" #red
		else:
			$"Nav Buttons/OkColor".color = "d42a46" #red
	
	#land 
	if itemBuy == 2:
		if Global.numCoins >=buyPrices[1]: #if price is affortable
			if landOwned == false:
					$"Nav Buttons/OkColor".color = "1daf1d" #green
			else:
					$"Nav Buttons/OkColor".color = "d42a46" #red
		else:
			$"Nav Buttons/OkColor".color = "d42a46"
			
func handleSellButton():
	#okame
	if itemSell == 1:
		if Global.numPetalsOkame > 0:
			$"Nav Buttons/OkColor".color = "1daf1d" #green
		else:
			$"Nav Buttons/OkColor".color = "d42a46" #red
			
	#weeping 
	if itemSell == 2:
		if Global.numPetalsWeeping > 0:
			$"Nav Buttons/OkColor".color = "1daf1d" #green
		else:
			$"Nav Buttons/OkColor".color = "d42a46" #red
	
	#wood
	if itemSell == 3:
		if Global.numWood> 0:
			$"Nav Buttons/OkColor".color = "1daf1d" #green
		else:
			$"Nav Buttons/OkColor".color = "d42a46" #red

#confirm buy or sell
func _on_ok_pressed():
	if isbuy: #buy section
		itemPrice = buyPrices[itemBuy-1]
		
		#WaterSpray
		if itemBuy == 1:
			if Global.numCoins >=itemPrice: #if price is affortable
				if waterSprayOwned == false:
					buy()

		#Land
		if itemBuy == 2:
			if Global.numCoins >=itemPrice: #if price is affortable
				if landOwned == false:
					buy()
					
	else: #sell section
		itemPrice = sellPrices[itemSell-1]
		if itemSell == 1 and Global.numPetalsOkame>0:
			sell()
		if itemSell == 2 and Global.numPetalsWeeping>0:
			sell()
		if itemSell == 3 and Global.numWood>0:
			sell()

func buy():
	Global.numCoins -=itemPrice
	if itemBuy == 1: #water spray
		waterSprayOwned = true
	if itemBuy == 2:
		landOwned = true
		
func sell():
	Global.numCoins +=itemPrice 
	if itemSell == 1:
		Global.numPetalsOkame -= 1
	if itemSell == 2:
		Global.numPetalsWeeping -= 1
	if itemSell == 3:
		Global.numWood -=1
