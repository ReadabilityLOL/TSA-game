public class Tile {
    private TileType type;
    private boolean isWalkable;
    private boolean isOccupied;
    private Player occupant;
    private Resource resource;
    private Effect effect;

    public Tile(TileType type, boolean isWalkable) {
        this.type = type;
        this.isWalkable = isWalkable;
        this.isOccupied = false;
    }

    public TileType getType() {
        return type;
    }

    public boolean isWalkable() {
        return isWalkable;
    }

    public boolean isOccupied() {
        return isOccupied;
    }

    public Player getOccupant() {
        return occupant;
    }

    public Resource getResource() {
        return resource;
    }

    public Effect getEffect() {
        return effect;
    }

    public void occupy(Player player) {
        if (!isOccupied) {
            isOccupied = true;
            occupant = player;
            triggerEvent("occupy");
        }
    }

    public void leave() {
        if (isOccupied) {
            isOccupied = false;
            occupant = null;
            triggerEvent("leave");
        }
    }

    public void setResource(Resource resource) {
        this.resource = resource;
    }

    public void setEffect(Effect effect) {
        this.effect = effect;
    }

    private void triggerEvent(String eventType) {
        // event handling logic here
        System.out.println("Event triggered: " + eventType);
    }

    // Assuming TileType is an enum representing different types of tiles
    public enum TileType {
        GRASS, FOREST, WATER, MOUNTAIN, CITY
    }
}
