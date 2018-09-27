extends Node2D

signal loadMainScene
signal loadMenuScene

func _ready():
	pass

func _on_PlayAgainButton_button_up(): 
	if (playerData.soundEffectsOn): 
		$PlayAgainAudioStreamPlayer2D.play(0);
		$LoadMainSceneTimer.start()
	else: emit_signal('loadMainScene')
	pass # replace with function body

func _on_MenuButton_button_up():
	if (playerData.soundEffectsOn):
		$MenuButtonAudioStreamPlayer2D.play(0)
		$LoadMenuSceneTimer.start()
	else: emit_signal('loadMenuScene')
	pass # replace with function body

func setPoints(points):
	if (points > playerData.highScore): $NewHighScore.visible = true;
	else: $NewHighScore.visible = false;
	
	if (points > database.getData('high_score')): database.saveData({ 'high_score': points });
	
	playerData.highScore = points;
	$Score.text = 'SCORE: ' + String(points);
	
func _on_LoadMainSceneTimer_timeout():
	emit_signal('loadMainScene')
	pass # replace with function body

func _on_LoadMenuSceneTimer_timeout():
	emit_signal('loadMenuScene')
	pass # replace with function body
