extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !g.responseLock:
		$Response1.color = g.ResponseOptionToColor[g.responses[0]]
		$Response2.color = g.ResponseOptionToColor[g.responses[1]]
		$Response3.color = g.ResponseOptionToColor[g.responses[2]]
		$Response4.color = g.ResponseOptionToColor[g.responses[3]]
