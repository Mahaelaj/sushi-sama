extends Node2D

var colorCount = 0;

func startGrow():
	$PowerUpPurple.start()
	$GrowTimer.start();

func _on_GrowTimer_timeout():
	if (colorCount == 0): $PowerUpBlue.start()
	elif (colorCount == 1): $PowerUpGreen.start();
	elif (colorCount == 2): 
		$PowerUpYellow.start();
		colorCount = 0;
		return;
	colorCount += 1 
	$GrowTimer.start()
	pass # replace with function body
