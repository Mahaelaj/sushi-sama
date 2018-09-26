extends Sprite

# We have a seperate script for the white sprite so the process function will be called when the game is paused
func _ready():
	pass

func _process(delta):
	if (modulate.a > 0): modulate.a -= delta * .75;
	if (modulate.a < 0): modulate.a = 0; 