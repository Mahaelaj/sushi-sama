extends KinematicBody2D

var motion = Vector2();
var startScale;
var curScale;
var armWaveSpeed = 0;

const UP = Vector2(0, -1);
const GRAVITY = 10;

signal addPoints(points, is_food);
signal gameOver(hit_floor);

func _ready():
	startScale = scale;
	curScale = scale;
	#$Arm.global_position = position;
	#for i in (range(0, 150)):
	#	$Arm.add_point(Vector2(-225 - i, -160));
	#pass
	
func _physics_process(delta):
	motion.y += GRAVITY;
	motion = move_and_slide(motion, UP);
	
	# falling down
	if (motion.y > 0 && rotation_degrees < 40):
		rotation_degrees += delta * 2 * (40 - rotation_degrees);
		
	# flying up
	if (motion.y < 0 && rotation_degrees > - 15):
		rotation_degrees -= delta * 2 * (rotation_degrees + 15);
		
func bounce():
	$ScaleTween.remove(self, "scale")
	$ScaleTween.interpolate_property(self, "scale", scale, Vector2(curScale.x, curScale.y *.8), .25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ScaleTween.start();
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
	curScale = curScale + (startScale * .05);
	
	# remove the food
	body.remove();

func eatSushi():
	emit_signal('addPoints', 10, false);
	$PowerDown.startShrink();
	curScale = startScale;
	
	pass # replace with function body

func _on_ScaleTween_tween_completed(object, key):
	$ScaleTween.interpolate_property(self, "scale", scale, curScale, .25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ScaleTween.start();
	pass # replace with function body
