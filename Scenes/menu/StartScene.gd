extends Node2D
var armWaveSpeed = 0;
var sushiMoveLeft = true;
onready var musicOffTexture = preload("res://Scenes/menu/music-button-off.png");
onready var musicOnTexture = preload("res://Scenes/menu/music-button.png");
onready var soundEffectsOnTexture = preload("res://Scenes/menu/sound-effects-button.png");
onready var soundEffectsOffTexture = preload("res://Scenes/menu/sound-effects-button-off.png");

func _ready():
	$CanvasLayer/YourHighScoreText.text = "Your High Score: " + String(playerData.highScore);
	$CanvasLayer/AllTimeHighScoreText.text = "All Time High Score: " + String(database.getData('high_score'));

	if (!playerData.musicOn): 
		$CanvasLayer/SettingsPanel/MusicButton.texture_normal = musicOffTexture
		$CanvasLayer/SettingsPanel/MusicTouchScreenButton.normal = musicOffTexture
	else: $AmbientAudioStreamPlayer2D.play()

	if (!playerData.soundEffectsOn): 
		$CanvasLayer/SettingsPanel/SoundEffectsButton.texture_normal = soundEffectsOffTexture
		$CanvasLayer/SettingsPanel/SoundEffectsTouchScreenButton.normal = soundEffectsOffTexture

	var sushi = $Sushi;
	var sushiLeftArm = $Sushi/ArmLeftLine2D;
	var sushiRightArm = $Sushi/ArmRightLine2D;
	var sushiTail = $Sushi/Tail;
	sushiLeftArm.global_position = sushi.position;
	sushiRightArm.global_position = sushi.position;
	sushiTail.global_position = sushi.position;

	for i in (range(0, 150)):
		sushiLeftArm.add_point(sushi.position + Vector2(-73 + (sin(i *.25) * 30), (-i) - 350));
		sushiRightArm.add_point(sushi.position + Vector2(73 + (sin(i *.25) * -30), (-i) - 350));
	pass

	for i in (range(0, 150)):
		sushiTail.add_point(Vector2(0, -150 + i));

	$SushiMoveTween.interpolate_property($Sushi, 'position', Vector2(115, 360), Vector2(335, 360), 3, $SushiMoveTween.TRANS_QUAD, $SushiMoveTween.EASE_IN_OUT);
	$SushiMoveTween.start()

func _process(delta):
	var sushiArmLeft = $Sushi/ArmLeftLine2D;
	var sushiArmRight = $Sushi/ArmRightLine2D;
	var handLeft = $Sushi/HandLeft;
	var handRight = $Sushi/HandRight;

	for i in (range(0, sushiArmLeft.get_point_count())):
		sushiArmLeft.set_point_position(i, Vector2(-73 + (sin((i + armWaveSpeed) * .125) * (i * .05)), sushiArmLeft.get_point_position(i).y));

	for i in (range(0, sushiArmRight.get_point_count())):
		sushiArmRight.set_point_position(i, Vector2(73 + (sin((i + armWaveSpeed) * -.125) * (i * .05)), sushiArmRight.get_point_position(i).y));

	var leftArmPosition = sushiArmLeft.get_point_position((sushiArmLeft.get_point_count() - 1));
	handLeft.position = leftArmPosition + Vector2((leftArmPosition.x + 80), -30);
	handLeft.rotation_degrees = (leftArmPosition.x + 73) * 2;

	var rightArmPosition = sushiArmRight.get_point_position((sushiArmRight.get_point_count() - 1));
	handRight.position = rightArmPosition +  Vector2((rightArmPosition.x - 80), -30);
	handRight.rotation_degrees = (rightArmPosition.x - 73) * 2;

	armWaveSpeed -= 1;

func _on_CloudSensor_body_exited(body):
	if (!body.is_in_group('cloud')): return;
	body.remove();
	pass # replace with function body

func _on_SushiMoveTween_tween_completed(object, key):
	if sushiMoveLeft: $SushiMoveTween.interpolate_property($Sushi, 'position', Vector2(335, 360), Vector2(115, 360), 3, $SushiMoveTween.TRANS_QUAD, $SushiMoveTween.EASE_IN_OUT);
	else: $SushiMoveTween.interpolate_property($Sushi, 'position', Vector2(115, 360), Vector2(335, 360), 3, $SushiMoveTween.TRANS_QUAD, $SushiMoveTween.EASE_IN_OUT);
	$SushiMoveTween.start()
	sushiMoveLeft = !sushiMoveLeft;
	pass # replace with function body

func _on_PlayButton_button_up():
	if (playerData.soundEffectsOn): 
		$StartGameButtonAudioStreamPlayer2D.play(0);
		$StartGameTimer.start()
	else: get_tree().change_scene("res://Scenes/Main/MainScene.tscn")
	pass # replace with function body

func _on_MusicButton_button_up():
	if (playerData.soundEffectsOn): $MenuButtonAudioStreamPlayer2D.play(0);
	playerData.musicOn = !playerData.musicOn;
	if (playerData.musicOn): 
		$CanvasLayer/SettingsPanel/MusicButton.texture_normal = musicOnTexture;
		$CanvasLayer/SettingsPanel/MusicTouchScreenButton.normal = musicOnTexture;
		$AmbientAudioStreamPlayer2D.play(0)
	else: 
		$CanvasLayer/SettingsPanel/MusicButton.texture_normal = musicOffTexture;
		$CanvasLayer/SettingsPanel/MusicTouchScreenButton.normal = musicOffTexture;
		$AmbientAudioStreamPlayer2D.stop()
	pass # replace with function body

func _on_SettingsButton_button_up():
	if (playerData.soundEffectsOn): $MenuButtonAudioStreamPlayer2D.play();
	$CanvasLayer/SettingsPanel.visible = true
	$Buttons.visible = false;
	pass # replace with function body

func _on_ExitButton_button_up():
	if (playerData.soundEffectsOn): $MenuButtonAudioStreamPlayer2D.play();
	$CanvasLayer/SettingsPanel.visible = false
	$Buttons.visible = true;
	pass # replace with function body

func _on_SoundEffectsButton_button_up():
	playerData.soundEffectsOn = !playerData.soundEffectsOn;
	if (playerData.soundEffectsOn): 
		$MenuButtonAudioStreamPlayer2D.play(0);
		$CanvasLayer/SettingsPanel/SoundEffectsButton.texture_normal = soundEffectsOnTexture;
		$CanvasLayer/SettingsPanel/SoundEffectsTouchScreenButton.normal = soundEffectsOnTexture;
	else: 
		$CanvasLayer/SettingsPanel/SoundEffectsButton.texture_normal = soundEffectsOffTexture;
		$CanvasLayer/SettingsPanel/SoundEffectsTouchScreenButton.normal = soundEffectsOffTexture;
	pass # replace with function body

func _on_StartGameTimer_timeout():
	get_tree().change_scene("res://Scenes/Main/MainScene.tscn")
	pass # replace with function body
