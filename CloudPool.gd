extends Node2D

var cloudSets = [];
var speed = 20;

func _ready():
	cloudSets = [ $CloudSet1, $CloudSet2, $CloudSet3, $CloudSet4 ];
	var cloudSet = initCloudSet();
	cloudSet.position = Vector2(0, 0);
	pass
	
func initCloudSet():
	var index = randi() % cloudSets.size();
	var cloudSet = cloudSets[index];
	cloudSet.start(speed);
	cloudSets.remove(index);
	return cloudSet;

func _on_cloudHitWall():
	initCloudSet();
	pass # replace with function body

func _on_CloudSet_removeItem(item):
	cloudSets.append(item);
	pass # replace with function body
