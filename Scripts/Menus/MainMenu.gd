extends Control

export var mainGame : PackedScene
export var creditScene : PackedScene 

func _on_New_Game_button_up():
	get_tree().change_scene(mainGame.resource_path)


func _on_Credit_button_up():
	get_tree().change_scene(creditScene.resource_path)
