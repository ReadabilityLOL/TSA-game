abstract class GameObject {
    protected String name;
    protected float x, y;
    protected float vx, vy;
    protected float mass;
    protected float friction;

    public GameObject(String name, float x, float y, float mass, float friction) {
        this.name = name;
        this.x = x;
        this.y = y;
        this.mass = mass;
        this.friction = friction;
    }

    public void updatePhysics() {
        x += vx;
        y += vy;
        vx *= (1 - friction);
        vy *= (1 - friction);
    }

    public boolean collidesWith(GameObject other) {
        float distance = (float) Math.sqrt(Math.pow(x - other.x, 2) + Math.pow(y - other.y, 2));
        return distance < 1.0f;
    }

    public String getName() {
        return name;
    }

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getVx() {
        return vx;
    }

    public float getVy() {
        return vy;
    }

    public float getMass() {
        return mass;
    }

    public void setVx(float vx) {
        this.vx = vx;
    }

    public void setVy(float vy) {
        this.vy = vy;
    }

    public void setMass(float mass) {
        this.mass = mass;
    }
}