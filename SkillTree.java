import java.util.ArrayList;
import java.util.List;

public class SkillTree {
    private List<Skill> skills;

    public SkillTree() {
        this.skills = new ArrayList<>();
    }

    public void addSkill(Skill skill) {
        skills.add(skill);
    }

    public List<Skill> getSkills() {
        return skills;
    }
}
