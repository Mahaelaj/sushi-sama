extends Node

var data = { 'high_score': 0, 'music_on': true, 'sound_effects_on': true, 'tutorial_finished': false };

func _init():
	var saveData = load_game();
	if (saveData): data = saveData;

func save_game():
    var save_game = File.new()
    save_game.open("res://data/data.save", File.WRITE)
    save_game.store_line(to_json(data))
    save_game.close();
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("res://data/data.save"):
		return # Error! We don't have a save to load.
		
	save_game.open("res://data/data.save", File.READ)
	
	var saveData = {};
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if (current_line):
			for i in range(current_line.keys().size()):
				saveData[current_line.keys()[i]] = current_line[current_line.keys()[i]]
	save_game.close()
	return saveData;
	
func getData(key):
	if (!data.has(key)): return false;
	return data[key];

func saveData(newData):
	for i in range(newData.keys().size()):
		data[newData.keys()[i]] = newData[newData.keys()[i]]
	save_game()
	