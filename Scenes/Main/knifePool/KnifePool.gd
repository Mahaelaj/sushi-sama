extends Node2D

var knives = [];
var speed = 100;

func _ready():
	knives = [ $KnifeSet1, $KnifeSet2, $KnifeSet3, $KnifeSet4, $KnifeLarge1, $KnifeLarge2, $KnifeLarge3, $KnifeLarge4 ];
	pass
	# $KnifeLarge1, $KnifeLarge2, $KnifeLarge3, $KnifeLarge4
#  $KnifeSet1, $KnifeSet2, $KnifeSet3, $KnifeSet4
func initKnifeItem():
	if (!knives.size()): return;
	var index = randi() % knives.size();
	var knifeItem = knives[index];
	knifeItem.start(speed);
	knives.remove(index);
	pass

func _on_Knife_removeItem(knife):
	knives.append(knife);
	knife.position.x = 850
	pass # replace with function body

