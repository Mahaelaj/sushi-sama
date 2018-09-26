extends Node2D

var food = [];
var speed = 100;

func _ready():
	food = [ $Ginger1, $Ginger2, $Wasabi1, $Wasabi2, $SoySauce1, $SoySauce2 ];
	pass

func initFoodItem():
	if (!food.size()): return;
	var index = randi() % food.size();
	var foodItem = food[index];
	foodItem.start(speed);
	food.remove(index);
	pass

func _on_remove_food_item(item):
	food.append(item);
	pass # replace with function body
