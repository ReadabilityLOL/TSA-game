public class Effect {
    private String name;
    private String description;

    public Effect(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public void applyEffect(Player player) {
        // Implement effect application logic here
        // For example, changing the player's health or triggering a specific game event
        System.out.println("Effect applied: " + name);
    }
}
