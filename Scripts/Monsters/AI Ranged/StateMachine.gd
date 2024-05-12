extends Node

var state = {
	"Idle": preload("res://Scripts/Monsters/AI Ranged/IdleState.gd"),
	"Run": preload("res://Scripts/Monsters/AI Ranged/RunState.gd"),
	"Attack": preload("res://Scripts/Monsters/AI Ranged/AttackState.gd"),
	"Death": preload("res://Scripts/Monsters/AI Ranged/DeathState.gd"),
}

func changeState(newState):
	if get_child_count() != 0:
		get_child(0).queue_free()
	if state.has(newState):
		var stateTemp = state[newState].new()
		stateTemp.name = newState
		add_child(stateTemp)
