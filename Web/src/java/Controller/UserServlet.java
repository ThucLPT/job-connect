package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import Model.*;
import DAO.*;
import java.sql.*;
import java.util.List;
import java.util.logging.*;

@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException, Exception {
        String action = request.getParameter("action");

        User u = new User();
        Admin ad = new Admin();
        Freelancer f = new Freelancer();
        Employer em = new Employer();
        UserDAO uDAO = new UserDAO();
        EmployerDAO eDAO = new EmployerDAO();
        FreelancerDAO fDAO = new FreelancerDAO();
        AdminDAO adDAO = new AdminDAO();
        HttpSession httpSession = request.getSession();

        if (action == null) {
            response.sendRedirect("error.jsp");
        } else if (action.equals("login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                u = uDAO.getUserByEmail(email);

                String uEmail = u.getEmail();
                String uPassword = PasswordEncryption.decrypt(u.getPassword());

                if (!email.equals(uEmail) || !password.equals(uPassword)) {
                    response.sendRedirect("homepage.jsp?result=wrong");
                } else {
                    httpSession.setAttribute("user", u);

                    switch (u.getType()) {
                        case "freelancer":
                            f = fDAO.getFreelancerByEmail(u.getEmail());
                            httpSession.setAttribute("freelancer", f);
                            break;
                        case "employer":
                            em = eDAO.getEmployerByEmail(u.getEmail());
                            httpSession.setAttribute("employer", em);
                            break;
                        case "admin":
                            ad = adDAO.getAdminByEmail(u.getEmail());
                            httpSession.setAttribute("admin", ad);
                            break;
                    }
                    response.sendRedirect("homepage.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        } else if (action.equals("register")) {
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            if (!uDAO.containsEmail(email)) {
                u.setEmail(email);
                u.setType(type);
                u.setName(name);
                String password = request.getParameter("password");
                u.setPassword(PasswordEncryption.encrypt(password));
                uDAO.addUser(u);
                httpSession.setAttribute("user", u);
                switch (type) {
                    case "freelancer":
                        fDAO.addFreelancer(u);
                        f = fDAO.getFreelancerByEmail(u.getEmail());
                        httpSession.setAttribute("freelance", f);
                        break;
                    case "employer":
                        eDAO.addEmployer(u);
                        em = eDAO.getEmployerByEmail(u.getEmail());
                        httpSession.setAttribute("employer", em);
                        break;
                }
                response.sendRedirect("homepage.jsp");
            } else {
                response.sendRedirect("homepage.jsp?result=exist");
            }
        } else if (action.equals("logout")) {
            httpSession.invalidate();
            response.sendRedirect("homepage.jsp");
        } else if (action.equals("edit")) {
            u = (User) httpSession.getAttribute("user");
            String newName = request.getParameter("name");
            String newPassword = request.getParameter("password");
            u.setName(newName);
            u.setPassword(PasswordEncryption.encrypt(newPassword));
            u = uDAO.editProfile(u);
            httpSession.setAttribute("user", u);
            response.sendRedirect("profile.jsp");

        } else if (action.equals("detail")) {
            ProjectDAO pDAO = new ProjectDAO();
            BidDAO bDAO = new BidDAO();
            Project p = pDAO.getProjectsById(Integer.valueOf(request.getParameter("id")));
            List<Bid> bids = bDAO.getBidByProjectID(p.getId());
            httpSession.setAttribute("bids", bids);
            httpSession.setAttribute("project", p);
            response.sendRedirect("ProjectDisplay.jsp");
        } else if (action.equals("browse")) {
            ProjectDAO pDAO = new ProjectDAO();
            List<Project> bprojects = pDAO.getProjectsByStatus("approved");
            httpSession.setAttribute("bprojects", bprojects);
            response.sendRedirect("BrowseProjectList.jsp");
        } else if (action.equals("browse-skills")) {
            ProjectDAO pDAO = new ProjectDAO();
            String skills = request.getParameter("skills");
            List<Project> bprojects = pDAO.getProjectsBySkills(skills);
            httpSession.setAttribute("bprojects", bprojects);
            //response.sendRedirect("BrowseProjectList.jsp");
            request.getRequestDispatcher("Result.jsp").forward(request, response);
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
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
