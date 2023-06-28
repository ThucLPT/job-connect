package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import Model.*;
import DAO.*;
import java.sql.*;
import java.util.List;

@WebServlet(name = "EmployerServlet", urlPatterns = {"/EmployerServlet"})
public class EmployerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        String action = request.getParameter("action");

        HttpSession httpSession = request.getSession();
        Employer e = (Employer) httpSession.getAttribute("employer");
        EmployerDAO eDAO = new EmployerDAO();

        if (action == null) {
            response.sendRedirect("error.jsp");
        } else if (action.equals("post")) {

            ProjectDAO pDAO = new ProjectDAO();

            String name = request.getParameter("name");
            double budget = Double.valueOf(request.getParameter("budget"));
            String desc = request.getParameter("desc");
            String skill = request.getParameter("skill");
            String status = "pending";

            if (budget > e.getBalance()) {
                response.sendRedirect("ProjectForm.jsp?result=not-enough");
            } else {
                Project p = new Project();
                p.setName(name);
                p.setEmployerEmail(e.getEmail());
                p.setBudget(budget);
                p.setDesc(desc);
                p.setRequiredSkills(skill);
                p.setStatus(status);
                p.setId(pDAO.addProject(p));
                e = eDAO.addFund(e, -budget);
                httpSession.setAttribute("employer", e);
                response.sendRedirect("EmployerServlet?action=get-project");
            }
        } else if (action.equals("add-fund")) {
            double amount = Double.valueOf(request.getParameter("amount"));
            e = eDAO.addFund(e, amount);
            httpSession.setAttribute("employer", e);
            response.sendRedirect("profile.jsp");
        } else if (action.equals("review")) {
            Project p = (Project) httpSession.getAttribute("project");
            String review = request.getParameter("review");
            int rating = Integer.valueOf(request.getParameter("rating"));
            ContractDAO cDAO = new ContractDAO();
            Contract c = cDAO.getContractByProjectID(p.getId());
            c.setRating(rating);
            c.setReview(review);
            cDAO.updateContract(c);
            response.sendRedirect("ProjectDisplay.jsp");
        } else if (action.equals("get-project")) {
            ProjectDAO pDAO = new ProjectDAO();
            List<Project> projects = pDAO.getProjectsByEmployerEmail(e.getEmail());
            httpSession.setAttribute("projects", projects);
            response.sendRedirect("CurrentProjectList.jsp");
        } else if (action.equals("edit-project")) {
            ProjectDAO pDAO = new ProjectDAO();
            Project p = (Project) httpSession.getAttribute("project");
            String name = request.getParameter("name");
            String desc = request.getParameter("desc");
            double budget = Double.valueOf(request.getParameter("budget"));
            String skills = request.getParameter("skills");
            if (budget > e.getBalance()) {
                response.sendRedirect("ProjectForm.jsp?result=not-enough");
            } else {
                if (budget > p.getBudget()) {
                    e = eDAO.addFund(e, -(budget - p.getBudget()));
                } else {
                    e = eDAO.addFund(e, p.getBudget() - budget);
                }
                p.setName(name);
                p.setBudget(budget);
                p.setRequiredSkills(skills);
                p.setDesc(desc);
                pDAO.updateProject(p);
                httpSession.setAttribute("project", p);
                response.sendRedirect("ProjectDisplay.jsp");
            }
        } else if (action.equals("delete-project")) {
            ProjectDAO pDAO = new ProjectDAO();
            Project p = pDAO.getProjectsById(Integer.valueOf(request.getParameter("id")));
            e = eDAO.addFund(e, p.getBudget());
            pDAO.deleteProject(p);
            List<Project> projects = pDAO.getProjectsByEmployerEmail(e.getEmail());
            httpSession.setAttribute("projects", projects);
            response.sendRedirect("CurrentProjectList.jsp");
        } else if (action.equals("hire")) {
            String freelancerEmail = request.getParameter("freelancer-email");
            double amount = Double.valueOf(request.getParameter("amount"));
            Project p = (Project) httpSession.getAttribute("project");
            ProjectDAO pDAO = new ProjectDAO();
            Contract c = new Contract();
            ContractDAO cDAO = new ContractDAO();
            c.setEmployerEmail(e.getEmail());
            c.setProjectID(p.getId());
            c.setFreelancerEmail(freelancerEmail);
            c.setSalary(amount);
            cDAO.addContract(c);
            p.setStatus("working");
            p.setFreelancerEmail(freelancerEmail);
            pDAO.updateProject(p);
            httpSession.setAttribute("project", p);
            response.sendRedirect("ProjectDisplay.jsp");
        } else if (action.equals("close")) {
            Project p = (Project) httpSession.getAttribute("project");
            ProjectDAO pDAO = new ProjectDAO();
            ContractDAO cDAO = new ContractDAO();
            BidDAO bDAO = new BidDAO();
            Contract c = cDAO.getContractByProjectID(p.getId());
            Bid b = bDAO.getBidByProjectIDandFreelancerEmail(p.getId(), p.getFreelancerEmail());
            p.setStatus("completed");
            //e.setBalance(p.getBudget() - c.getSalary());
            e = eDAO.addFund(e, -b.getAmount());
            pDAO.updateProject(p);
            cDAO.updateContract(c);
            httpSession.setAttribute("employer", e);
            httpSession.setAttribute("project", p);
            response.sendRedirect("ProjectDisplay.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
