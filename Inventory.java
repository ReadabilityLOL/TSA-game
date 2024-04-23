public class Inventory {
    private ArrayList<Item> items;
    private static final int MAX_ITEMS = 10; // Maximum number of items in the inventory

    public Inventory() {
        this.items = new ArrayList<>();
    }

    public void addItem(Item item) {
        if (items.size() < MAX_ITEMS) {
            items.add(item);
        } else {
            System.out.println("Inventory is full.");
        }
    }

    public void removeItem(Item item) {
        items.remove(item);
    }

    public boolean containsItem(Item item) {
        return items.contains(item);
    }

    public boolean isFull() {
        return items.size() >= MAX_ITEMS;
    }

    public ArrayList<Item> getItems() {
        return items;
    }
}
