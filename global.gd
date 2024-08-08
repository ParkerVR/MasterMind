extends Node

####

	# CODE/BUTTON COLOR MAPPING #
	
####

enum CodeColor {RED,ORANGE,YELLOW,GREEN,BLUE,VIOLET}
enum ButtonOption {RED,ORANGE,YELLOW,GREEN,BLUE,VIOLET,CLEAR}

const ButtonOptionToCodeColor = {
	ButtonOption.RED: CodeColor.RED,
	ButtonOption.ORANGE: CodeColor.ORANGE,
	ButtonOption.YELLOW: CodeColor.YELLOW,
	ButtonOption.GREEN: CodeColor.GREEN,
	ButtonOption.BLUE: CodeColor.BLUE,
	ButtonOption.VIOLET: CodeColor.VIOLET
}

const CodeColorToColor = {
	CodeColor.RED: Color.RED,
	CodeColor.ORANGE: Color.ORANGE,
	CodeColor.YELLOW: Color.YELLOW,
	CodeColor.GREEN: Color.GREEN,
	CodeColor.BLUE: Color.BLUE,
	CodeColor.VIOLET: Color.VIOLET
}


const ColorToCodeColorLookup = {
	Color.RED : CodeColor.RED,
	Color.ORANGE : CodeColor.ORANGE,
	Color.YELLOW : CodeColor.YELLOW,
	Color.GREEN : CodeColor.GREEN,
	Color.BLUE : CodeColor.BLUE,
	Color.VIOLET : CodeColor.VIOLET
}

const ColorEmpty = Color.WHITE


####

	# RESPONSE COLOR MAPPING #

####

enum ResponseOption {CORRECT_COLOR,CORRECT_COLOR_POSITION,BLANK}

const ResponseOptionColorPossibilites : Array[Color] = [Color.AQUA, Color.CORAL, Color.DARK_OLIVE_GREEN, Color.DARK_GOLDENROD, Color.WEB_PURPLE]

var ResponseOptionToColor = {
	ResponseOption.CORRECT_COLOR: Color.WHITE,
	ResponseOption.CORRECT_COLOR_POSITION: Color.WHITE,
	ResponseOption.BLANK: Color.WHITE
}

####

	# DYNAMIC GAMEPLAY ELEMENTS #

####

enum GameStateOption {START, GUESSING, RESPONSE, CLEAR, WIN, LOSE, RESTART}
var GameState: GameStateOption = GameStateOption.START

const theCodeLength = 4
const guessCountMax = 7
var guessCountCurrent = 0

var theCode: Array[CodeColor]
var theGuess : Array[CodeColor]

# Should statically be theCodeLength
const responseClear : Array[ResponseOption] = [
	ResponseOption.BLANK,
	ResponseOption.BLANK,
	ResponseOption.BLANK,
	ResponseOption.BLANK
]

# Should statically be theCodeLength
const responseWin: Array[ResponseOption] = [
	ResponseOption.CORRECT_COLOR_POSITION,
	ResponseOption.CORRECT_COLOR_POSITION,
	ResponseOption.CORRECT_COLOR_POSITION,
	ResponseOption.CORRECT_COLOR_POSITION
]

var responses : Array[ResponseOption] = responseClear.duplicate()


var responseLock: bool = false

func respond():
	responseLock = true
	guessCountCurrent += 1
	var scoredGuessPositions: Array[int] = []
	var scoredCodePositions: Array[int] = []
	
	responses = responseClear.duplicate()
	
	# Search for exactly Wright items
	for i in theGuess.size():
		if theGuess[i] == theCode[i]:
			responses[i] = ResponseOption.CORRECT_COLOR_POSITION
			scoredGuessPositions.append(i)
			scoredCodePositions.append(i)
			
	print("Scored Guess Positions: Exact")
	print(scoredGuessPositions)
	
	# Search for other color matches
	for i in theGuess.size():
		if i not in scoredGuessPositions:
			print("Evaluating Guess Pos: " + str(i))
			for j in theCode.size():
				if j not in scoredCodePositions:
					print("Evaluating Code Pos: " + str(j))
					if theGuess[i] == theCode[j]:
						print("Color Match!")
						responses[i] = ResponseOption.CORRECT_COLOR
						scoredGuessPositions.append(i)
						scoredCodePositions.append(j)
						break


						
	print("Scored Guess Positions: Any")
	print(scoredGuessPositions)
						
	# Do the shuffle... Time to Hustle
	for r in responses.size():
		print(ResponseOption.find_key(responses[r]))

	responses.shuffle()
	if responses.hash() == responseWin.hash():
		GameState = GameStateOption.WIN
	elif guessCountCurrent > guessCountMax:
		GameState = GameStateOption.LOSE
	else:
		GameState = GameStateOption.RESPONSE
		
	responseLock = false


func reset():
	g.ResponseOptionToColor[ResponseOption.CORRECT_COLOR] = ResponseOptionColorPossibilites.pick_random()
	g.ResponseOptionToColor[ResponseOption.CORRECT_COLOR_POSITION] = ResponseOptionColorPossibilites.pick_random()
	# Make sure hints are different colors
	while g.ResponseOptionToColor[ResponseOption.CORRECT_COLOR]  == g.ResponseOptionToColor[ResponseOption.CORRECT_COLOR_POSITION]:
			g.ResponseOptionToColor[ResponseOption.CORRECT_COLOR_POSITION] = ResponseOptionColorPossibilites.pick_random()
	
	g.theCode = []
	while (g.theCode.size() < g.theCodeLength): 
		g.theCode.append(g.CodeColor.values().pick_random())
	g.theGuess = []
	g.guessCountCurrent = 0
	
func _ready() -> void:
	reset()
	pass
