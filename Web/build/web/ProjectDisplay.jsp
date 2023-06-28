<%@page import="DAO.FreelancerDAO"%>
<%@page import="Model.*"%>
<%@page import="java.util.List"%>
<%@page import="Controller.PasswordEncryption"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Bootstrap Example</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel='stylesheet' type='text/css' href='style.css'>
        <link rel='stylesheet' type='text/css' href='son.css'>
    </head>
    <body>

        <div class="navbar">
            <jsp:include page="menu/mainmenu.jsp"/>
        </div>

        <div class="container-fluid text-center">    
            <div class="row content">
                <div class="col-sm-2 sidenavp">
                    <p><a href="homepage.jsp">HOME PAGE</a></p>

                </div>
                <%
                    Project p = (Project) session.getAttribute("project");
                    List<Bid> bid = (List<Bid>) session.getAttribute("bids");
                    User u = (User) session.getAttribute("user");
                    boolean check = false;
                    boolean checkf = false;
                %>
                <div class="col-sm-8 text-left"> 
                    <h2>Input project info</h2>
                    <hr>
                    <h4>
                        <p>
                            Name: <%= p.getName()%><br>
                            Description: <%=p.getDesc()%><br>
                            Budget: <%=p.getBudget()%><br>
                            Status: <%=p.getStatus()%><br>
                            Skill: <%=p.getRequiredSkills()%><br>
                            <%if (p.getStatus().equals("working") || p.getStatus().equals("completed")) {%>
                            Freelancer email: <%= p.getFreelancerEmail()%><br>
                            <%}%>
                        <div> 


                            <%if (u == null) {
                                    String mail = null;%>



                            <%} else if (u.getType().equals("freelancer")) {
                                Freelancer f = (Freelancer) session.getAttribute("freelancer");
                                String mail = f.getFreelancerEmail();
                                for (Bid b : bid) {
                                    if (mail.equals(b.getFreelancerEmail())) {
                                        check = true;
                                        break;
                                    }
                                }%>
                            <input id="has-bid" type="hidden" value="<%=check%>">
                            <button id='bid-btn' onclick="document.getElementById('bid').style.display = 'block'" style="display: none">Bid</button>
                            <button id='editbid-btn' onclick="document.getElementById('editbid').style.display = 'block'" style="display: none">Edit bid</button>




                            <%} else if (u.getType().equals("employer")) {
                                Employer em = (Employer) session.getAttribute("employer");
                                if (em.getEmail().equals(p.getEmployerEmail())) {
                                    if (p.getStatus().equals("approved")) {
                                        checkf = true;%>
                            <form id="<%=p.getName()%>" action="EmployerServlet?action=delete-project&id=<%=p.getId()%>" method="post">
                                <input class="btn red" type="submit" value="Delete project">
                            </form>
                            <%}
                                if (p.getStatus().equals("pending")) {
                            %>
                            <form id="<%=p.getName()%>" action="EmployerServlet?action=delete-project&id=<%=p.getId()%>" method="post">
                                <input type="submit" value="Delete project">
                            </form>
                            <button id='editp-btn' onclick="document.getElementById('editp').style.display = 'block'">Edit project</button>
                            <%} else if (p.getStatus().equals("working")) {%>
                            <form action="EmployerServlet?action=close" method="post">
                                <input type="submit" value="Make payment"></form>

                            <% } else if (p.getStatus().equals("completed")) {%>
                            <button id='review-btn' onclick="document.getElementById('review').style.display = 'block'">Write review</button>
                            <% }
                                }%>

                            <%} else if (u.getType().equals("admin")) {%>
                            <form action="AdminServlet?action=delete-project" method="post">
                                <input class="btn red" type="submit" value="Delete Project"></form>
                                <%  if (p.getStatus().equals("pending")) {%>
                            <form action="AdminServlet?action=approve" method="post">
                                <input type="submit" value="Approve Project"></form>
                                <%}
                                }%>
                        </div>
                        Bid list: <br>
                        <div class="container">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>name</th>
                                        <th>amount</th>
                                        <th>skill</th>
                                    </tr>
                                </thead>
                                <%
                                    for (Bid b : bid) {
                                %>
                                <tbody>
                                    <tr>
                                        <td><%=b.getFreelancerEmail()%></td>
                                        <td><%= b.getAmount()%></td>
                                        <%  FreelancerDAO fDAO = new FreelancerDAO();
                                            Freelancer f = fDAO.getFreelancerByEmail(b.getFreelancerEmail());
                                        %>
                                        <td><%=f.getSkill()%></td>
                                        <%if (checkf == true) {%>
                                        <td>
                                            <form action="EmployerServlet?action=hire&freelancer-email=<%=b.getFreelancerEmail()%>&amount=<%=b.getAmount()%>" method="post">
                                                <input class="btn green" type="submit" value="Hire">
                                            </form>
                                        </td>
                                        <td>
                                            <form action="FreelancerServlet?action=get-detail&email=<%=b.getFreelancerEmail()%>" method="post">
                                                <input class="btn green" type="submit" value="Check detail">
                                            </form>
                                        </td>
                                        <%}%>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div> 
                </div>

                <div id='editp' class='modal'>
                    <div class='modal-content animate-top'>
                        <span class='button hover-red top-right font-24' onclick="document.getElementById('editp').style.display = 'none'">&times;</span>
                        <form class='container padding' action='EmployerServlet?action=edit-project' method='post' onsubmit="return validate(this)">
                            <label><b>Enter new project name</b></label>
                            <input class='input border margin-bottom' type='text' placeholder="Enter Name" id='name' name='name' required>
                            <label><b>Enter new description</b></label>
                            <input class='input border margin-bottom' type='text' placeholder="Enter desc" id='desc' name='desc' required>
                            <label><b>Enter new budget</b></label>
                            <input class='input border margin-bottom' type='number' placeholder="Enter Budget" id="budget" name='budget'>                        
                            <label><b>Enter new skills</b></label>
                            <select class="input border margin-bottom" id="skills" name="skills">
                                <option>coding</option>
                                <option>cooking</option>
                                <option>driving</option>
                            </select>                            
                            <input class='green button padding hover-dark-grey' type='submit' value='submit'>
                            <span class='button red hover-dark-grey right-16' onclick="document.getElementById('editp').style.display = 'none'">Cancel</span>
                        </form>                                           
                    </div>
                </div>

                <div id='bid' class='modal'>
                    <div class='modal-content animate-top'>
                        <span class='button hover-red top-right font-24' onclick="document.getElementById('bid').style.display = 'none'">&times;</span>
                        <form class='container padding' action='FreelancerServlet?action=bid' method='post'>
                            <label><b>Amount you want to bid</b></label>
                            <input class='input border margin-bottom' type='text' placeholder="Enter amount you want to bid" id='amount' name='amount' required>                       
                            <input class='green button padding hover-dark-grey' type='submit' value='Post'>
                            <span class='button red hover-dark-grey right-16' onclick="document.getElementById('bid').style.display = 'none'">Cancel</span>
                        </form>
                    </div>
                </div>

                <div id='editbid' class='modal'>
                    <div class='modal-content animate-top'>
                        <span class='button hover-red top-right font-24' onclick="document.getElementById('editbid').style.display = 'none'">&times;</span>
                        <form class='container padding' action='FreelancerServlet?action=editBid' method='post'>
                            <label><b>Amount you want to bid</b></label>
                            <input class='input border margin-bottom' type='text' placeholder="Enter amount you want to add" id='amount' name='amount' required>                       
                            <input class='green button padding hover-dark-grey' type='submit' value='Post'>
                            <span class='button red hover-dark-grey right-16' onclick="document.getElementById('editbid').style.display = 'none'">Cancel</span>
                        </form>
                    </div>
                </div>
                </p>
                </h4>
            </div>
        </div>
    </div>
    <div id='review' class='modal'>
        <div class='modal-content animate-top'>
            <span class='button hover-red top-right font-24' onclick="document.getElementById('review').style.display = 'none'">&times;</span>
            <form class='container padding' action='EmployerServlet?action=review' method='post'>
                <label><b>Review</b></label>
                <input class='input border margin-bottom' type='text' placeholder="Enter Your Review" id='re' name='review' required>
                <label><b>Rating</b></label>
                <input class='input border margin-bottom' type='number' placeholder="Enter Your Rating" id="ra" name='rating' required>                        
                <input class='green button padding hover-dark-grey' type='submit' value='submit'>
                <span class='button red hover-dark-grey right-16' onclick="document.getElementById('review').style.display = 'none'">Cancel</span>
            </form>
        </div>
    </div>
    <footer class="footer-distributed">


        <div class="footer-center">
            <div>
                <i class="fa fa-map-marker"></i>
                <p><span>HCMIU</span> VietNam, HCM</p>
            </div>
            <div>
                <i class="fa fa-phone"></i>
                <p>+1 555 123456</p>
            </div>
            <div>
                <i class="fa fa-envelope"></i>
                <p><a href="mailto:support@company.com">TDD@company.com</a></p>
            </div>
        </div>
        <div class="footer-right">
            <p class="footer-company-about">
                <span>About the ADMIN</span>
                Bui Nguyen Hoang Thong - ITITIU15001<BR>
                Nguyen Quoc Son - ITITIU15054<BR>
                Le Pham Tri Thuc - ITITIU15022
            </p>
            <div class="footer-icons">
                <a href="#"><i class="fa fa-facebook"></i></a>
                <a href="#"><i class="fa fa-twitter"></i></a>
                <a href="#"><i class="fa fa-linkedin"></i></a>
                <a href="#"><i class="fa fa-github"></i></a>
            </div>
        </div>
    </footer>
    <input id="result" type="hidden" value="<%=request.getParameter("result")%>">
    <script>
        if (document.getElementById("has-bid").value === "false") {
            document.getElementById("bid-btn").style.display = 'block';
        } else {
            document.getElementById("editbid-btn").style.display = 'block';
        }
        if (document.getElementById("result").value === "over") {
            alert("Bid amount has to be lower than project budget");
        } else if (document.getElementById("result").value === "unmatch") {
            alert("You didn't set your skill");
        }
    </script> 
</body>
</html>