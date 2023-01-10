extends Control

func _on_New_Game_button_up():
	get_tree().change_scene("res://TSCN/Main.tscn")
	Global.score = 0
