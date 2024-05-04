extends Control

onready var quest_manager = get_node("/root/QuestManager") # Adjust the path to your QuestManager node

func _ready():
    update_quest_ui()

func update_quest_ui():
    for child in get_children():
        if child is Button:
            var quest_id = int(child.name.split("_")[1]) # Assuming the button's name is "quest_button_<quest_id>"
            var quest = quest_manager.get_quest_by_id(quest_id)
            if quest:
                child.text = quest.name + " - " + quest.status
                child.connect("pressed", self, "_on_QuestButton_pressed", [quest_id])

func _on_QuestButton_pressed(quest_id):
    quest_manager.complete_quest(quest_id)
    update_quest_ui()

func _process(delta):
    if Input.is_action_just_pressed("ui_save"):
        quest_manager.save_quests()
    if Input.is_action_just_pressed("ui_load"):
        quest_manager.load_quests()
