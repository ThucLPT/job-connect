package Model;

public class Freelancer {

    private String freelancerEmail;
    private String skill;

    public Freelancer() {
    }

    public Freelancer(String freelancerEmail, String skill) {
        this.freelancerEmail = freelancerEmail;
        this.skill = skill;

    }

    public String getFreelancerEmail() {
        return freelancerEmail;
    }

    public void setFreelancerEmail(String freelancerEmail) {
        this.freelancerEmail = freelancerEmail;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

}
