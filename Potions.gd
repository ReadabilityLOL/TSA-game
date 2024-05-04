class_name Potion
var type : String
var stat_change : int
var duration : int

func _init(_type : String, _stat_change : int, _duration : int):
    type = _type
    stat_change = _stat_change
    duration = _duration

extends Area2D

signal loot_dropped(item_name)

var loot_table : Array = ["Health Potion", "Mana Potion", "Strength Potion", "Poison Potion", "Fire Potion"]

func _ready():
    connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
    if body.name == "Player":
        var item_name = loot_table[randi() % loot_table.size()]
        emit_signal("loot_dropped", item_name)

# In the player character script, connect the chest's loot_dropped signal to the inventory's add_item method
func _ready():
    var chest = get_node("/root/Chest") # Adjust the path to your Chest node
    chest.connect("loot_dropped", get_node("/root/Inventory"), "add_item")

# In the inventory script, connect the item_used signal to a method that handles item usage
func _ready():
    connect("item_used", self, "_on_item_used")

func _on_item_used(item_name):
    if item_name == "Health Potion":
        # Implement health potion effect
        print("Health potion used.")
    elif item_name == "Mana Potion":
        # Implement mana potion effect
        print("Mana potion used.")
    elif item_name == "Strength Potion":
        # Implement strength potion effect
        print("Strength potion used.")
    elif item_name == "Poison Potion":
        # Implement poison potion effect
        print("Poison potion used.")
    elif item_name == "Fire Potion":
        # Implement fire potion effect
        print("Fire potion used.")
    elif item_name == "Ice Potion":
        # Implement ice potion effect
        print("Ice potion used.")
    elif item_name == "Lightning Potion":
        # Implement lightning potion effect
        print("Lightning potion used.")
