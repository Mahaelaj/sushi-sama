extends Node2D

var isTutorialPlaying = false;
var scaleMultiplier = 1.25
onready var initArrowTweenScale = $NextButtonArrow.scale;

func start():
	visible = true;
	isTutorialPlaying = true;
	$ArrowTween.interpolate_property($NextButtonArrow, 'scale', initArrowTweenScale, initArrowTweenScale * scaleMultiplier, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ArrowTween.interpolate_property($NextButtonArrow, 'scale', initArrowTweenScale * scaleMultiplier, initArrowTweenScale, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1)
	$ArrowTween.interpolate_property($NextButtonArrow, 'scale', initArrowTweenScale, initArrowTweenScale * scaleMultiplier, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2)
	$ArrowTween.interpolate_property($NextButtonArrow, 'scale', initArrowTweenScale * scaleMultiplier, initArrowTweenScale, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 3)
	$ArrowTween.start()

func _on_TextureButton_button_up():
	$AudioStreamPlayer2D.play(0)
	if ($TutorialCard1.visible):
		$TutorialCard1.visible = false;
	elif ($TutorialCard2.visible): 
		isTutorialPlaying = false;
		visible = false;
		$ArrowTween.stop_all()
		playerData.tutorialFinished = true;