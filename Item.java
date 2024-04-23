public class Item {
    private String name;
    private String description;
    private ItemType type;
    private int effectValue;

    public Item(String name, String description, ItemType type, int effectValue) {
        this.name = name;
        this.description = description;
        this.type = type;
        this.effectValue = effectValue;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public ItemType getType() {
        return type;
    }

    public int getEffectValue() {
        return effectValue;
    }
}
