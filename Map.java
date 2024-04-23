import java.util.concurrent.locks.ReentrantLock;

public class Map {
    private int[][][] tiles;
    private int width;
    private int height;
    private int depth;
    private ReentrantLock lock;

    public Map(int[][][] tiles) {
        this.tiles = tiles;
        this.width = tiles.length;
        this.height = tiles[0].length;
        this.depth = tiles[0][0].length;
        this.lock = new ReentrantLock();
    }

    public int[][][] getTiles() {
        return tiles;
    }

    public int getWidth() {
        return width;
    }

    public int getHeight() {
        return height;
    }

    public int getDepth() {
        return depth;
    }

    public int getTile(int x, int y, int z) {
        lock.lock();
        try {
            if (isWithinBounds(x, y, z)) {
                return tiles[x][y][z];
            }
            return -1;
        } finally {
            lock.unlock();
        }
    }

    public boolean isWalkable(int x, int y, int z) {
        lock.lock();
        try {
            if (isWithinBounds(x, y, z)) {
                return tiles[x][y][z] != 0;
            }
            return false;
        } finally {
            lock.unlock();
        }
    }

    public void setTile(int x, int y, int z, int value) {
        lock.lock();
        try {
            if (isWithinBounds(x, y, z)) {
                tiles[x][y][z] = value;
            }
        } finally {
            lock.unlock();
        }
    }

    private boolean isWithinBounds(int x, int y, int z) {
        return x >= 0 && x < width && y >= 0 && y < height && z >= 0 && z < depth;
    }

    public int[] findNearestWalkableTile(int x, int y, int z) {
        // add more complex stuff
        return new int[] { x, y, z };
    }

    public void updateMapState(int playerX, int playerY, int playerZ, int newTileValue) {
        lock.lock();
        try {
            setTile(playerX, playerY, playerZ, newTileValue);
        } finally {
            lock.unlock();
        }
    }

    public boolean movePlayer(int playerX, int playerY, int playerZ, int newX, int newY, int newZ) {
        lock.lock();
        try {
            if (isWithinBounds(newX, newY, newZ) && isWalkable(newX, newY, newZ)) {
                updateMapState(playerX, playerY, playerZ, 0);
                updateMapState(newX, newY, newZ, 1);// walkable tile
                return true;
            }
            return false;
        } finally {
            lock.unlock();
        }
    }

    public int[] findPath(int startX, int startY, int startZ, int endX, int endY, int endZ) {
        // add more
        return new int[] { endX, endY, endZ };
    }
}
