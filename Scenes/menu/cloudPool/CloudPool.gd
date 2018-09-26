extends Node2D

var clouds = [];

func _ready():
	clouds = [ $Cloud1, $Cloud2, $Cloud3, $Cloud4, $Cloud5, $Cloud6 ]
	initCloud();
	pass
	
func initCloud():
	var index = randi() % clouds.size();
	var cloud = clouds[index];
	cloud.start();
	clouds.remove(index);
	pass;

func _on_Cloud_removeItem(item):
	clouds.append(item);
	pass # replace with function body
