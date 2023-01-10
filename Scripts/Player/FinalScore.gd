extends Label


func _process(delta):
	self.text = str("Final Score: " + str(Global.score))
