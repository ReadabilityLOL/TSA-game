
import java.util.Random;

public class Entity extends GameObject{
    private int id;
    private String name;
    private int health;
    private int strength;
    private int defense;
    private static final Random random = new Random();

    public Entity(int id, String name, float x, float y, float mass, float friction) {
        super(name, x, y, mass, friction);
        this.id = id;
        this.name = name;
        this.health = random.nextInt(50) + 50;
        this.strength = random.nextInt(20) + 10;
        this.defense = random.nextInt(10) + 5;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getHealth() {
        return health;
    }

    public void setHealth(int health) {
        this.health = health;
    }

    public int getStrength() {
        return strength;
    }

    public void setStrength(int strength) {
        this.strength = strength;
    }

    public int getDefense() {
        return defense;
    }

    public void setDefense(int defense) {
        this.defense = defense;
    }

    public boolean isAlive() {
        return health > 0;
    }

    public void takeDamage(int damage) {
        if (damage > defense) {
            health -= (damage - defense);
        }
    }

    public void heal(int healAmount) {
        health += healAmount;
    }

    public void attack(Entity target) {
        int damage = strength - target.getDefense();
        if (damage > 0) {
            target.takeDamage(damage);
        }
    }

    // Added a method to generate a random name for the entity
    public static String generateRandomName() {
        String[] prefixes = { "Dragon", "Goblin", "Elf", "Ogre", "Wizard" };
        String[] suffixes = { "Fire", "Ice", "Storm", "Shadow", "Light" };
        return prefixes[random.nextInt(prefixes.length)] + " of " + suffixes[random.nextInt(suffixes.length)];
    }
}
