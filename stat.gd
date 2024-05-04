extends Node

# Player stats
var health = 100
var mana = 50
var stamina = 100
var xp = 0
var level = 1

# Signals
signal health_changed(new_health)
signal mana_changed(new_mana)
signal stamina_changed(new_stamina)
signal xp_changed(new_xp)
signal level_changed(new_level)

func _ready():
    # Connect signals to update UI
    connect("health_changed", self, "_on_health_changed")
    connect("mana_changed", self, "_on_mana_changed")
    connect("stamina_changed", self, "_on_stamina_changed")
    connect("xp_changed", self, "_on_xp_changed")
    connect("level_changed", self, "_on_level_changed")

func take_damage(damage):
    health -= damage
    if health < 0:
        health = 0
    emit_signal("health_changed", health)

func use_mana(amount):
    mana -= amount
    if mana < 0:
        mana = 0
    emit_signal("mana_changed", mana)

func use_stamina(amount):
    stamina -= amount
    if stamina < 0:
        stamina = 0
    emit_signal("stamina_changed", stamina)

func gain_xp(amount):
    xp += amount
    if xp >= xp_to_next_level():
        level_up()
    emit_signal("xp_changed", xp)

func level_up():
    level += 1
    xp -= xp_to_next_level()
    emit_signal("level_changed", level)

func xp_to_next_level():
    return 100 * level # Example: XP needed to level up is 100 times the current level

func _on_health_changed(new_health):
    $UI/HealthLabel.text = "Health: " + str(new_health)

func _on_mana_changed(new_mana):
    $UI/ManaLabel.text = "Mana: " + str(new_mana)

func _on_stamina_changed(new_stamina):
    $UI/StaminaLabel.text = "Stamina: " + str(new_stamina)

func _on_xp_changed(new_xp):
    $UI/XPLabel.text = "XP: " + str(new_xp)

func _on_level_changed(new_level):
    $UI/LevelLabel.text = "Level: " + str(new_level)

func reset_stats():
    health = 100
    mana = 50
    stamina = 100
    xp = 0
    level = 1
    emit_signal("health_changed", health)
    emit_signal("mana_changed", mana)
    emit_signal("stamina_changed", stamina)
    emit_signal("xp_changed", xp)
    emit_signal("level_changed", level)
