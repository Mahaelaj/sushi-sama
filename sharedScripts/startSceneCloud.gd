extends KinematicBody2D

export var moving = false;
var motion = Vector2(0, -200);
const UP = Vector2(0, -1);
signal removeItem(item)
export var yPos = 0;


func start():
	moving = true
	position = Vector2((randi() % 700) - 100, yPos);

func _physics_process(delta):
	if (!moving): return;
	motion = move_and_slide(motion, UP);

func remove():
	emit_signal('removeItem', self);
	moving = false;