extends Node2D

var mouths = [];
var speed = 100;

func _ready():
	mouths = [ $Mouth1, $Mouth2, $Mouth3 ];
	pass

func initMouthItem(sushi_scale):
	if (!mouths.size()): return;
	var index = randi()%mouths.size();
	var mouthItem = mouths[index];
	mouthItem.scale = sushi_scale;
	mouthItem.start(speed);
	mouths.remove(index);
	pass

func _on_Mouth_removeItem(item):
	mouths.append(item);
	item.makeMouthTopLayerBottom();
	item.scale = Vector2(1, 1);
	pass # replace with function body
