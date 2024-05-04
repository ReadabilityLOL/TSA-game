class_name Quest
var id : int
var name : String
var description : String
var objectives : Array
var rewards : Array
var status : String

func _init(_id : int, _name : String, _description : String, _objectives : Array, _rewards : Array, _status : String = "In Progress"):
    id = _id
    name = _name
    description = _description
    objectives = _objectives
    rewards = _rewards
    status = _status

extends Node

var quests : Array = []

func _ready():
    add_quest(Quest.new(1, "Find the Lost Artifact", "You must find the lost artifact in the ancient ruins.", ["Find the artifact"], ["100 gold"]))
    add_quest(Quest.new(2, "Defeat the Dragon", "You must defeat the dragon that has been terrorizing the village.", ["Defeat the dragon"], ["500 gold", "Dragon's Sword"]))
    add_quest(Quest.new(3, "Rescue the Princess", "You must rescue the princess from the tower.", ["Rescue the princess"], ["200 gold", "Princess's Gratitude"]))

func add_quest(quest : Quest):
    quests.append(quest)

func complete_quest(quest_id : int):
    for quest in quests:
        if quest.id == quest_id:
            quest.status = "Completed"
            for reward in quest.rewards:
                if reward == "100 gold":
                    pass
            quests.erase(quest)
            break

func get_quest_by_id(quest_id : int) -> Quest:
    for quest in quests:
        if quest.id == quest_id:
            return quest
    return null

func update_quest_status(quest_id : int):
    var quest = get_quest_by_id(quest_id)
    if quest:
        complete_quest(quest_id)

var save_path = "user://quests.save"

func save_quests():
    var save_data = []
    for quest in quests:
        save_data.append({
            "id": quest.id,
            "name": quest.name,
            "description": quest.description,
            "objectives": quest.objectives,
            "rewards": quest.rewards,
            "status": quest.status
        })
    ResourceSaver.save(save_path, save_data)

func load_quests():
    var load_data = ResourceLoader.load(save_path)
    if load_data:
        quests = load_data
