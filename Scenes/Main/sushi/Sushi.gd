extends KinematicBody2D

var motion = Vector2();
var startScale;
var greenColor = Color(0.2, 1.0, 0.7, 0.8)
var changingToGreen = false;
var greenIndex = 0;

const UP = Vector2(0, -1);
const GRAVITY = 10;

signal addPoints(points, is_food);
signal gameOver(hit_floor);

func _ready():
	startScale = scale;
	pass

func _physics_process(delta):
	motion.y += GRAVITY;
	motion = move_and_slide(motion, UP);
	
	# falling down
	if (motion.y > 0 && rotation_degrees < 40):
		rotation_degrees += delta * 2 * (40 - rotation_degrees);
		
	# flying up
	if (motion.y < 0 && rotation_degrees > - 15):
		rotation_degrees -= delta * 2 * (rotation_degrees + 15);
		
func _process(delta):
	
	# the sushi color is changing to green after being eaten
	if (changingToGreen):
		if (greenIndex >= 1):
			changingToGreen = false; 
			return;
			
		$Sprite.set_modulate(Color(1,1,1,1).linear_interpolate(greenColor, greenIndex));
		greenIndex += delta * 1.5;
		
	# the sushi color is changing back to the normal color after being turned green from being eaten
	elif (!changingToGreen && greenIndex > 0):
		$Sprite.set_modulate(Color(1,1,1,1).linear_interpolate(greenColor, greenIndex));
		greenIndex -= delta * 1.5;
	
func bounce():
	motion.y = -250;

func _on_Area2D_area_entered(area):
	if (area.is_in_group('floor')): emit_signal('gameOver', true);
	pass # replace with function body

func _on_Area2D_body_entered(body):
	if (body.is_in_group('food')): 
		$PowerUp.startGrow()
		eatFood(body);
		emit_signal('addPoints', 5, true);
	if (body.is_in_group('knives')): 
		$RicePieces.start();
		emit_signal('gameOver', false);
	pass # replace with function body
	
func eatFood(body):
	
	# scale the sushi to be 5% bigger
	$ScaleTween.interpolate_property(self, "scale", scale, scale + (startScale * .05), .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ScaleTween.start();
	
	# remove the food
	body.remove();

func eatSushi():
	emit_signal('addPoints', 10, false);
	$PowerDown.startShrink();
	changingToGreen = true;
	
	if (scale < startScale): return;
	$ScaleTween.interpolate_property(self, "scale", scale, startScale, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ScaleTween.start();
	
	pass # replace with function body
