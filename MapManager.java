import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.function.Consumer;

public class MapManager {
    private Map<String, Map> maps;
    private Map currentMap;
    private Consumer<MapEvent> mapEventConsumer;

    public MapManager() {
        maps = new HashMap<>();
    }

    public CompletableFuture<Boolean> loadMapAsync(String mapName, Map map) {
        return CompletableFuture.supplyAsync(() -> {
            if (validateMap(map)) {
                maps.put(mapName, map);
                System.out.println("Map loaded successfully: " + mapName);
                notifyMapEvent(new MapEvent(MapEventType.LOADED, mapName));
                return true;
            } else {
                System.out.println("Map validation failed: " + mapName);
                notifyMapEvent(new MapEvent(MapEventType.VALIDATION_FAILED, mapName));
                return false;
            }
        });
    }

    public CompletableFuture<Boolean> switchMapAsync(String mapName) {
        return CompletableFuture.supplyAsync(() -> {
            if (maps.containsKey(mapName)) {
                currentMap = maps.get(mapName);
                notifyMapEvent(new MapEvent(MapEventType.SWITCHED, mapName));
                return true;
            } else {
                System.out.println("Map not found: " + mapName);
                notifyMapEvent(new MapEvent(MapEventType.NOT_FOUND, mapName));
                return false;
            }
        });
    }

    public Map getCurrentMap() {
        return currentMap;
    }

    public void removeMap(String mapName) {
        maps.remove(mapName);
    }

    public void addMap(String mapName, Map map) {
        maps.put(mapName, map);
    }

    public void setMapEventConsumer(Consumer<MapEvent> consumer) {
        this.mapEventConsumer = consumer;
    }

    private boolean validateMap(Map map) {
        // map validation logic here
        return true;
    }

    private void notifyMapEvent(MapEvent event) {
        if (mapEventConsumer != null) {
            mapEventConsumer.accept(event);
        }
    }

    public static class MapEvent {
        public enum MapEventType {
            LOADED, VALIDATION_FAILED, SWITCHED, NOT_FOUND
        }

        private MapEventType type;
        private String mapName;

        public MapEvent(MapEventType type, String mapName) {
            this.type = type;
            this.mapName = mapName;
        }

        public MapEventType getType() {
            return type;
        }

        public String getMapName() {
            return mapName;
        }
    }
}
