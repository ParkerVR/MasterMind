extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var revealAnswer : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if g.GameState == g.GameStateOption.WIN || g.GameState == g.GameStateOption.LOSE:
		revealAnswer = true
		
	else: 
		revealAnswer = false
		
	if revealAnswer:
		$AnswerKey1.color = g.CodeColorToColor[g.theCode[0]]
		$AnswerKey2.color = g.CodeColorToColor[g.theCode[1]]
		$AnswerKey3.color = g.CodeColorToColor[g.theCode[2]]
		$AnswerKey4.color = g.CodeColorToColor[g.theCode[3]]
	else:
		$AnswerKey1.color = g.ColorEmpty
		$AnswerKey2.color = g.ColorEmpty
		$AnswerKey3.color = g.ColorEmpty
		$AnswerKey4.color = g.ColorEmpty
