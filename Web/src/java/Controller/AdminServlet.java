package Controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import DAO.*;
import Model.*;
import java.sql.*;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {

        String action = request.getParameter("action");

        HttpSession httpSession = request.getSession();
        Admin a = (Admin) httpSession.getAttribute("admin");

        if (action == null) {
            response.sendRedirect("error.jsp");
        } else if (action.equals("approve")) {
            Project p = (Project) httpSession.getAttribute("project");
            ProjectDAO pDAO = new ProjectDAO();
            p.setAdminEmail(a.getEmail());
            p.setStatus("approved");
            pDAO.updateProject(p);
            List<Project> projects = pDAO.getProjectsByStatus("pending");
            httpSession.setAttribute("projects", projects);
            httpSession.setAttribute("project", p);
            response.sendRedirect("PendingProjectList.jsp");
        } else if (action.equals("browse-pending")) {
            ProjectDAO pDAO = new ProjectDAO();
            List<Project> projects = pDAO.getProjectsByStatus("pending");
            httpSession.setAttribute("projects", projects);
            response.sendRedirect("PendingProjectList.jsp");
        } else if (action.equals("delete-project")) {
            Project p = (Project) httpSession.getAttribute("project");
            ProjectDAO pDAO = new ProjectDAO();
            pDAO.deleteProject(p);
            List<Project> projects = pDAO.getProjectsByStatus("pending");
            httpSession.setAttribute("projects", projects);
            response.sendRedirect("PendingProjectList.jsp");
        } else if (action.equals("edit-project")) {
            ProjectDAO pDAO = new ProjectDAO();
            Project p = (Project) httpSession.getAttribute("project");
            String name = request.getParameter("name");
            String desc = request.getParameter("desc");
            double budget = Double.valueOf(request.getParameter("budget"));
            String skills = request.getParameter("skills");
            p.setName(name);
            p.setBudget(budget);
            p.setRequiredSkills(skills);
            p.setDesc(desc);
            pDAO.updateProject(p);
            response.sendRedirect("");
        } else if (action.equals("browse-user")) {
            UserDAO uDAO = new UserDAO();
            String name = request.getParameter("name");
            List<User> users = uDAO.getUserByName(name);
            httpSession.setAttribute("users", users);
            response.sendRedirect("BrowseUserList.jsp");
        } else if (action.equals("delete-user")) {
            String email = request.getParameter("email");
            UserDAO uDAO = new UserDAO();
            User u = uDAO.getUserByEmail(email);
            String name = u.getName();
            uDAO.deleteUser(u);
            List<User> users = uDAO.getUserByName(name);
            httpSession.setAttribute("users", users);
            response.sendRedirect("BrowseUserList.jsp");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
