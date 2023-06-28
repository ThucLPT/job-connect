<%@page import="Controller.PasswordEncryption"%>
<%@page import="Model.*"%>
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

                </div>
                <%User u = (User) session.getAttribute("user");%>
                <div class="col-sm-8 text-left"> 
                    <h2>Profile</h2>
                    <hr>
                    <h4>
                        Name: <%=u.getName()%><br>
                        Email: <%=u.getEmail()%><br>

                        <%
                            if (((User) session.getAttribute("user")).getType().equals("employer")) {
                                Employer em = (Employer) session.getAttribute("employer");
                        %>
                        Balance: <%=em.getBalance()%><br>
                        <button id='add-btn' onclick="document.getElementById('add').style.display = 'block'">ADD FUND</button>
                        <%}%>

                        <%
                            if (((User) session.getAttribute("user")).getType().equals("freelancer")) {
                                Freelancer f = (Freelancer) session.getAttribute("freelancer");
                        %>                                               
                        Skill: <%=f.getSkill()%><br>
                        <button id='skill-btn' onclick="document.getElementById('skill').style.display = 'block'">EDIT SKILL</button>
                        <%}%>

                        <button id='edit-btn' onclick="document.getElementById('edit').style.display = 'block'" >EDIT PROFILE</button>

                        <div id='add' class='modal'>
                            <div class='modal-content animate-top'>
                                <span class='button hover-red top-right font-24' onclick="document.getElementById('add').style.display = 'none'">&times;</span>
                                <form class='container padding' action='EmployerServlet?action=add-fund' method='post'>
                                    <label><b>Amount</b></label>
                                    <input class='input border margin-bottom' type='text' placeholder="Enter amount you want to add" id='amount' name='amount' required>                       
                                    <input class='green button padding hover-dark-grey' type='submit' value='Post'>
                                    <span class='button red hover-dark-grey right-16' onclick="document.getElementById('add').style.display = 'none'">Cancel</span>
                                </form>
                            </div>
                        </div>
                        <div id='edit' class='modal'>
                            <div class='modal-content animate-top'>
                                <span class='button hover-red top-right font-24' onclick="document.getElementById('edit').style.display = 'none'">&times;</span>
                                <form class='container padding' action='UserServlet?action=edit' method='post' onsubmit="return validate(this)" >
                                    <label><b>Change the value you want to edit</b></label><br>
                                    <label><b>Name</b></label>
                                    <input class='input border margin-bottom' type='text' placeholder="Enter Name" id='name' name='name' required value="<%= u.getName()%>">
                                    <label><b>Password</b></label>
                                    <input class='input border margin-bottom' type='password' placeholder="Enter Password" id="reg-password" name='password' required value="<%= PasswordEncryption.decrypt(u.getPassword())%>" onkeyup='check();'>                        
                                    <label><b>Repeat Password</b></label>
                                    <input class='input border margin-bottom' type='password' placeholder="Repeat Password" id="confirm" name='confirm' required onkeyup='check();'>
                                    <span id="message" style='display: block'></span>
                                    <input class='green button padding hover-dark-grey' type='submit' value='submit'>
                                    <span class='button red hover-dark-grey right-16' onclick="document.getElementById('edit').style.display = 'none'">Cancel</span>
                                </form>                                           
                            </div>
                        </div>
                        <div id='skill' class='modal'>
                            <div class='modal-content animate-top'>
                                <span class='button hover-red top-right font-24' onclick="document.getElementById('skill').style.display = 'none'">&times;</span>
                                <form class='container padding' action='FreelancerServlet?action=editSkill' method='post' >
                                    <label><b>Change your display skill</b></label><br>
                                    <label><b>Select skill</b></label>
                                    <select name="skill">     
                                        <option>coding</option>     
                                        <option>cooking</option>    
                                        <option>driving</option>     
                                    </select> <br>
                                    <input class='green button padding hover-dark-grey' type='submit' value='submit'>
                                    <span class='button red hover-dark-grey right-16' onclick="document.getElementById('skill').style.display = 'none'">Cancel</span>
                                </form>                                           
                            </div>
                        </div>
                    </h4>
                </div>
                <div class="col-sm-2 sidenavp">
                    <div class="well">
                        <h2>Need to hire a freelancer for a job?</h2>
                        <p>It’s free to sign up, type in what you need & receive free quotes in seconds</p>
                    </div>

                </div>
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

        <script>
            function check() {
                if (document.getElementById('reg-password').value ===
                        document.getElementById('confirm').value) {
                    document.getElementById('message').style.color = 'green';
                    document.getElementById('message').innerHTML = 'Passwords matched';
                } else {
                    document.getElementById('message').style.color = 'red';
                    document.getElementById('message').innerHTML = "Passwords didn't match";
                }
            }
        </script>
    </body>
</html>