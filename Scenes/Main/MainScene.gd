extends Node2D

var points = 0;
var displayPoints = 0;
var time = 0;
var gameOver = false;

func _ready():
	if (playerData.musicOn): $AmbienceAudioStream2d.play(playerData.ambientNoisePos)
	get_tree().paused = true
	$NewItemTimer.start();
	$StartCard.play('default');
	if (!playerData.tutorialFinished): $Tutorial.start()
	pass

func _process(delta):
	time += delta;
	points += delta;
	if (int(points) > displayPoints):
		displayPoints = int(points);
		$ScoreLabel.text = str(displayPoints);

func _on_Sushi_gameOver(hit_floor):
	if (playerData.soundEffectsOn):
		if (hit_floor): $HitFloorAudioStreamPlayer2D.play(0);
		else: $HitKnifeAudioStreamPlayer2D.play(0)
	
	$White.modulate.a = .75;
	$GameOverMenuTimer.start()
	get_tree().paused = true
	gameOver = true;
	
	pass # replace with function body

func _on_NewItemTimer_timeout():
	var number = randi() % 100;
	if (number < 20): 
		$FoodPool.initFoodItem();
	elif (number < 95):
		$KnifePool.initKnifeItem();
	else:
		$MouthPool.initMouthItem($Sushi.scale / $Sushi.startScale);
	pass 

func _on_LeftWall_body_entered(body):
	if (body.is_in_group('food') || body.is_in_group('knives') || body.is_in_group('mouths')): body.remove();
		
	if (body.is_in_group('clouds')): body.onCloudHitWall();
	pass # replace with function body

func _on_Sushi_addPoints(p, is_food):
	points += p;
	$ScoreLabel.text = str(points);
	
	if(playerData.soundEffectsOn):
		if (is_food): $EatFoodAudioStreamPlayer2D.play(0);
		else: $MouthAudioStreamPlayer2D.play(0);
	pass # replace with function body

func _on_LeftWall_body_exited(body):
	if (body.is_in_group('clouds')): body.remove();
	pass # replace with function body

func _on_Button_button_up():
	if (gameOver || $Tutorial.isTutorialPlaying): return;
	if (get_tree().paused): 
		get_tree().paused = false
		$StartCard.stop()
		$StartCard.visible = false;
	$Sushi.bounce();
	if (playerData.soundEffectsOn): $SushiBounceAudioStreamPlayer2D.play(0);
	pass # replace with function body

func _on_GameOverMenuTimer_timeout():
	$GameOver.setPoints(displayPoints);
	$GameOver.visible = true;
	pass # replace with function body

func _on_GameOver_loadMainScene():
	playerData.ambientNoisePos = $AmbienceAudioStream2d.get_playback_position()
	get_tree().change_scene("res://Scenes/Main/MainScene.tscn")
	pass # replace with function body

func _on_GameOver_loadMenuScene():
	get_tree().paused = false 
	get_tree().change_scene("res://Scenes/menu/StartScene.tscn")
	pass # replace with function body