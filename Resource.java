public class Resource {
    private String name;
    private int quantity;
    private ResourceType type;

    public Resource(String name, int quantity, ResourceType type) {
        this.name = name;
        this.quantity = quantity;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public int getQuantity() {
        return quantity;
    }

    public ResourceType getType() {
        return type;
    }

    public void decreaseQuantity(int amount) {
        if (quantity - amount >= 0) {
            quantity -= amount;
        } else {
            quantity = 0;
        }
    }

    // Assuming ResourceType is an enum representing different types of resources
    public enum ResourceType {
        WOOD, STONE, FOOD, GOLD
    }
}
