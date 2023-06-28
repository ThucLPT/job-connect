package Controller;

import DAO.*;
import Model.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.logging.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "FreelancerServlet", urlPatterns = {"/FreelancerServlet"})
public class FreelancerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException, Exception {
        String action = request.getParameter("action");
        HttpSession httpSession = request.getSession();

        Freelancer f = (Freelancer) httpSession.getAttribute("freelancer");
        FreelancerDAO fDAO = new FreelancerDAO();

        if (action == null) {
            response.sendRedirect("error.jsp");

        } else if (action.equals("bid")) {
            Project p = (Project) httpSession.getAttribute("project");
            double amount = Double.valueOf(request.getParameter("amount"));
            if (amount > p.getBudget()) {
                response.sendRedirect("ProjectDisplay.jsp?result=over");
            } else if (f.getSkill().equals("none")) {
                response.sendRedirect("ProjectDisplay.jsp?result=unmatch");
            } else {
                Bid b = new Bid();
                BidDAO bDAO = new BidDAO();
                b.setFreelancerEmail(f.getFreelancerEmail());
                b.setProjectId(p.getId());
                b.setAmount(amount);
                fDAO.bid(b);
                List<Bid> bids = bDAO.getBidByProjectID(p.getId());
                httpSession.setAttribute("bids", bids);
                response.sendRedirect("ProjectDisplay.jsp");
            }

        } else if (action.equals("editBid")) {
            Project p = (Project) httpSession.getAttribute("project");
            double amount = Double.valueOf(request.getParameter("amount"));
            if (amount > p.getBudget()) {
                response.sendRedirect("ProjectDisplay.jsp?result=over");
            } else {
                Bid b = new Bid();
                BidDAO bDAO = new BidDAO();
                b.setFreelancerEmail(f.getFreelancerEmail());
                b.setProjectId(p.getId());
                b.setAmount(amount);
                fDAO.editBid(b);
                List<Bid> bids = bDAO.getBidByProjectID(p.getId());
                httpSession.setAttribute("bids", bids);
                response.sendRedirect("ProjectDisplay.jsp");
            }
        } else if (action.equals("get-project")) {
            ProjectDAO pDAO = new ProjectDAO();
            List<Project> projects = pDAO.getProjectsByFreelancerEmail(f.getFreelancerEmail());
            httpSession.setAttribute("projects", projects);
            response.sendRedirect("CurrentProjectList.jsp");
        } else if (action.equals("get-detail")) {
            String email = request.getParameter("email");
            f = fDAO.getFreelancerByEmail(email);
            httpSession.setAttribute("tempfreelancer", f);
            ContractDAO cDAO = new ContractDAO();
            ProjectDAO pDAO = new ProjectDAO();
            UserDAO uDAO = new UserDAO();
            User u = uDAO.getUserByEmail(email);
            httpSession.setAttribute("tempuser", u);
            List<String> reviews = new ArrayList<String>();
            List<Double> ratings = new ArrayList<Double>();
            for (Project p : pDAO.get3LatestProjectsByFreelancerEmail(email)) {
                Contract c = cDAO.getContractByProjectID(p.getId());
                reviews.add(c.getReview());
                ratings.add(c.getRating());
            }
            httpSession.setAttribute("reviews", reviews);
            httpSession.setAttribute("ratings", ratings);
            response.sendRedirect("FreelancerDetail.jsp");
        } else if (action.equals("editSkill")) {
            String skill = request.getParameter("skill");
            f.setSkill(skill);
            fDAO.editSkill(f);
            httpSession.setAttribute("freelancer", f);
            response.sendRedirect("profile.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FreelancerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(FreelancerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FreelancerServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(FreelancerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
