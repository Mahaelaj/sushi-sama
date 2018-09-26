extends Node2D

var colorCount = 0;

func startShrink():
	$PowerDownPurple.start();
	$ShrinkTimer.start();

func _on_ShrinkTimer_timeout():
	if (colorCount == 0): $PowerDownBlue.start()
	elif (colorCount == 1): $PowerDownGreen.start();
	elif (colorCount == 2): 
		$PowerDownYellow.start();
		colorCount = 0;
		return;
	colorCount += 1 
	$ShrinkTimer.start()
	pass # replace with function body
