extends KinematicBody2D
var moving = false;
export var x = 900;
export var yMin = 0;
export var yMax = 0;
signal removeItem(item)

var motion = Vector2(0, 0);
const UP = Vector2(0, -1);

func _physics_process(delta):
	if (!moving): return;
	motion = move_and_slide(motion, UP);
	
func start(speed):
	moving = true;
	motion.x = -speed;
	pass
	
func remove():
	moving = false;
	if (yMax != 0 && yMin != 0 ): position = Vector2(x, (randi() + 1)%(yMax - yMin) + yMin);
	emit_signal("removeItem", self);