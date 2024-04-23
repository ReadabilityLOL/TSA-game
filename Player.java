import java.util.ArrayList;
import java.util.List;

public class Player extends Entity {
    private String name;
    private int health;
    private int positionX;
    private int positionY;
    private int level;
    private int experience;
    private int gold;
    private List<Item> inventory;
    private List<Item> equipment;
    private List<Quest> quests;
    private SkillTree skillTree;

    public Player() {
        this.name = "Default Player";
        this.health = 100;
        this.positionX = 0;
        this.positionY = 0;
        this.level = 1;
        this.experience = 0;
        this.gold = 0;
        this.inventory = new ArrayList<>();
        this.equipment = new ArrayList<>();
        this.quests = new ArrayList<>();
        this.skillTree = new SkillTree();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void move(int newX, int newY) {
        this.positionX = newX;
        this.positionY = newY;
    }

    public void gainExperience(int experience) {
        this.experience += experience;
        checkForLevelUp();
    }

    public void gainGold(int gold) {
        this.gold += gold;
    }

    public void useItem(Item item) {
        if (inventory.contains(item)) {
            inventory.remove(item);
            applyItemEffect(item);
        }
    }

    // Helper methods
    private void checkForLevelUp() {
        int experienceNeeded = level * 100; // Example formula, adjust as needed
        if (this.experience >= experienceNeeded) {
            levelUp();
        }
    }

    private void levelUp() {
        level++;
        experience -= level * 100;
        System.out.println(name + " has leveled up to level " + level + "!");
    }

    private void applyItemEffect(Item item) {
        if (item.getType() == ItemType.HEALING_POTION) {
            heal(item.getEffectValue());
        }
    }

    private void heal(int amount) {
        health += amount;
        if (health > 100) {
            health = 100;
        }
        System.out.println(name + " has been healed for " + amount + " health points.");
    }

    public void attack(Player target) {
        System.out.println(name + " attacks " + target.getName() + "!");
    }

    public void trade(Player otherPlayer, Item item) {
        if (inventory.contains(item) && otherPlayer.getInventory().contains(item)) {
            inventory.remove(item);
            otherPlayer.getInventory().remove(item);
            System.out.println(name + " trades " + item.getName() + " with " + otherPlayer.getName() + ".");
        }
    }

    public void rest() {
        // Implement rest logic here, e.g., healing over time
        System.out.println(name + " rests and regains health.");
    }

    public void startQuest(Quest quest) {
        quests.add(quest);
        System.out.println(name + " starts the quest: " + quest.getName());
    }

    public void completeQuest(Quest quest) {
        if (quests.contains(quest)) {
            quests.remove(quest);
            System.out.println(name + " completes the quest: " + quest.getName());
            // reward the player with experience, gold, or items
        }
    }

    public void learnSkill(Skill skill) {
        skillTree.addSkill(skill);
        System.out.println(name + " learns the skill: " + skill.getName());
    }

    public void craftItem(Item item) {
        // crafting logic
        System.out.println(name + " crafts " + item.getName() + ".");
    }

    public void engageInCombat(Player enemy) {
        // combat logic
        System.out.println(name + " engages in combat with " + enemy.getName() + ".");
    }

    public void equipItem(Item item) {
        if (inventory.containsItem(item) && canEquip(item)) {
            inventory.removeItem(item);
            equipment.add(item);
            System.out.println(name + " equips " + item.getName() + ".");
        } else {
            System.out.println("Cannot equip " + item.getName() + ".");
        }
    }

    public void unequipItem(Item item) {
        if (equipment.contains(item)) {
            equipment.remove(item);
            inventory.addItem(item);
            System.out.println(name + " unequips " + item.getName() + ".");
        } else {
            System.out.println("Cannot unequip " + item.getName() + ".");
        }
    }

}
