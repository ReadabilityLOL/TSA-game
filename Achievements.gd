class_name Achievement
var id : int
var name : String
var description : String
var condition : FuncRef

func _init(_id : int, _name : String, _description : String, _condition : FuncRef):
    id = _id
    name = _name
    description = _description
    condition = _condition

extends Node

var achievements : Array = []

func _ready():
    add_achievement(Achievement.new(1, "First Kill", "Kill an enemy for the first time.", FuncRef(self, "check_first_kill")))
    add_achievement(Achievement.new(2, "Master of the Sword", "Use the sword 100 times.", FuncRef(self, "check_sword_usage")))
    add_achievement(Achievement.new(3, "Healer", "Heal yourself 50 times.", FuncRef(self, "check_healing")))

func add_achievement(achievement : Achievement):
    achievements.append(achievement)

func remove_achievement(achievement_id : int):
    for achievement in achievements:
        if achievement.id == achievement_id:
            achievements.erase(achievement)
            break

func check_first_kill():
    return StatKeeper.get_stat("enemies_killed") > 0

func check_sword_usage():
    return StatKeeper.get_stat("sword_usage") >= 100

func check_healing():
    return StatKeeper.get_stat("healing_count") >= 50

extends Node

signal stat_updated(stat_name, new_value)

var stats : Dictionary = {}

func add_stat(stat_name : String, initial_value : int):
    stats[stat_name] = initial_value

func update_stat(stat_name : String, value : int):
    if stats.has(stat_name):
        stats[stat_name] += value
        emit_signal("stat_updated", stat_name, stats[stat_name])

func get_stat(stat_name : String) -> int:
    return stats.get(stat_name, 0)

extends VBoxContainer

onready var stat_keeper = get_node("/root/StatKeeper") # Adjust the path to your StatKeeper node

func _ready():
    stat_keeper.connect("stat_updated", self, "_on_stat_updated")

func _on_stat_updated(stat_name, new_value):
    # Update UI elements based on the updated stat
    # This will depend on how you've set up your UI
