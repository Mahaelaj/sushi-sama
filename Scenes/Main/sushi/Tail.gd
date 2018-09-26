extends Line2D

var point;
var target
export(NodePath) var targetPath;

func _ready():
	target = get_node(targetPath);
	
func _physics_process(delta):
	global_position = Vector2(0,0);
	global_rotation_degrees = 0;
#	print(target.global_position);
	#position = target.position;
	#position = target.global_position;
	position = -target.global_position;
	add_point(target.global_position);
	
	#Move points behind the sushi
	for i in range(0, get_point_count()):
		set_point_position(i, get_point_position(i) - Vector2(1, 0))
		
	if (get_point_count() > 400): remove_point(0);
