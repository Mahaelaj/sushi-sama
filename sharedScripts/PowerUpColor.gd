extends Sprite

var time = 0;
enum states { isRising, isVisible, isFalling, isInvisible };
var state = states.isInvisible;

func start():
	state = states.isRising;

func _process(delta):
	if (state == states.isInvisible): return;
	time += delta * 4;
	if (time >= 1): time = 1;
	
	if (state == states.isRising): 
		modulate = Color(1, 1, 1, time)
		if (time >= 1):
			time = 0;
			state = states.isVisible;
	
	elif (state == states.isVisible):
		if (time >= 1):
			time = 0;
			state = states.isFalling;
	
	elif (state == states.isFalling):
		modulate = Color(1, 1, 1, 1 - time)
		if (time >= 1):
			time = 0;
			state = states.isInvisible;
		