package DAO;

import Model.Project;
import java.sql.*;
import java.util.*;
import DBConnection.DatabaseConnection;
import java.io.IOException;

public class ProjectDAO {

    private Connection conn;

    public ProjectDAO() throws SQLException, ClassNotFoundException {
        conn = DatabaseConnection.getConnection();
    }

    public int addProject(Project p) throws SQLException, ClassNotFoundException {
        PreparedStatement ps = conn.prepareStatement("insert into project(ProjectName,Employer_Email,Budget,Skills,Description)"
                + "values(?,?,?,?,?)");
        ps.setString(1, p.getName());
        ps.setString(2, p.getEmployerEmail());
        ps.setDouble(3, p.getBudget());
        ps.setString(4, p.getRequiredSkills());
        ps.setString(5, p.getDesc());
        ps.executeUpdate();

        Project project = getProjectByName(p.getName());
        return project.getId();
    }

    public Project getProjectByName(String name) throws SQLException {
        Project p = new Project();
        PreparedStatement ps = conn.prepareStatement("select * from project where ProjectName = ?");
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            p.setAdminEmail(rs.getString("Admin_Email"));
            p.setBudget(rs.getDouble("Budget"));
            p.setDesc(rs.getString("Description"));
            p.setEmployerEmail(rs.getString("Employer_Email"));
            p.setFreelancerEmail(rs.getString("Freelancer_Email"));
            p.setId(rs.getInt("ProjectID"));
            p.setName(rs.getString("ProjectName"));
            p.setRequiredSkills(rs.getString("Skills"));
            p.setStatus(rs.getString("Status"));
        }
        return p;
    }

    public List<Project> getProjectsByEmployerEmail(String email) throws SQLException {
        List<Project> projects = new ArrayList<Project>();
        PreparedStatement ps = conn.prepareStatement("select * from project where Employer_Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Project p = new Project();
            p.setAdminEmail(rs.getString("Admin_Email"));
            p.setBudget(rs.getDouble("Budget"));
            p.setDesc(rs.getString("Description"));
            p.setEmployerEmail(rs.getString("Employer_Email"));
            p.setFreelancerEmail(rs.getString("Freelancer_Email"));
            p.setId(rs.getInt("ProjectID"));
            p.setName(rs.getString("ProjectName"));
            p.setRequiredSkills(rs.getString("Skills"));
            p.setStatus(rs.getString("Status"));
            projects.add(p);
        }
        return projects;
    }

    public List<Project> getProjectsByFreelancerEmail(String email) throws SQLException {
        List<Project> projects = new ArrayList<Project>();
        PreparedStatement ps = conn.prepareStatement("select * from project where Freelancer_Email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Project p = new Project();
            p.setAdminEmail(rs.getString("Admin_Email"));
            p.setBudget(rs.getDouble("Budget"));
            p.setDesc(rs.getString("Description"));
            p.setEmployerEmail(rs.getString("Employer_Email"));
            p.setFreelancerEmail(rs.getString("Freelancer_Email"));
            p.setId(rs.getInt("ProjectID"));
            p.setName(rs.getString("ProjectName"));
            p.setRequiredSkills(rs.getString("Skills"));
            p.setStatus(rs.getString("Status"));
            projects.add(p);
        }
        return projects;
    }

    public List<Project> getProjectsByStatus(String status) throws SQLException {
        List<Project> projects = new ArrayList<Project>();
        PreparedStatement ps = conn.prepareStatement("select * from project WHERE Status = ?");
        ps.setString(1, status);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Project p = new Project();
            p.setAdminEmail(rs.getString("Admin_Email"));
            p.setBudget(rs.getDouble("Budget"));
            p.setDesc(rs.getString("Description"));
            p.setEmployerEmail(rs.getString("Employer_Email"));
            p.setFreelancerEmail(rs.getString("Freelancer_Email"));
            p.setId(rs.getInt("ProjectID"));
            p.setName(rs.getString("ProjectName"));
            p.setRequiredSkills(rs.getString("Skills"));
            p.setStatus(rs.getString("Status"));
            projects.add(p);
        }
        return projects;
    }

    public Project getProjectsById(int id) throws SQLException {
        Project p = new Project();
        PreparedStatement ps = conn.prepareStatement("select * from project WHERE ProjectID = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            p.setAdminEmail(rs.getString("Admin_Email"));
            p.setBudget(rs.getDouble("Budget"));
            p.setDesc(rs.getString("Description"));
            p.setEmployerEmail(rs.getString("Employer_Email"));
            p.setFreelancerEmail(rs.getString("Freelancer_Email"));
            p.setId(rs.getInt("ProjectID"));
            p.setName(rs.getString("ProjectName"));
            p.setRequiredSkills(rs.getString("Skills"));
            p.setStatus(rs.getString("Status"));
        }
        return p;
    }

    public void updateProject(Project p) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("update project set ProjectName=?,Status=?,Budget=?,Skills=?,Description=?,Admin_Email=?,Freelancer_Email=? where ProjectID = ?");
        ps.setString(1, p.getName());
        ps.setString(2, p.getStatus());
        ps.setDouble(3, p.getBudget());
        ps.setString(4, p.getRequiredSkills());
        ps.setString(5, p.getDesc());
        ps.setString(6, p.getAdminEmail());
        ps.setString(7, p.getFreelancerEmail());
        ps.setInt(8, p.getId());
        ps.executeUpdate();
    }

    public void deleteProject(Project p) throws SQLException {
        PreparedStatement ps = conn.prepareStatement("delete from project where ProjectID=?");
        ps.setInt(1, p.getId());
        ps.executeUpdate();
    }

    public List<Project> getProjectsBySkills(String skills) throws SQLException, IOException {
        List<Project> projects = new ArrayList<Project>();
        PreparedStatement ps = conn.prepareStatement("select * from project where Skills like'" + skills + "%'and Status ='approved'");
        ResultSet rs = ps.executeQuery();
        if (!rs.isBeforeFirst()) {

        } else {
            while (rs.next()) {
                Project p = new Project();
                p.setAdminEmail(rs.getString("Admin_Email"));
                p.setBudget(rs.getDouble("Budget"));
                p.setDesc(rs.getString("Description"));
                p.setEmployerEmail(rs.getString("Employer_Email"));
                p.setFreelancerEmail(rs.getString("Freelancer_Email"));
                p.setId(rs.getInt("ProjectID"));
                p.setName(rs.getString("ProjectName"));
                p.setRequiredSkills(rs.getString("Skills"));
                p.setStatus(rs.getString("Status"));
                projects.add(p);
            }
        }
        return projects;
    }

    public List<String> getProjectSkills() throws SQLException {
        List<String> skills = new ArrayList<String>();
        PreparedStatement ps = conn.prepareStatement("SELECT Skills FROM project");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String skill = rs.getString("Skills");
            skills.add(skill);
        }
        return skills;
    }

    public List<Project> get3LatestProjectsByFreelancerEmail(String email) throws SQLException {
        List<Project> projects = new ArrayList<Project>();
        PreparedStatement ps = conn.prepareStatement("select * from project where Freelancer_Email = ? order by ProjectID desc limit 3");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Project p = new Project();
            p.setAdminEmail(rs.getString("Admin_Email"));
            p.setBudget(rs.getDouble("Budget"));
            p.setDesc(rs.getString("Description"));
            p.setEmployerEmail(rs.getString("Employer_Email"));
            p.setFreelancerEmail(rs.getString("Freelancer_Email"));
            p.setId(rs.getInt("ProjectID"));
            p.setName(rs.getString("ProjectName"));
            p.setRequiredSkills(rs.getString("Skills"));
            p.setStatus(rs.getString("Status"));
            projects.add(p);
        }
        return projects;
    }

}
