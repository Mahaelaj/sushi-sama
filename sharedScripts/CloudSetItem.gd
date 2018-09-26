extends "res://sharedScripts/item.gd"

func _ready():
	pass

func onCloudHitWall():
	emit_signal("removeItem", self);
