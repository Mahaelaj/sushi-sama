extends Node2D

func start():
	$Tween.interpolate_property($rice1, "position", Vector2(0, -15), Vector2(-250, -125), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice2, "position", Vector2(0, 0), Vector2(-250, -75), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice3, "position", Vector2(0, -10), Vector2(-250, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice4, "position", Vector2(0, 10), Vector2(-250, 50), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice5, "position", Vector2(0, -35), Vector2(-250, 150), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	$Tween.interpolate_property($rice1, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice2, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice3, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice4, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($rice5, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start();
	pass
