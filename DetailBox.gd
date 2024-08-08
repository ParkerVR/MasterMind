extends TextEdit


func textTemplate():
	match g.GameState:
		g.GameStateOption.START:
			return "Are you a MasterMind?"
		g.GameStateOption.GUESSING:
			return "Think about your next move."
		g.GameStateOption.RESPONSE:
			return "Take a hint."
		g.GameStateOption.CLEAR:
			if g.guessCountCurrent == g.guessCountMax:
				return "LAST TRY!!"
			return "%s out of %s tries used. Can you beat it?" % [g.guessCountCurrent, g.guessCountMax]
		g.GameStateOption.WIN:
			return "Winner winner. %s tries." % [g.guessCountCurrent]
		g.GameStateOption.LOSE:
			return "U LOZE"
		g.GameStateOption.RESTART:
			return "Another game?"
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.text = textTemplate()
