extends Node

#time is saved in milliseconds
func save_race_data(car_type: int, track: int, record: int, time: String):
	if !DirAccess.dir_exists_absolute("user://saved_racetimes/"+str(track)):
		DirAccess.make_dir_absolute("user://saved_racetimes/"+str(track))
	#save data will be stored at user://saved_racetimes/[track]/YYYY-MM-DD_[record]
	var file = FileAccess.open("user://saved_racetimes/" + str(track) + "/" + time + "_" + str(record), FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		push_error("Could not access file to save race time")
		return
	file.store_8(car_type)
	file.store_32(record)
	file.close()

func load_race_data(track: int) -> Dictionary:
	if !DirAccess.dir_exists_absolute("user://saved_racetimes/"+str(track)):
		print("No records found for directory")
		return {}
	var dir = DirAccess.open("user://saved_racetimes/"+str(track))
	if dir: #double check becuase i hate file access
		var return_dict : Dictionary = {}
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			#TODO: is this too intensive of an operation? should i just store data in the file names?
			var file = FileAccess.open("user://saved_racetimes/"+str(track)+"/" + filename, FileAccess.READ)
			if FileAccess.get_open_error() == OK:
				#get data stored inside file
				var car_type = file.get_8()
				var record = file.get_32()
				file.close()
				var date = filename.substr(0, 19) #TODO: check that this is correct
				return_dict[record] = [date, car_type]
		return return_dict
	return {}

func has_savedata() -> bool:
	if DirAccess.dir_exists_absolute("user://saved_racetimes"): return true
	return false

func clear_savedata():
	pass
