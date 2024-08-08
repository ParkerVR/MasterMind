extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Guess1.color = Color.WHITE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if g.theGuess.size() > 0:
		$Guess1.color = g.CodeColorToColor[g.theGuess[0]]
	else:
		$Guess1.color = g.ColorEmpty
	
	if g.theGuess.size() > 1:
		$Guess2.color = g.CodeColorToColor[g.theGuess[1]]
	else:
		$Guess2.color = g.ColorEmpty
		
	if g.theGuess.size() > 2:
		$Guess3.color = g.CodeColorToColor[g.theGuess[2]]
	else:
		$Guess3.color = g.ColorEmpty
		
	if g.theGuess.size() > 3:
		$Guess4.color = g.CodeColorToColor[g.theGuess[3]]
	else:
		$Guess4.color = g.ColorEmpty
	
