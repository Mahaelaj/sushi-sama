extends "res://sharedScripts/item.gd"

var sushi = null;

func _ready():
	pass

func _process(delta):
	if (sushi == null): return;
	position.y += (sushi.position.y - position.y) / 10

func makeMouthTopLayerBottom():
	$MouthTop.z_index = 0;

func _on_Area2D_body_entered(body):
	if (!body.is_in_group('sushi')): return;
	sushi = body;
	$MouthTop.z_index = 1;
	$Timer.start();
	pass # replace with function body

func _on_Timer_timeout():
	if (sushi == null): return;
	sushi.eatSushi();
	sushi = null;
	pass # replace with function body
