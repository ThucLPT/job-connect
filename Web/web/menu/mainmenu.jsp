<%@page import="Model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="abc()">
        <div>
            <div id="mySidenav" class="sidenav active">
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                <a href="homepage.jsp" style="color:white"><font face = "Comic sans MS" size ="1">HOME PAGE</font></a><hr>
                <a href="UserServlet?action=browse" style="color:white"><font face = "Comic sans MS" size ="1">BROWSE PROJECTS</font></a><hr>

                <%
                    if (session.getAttribute("user") == null) {
                    } else if (((User) session.getAttribute("user")).getType().equals("freelancer")) {
                %>     
                <a href="profile.jsp" style="color:white"><font face = "Comic sans MS" size ="1">PROFILE</font></a><hr>
                <a href="FreelancerServlet?action=get-project" style="color:white"><font face = "Comic sans MS" size ="1">CURRENT PROJECTS</font></a><hr>
                
                    <%} else if (((User) session.getAttribute("user")).getType().equals("employer")) {%>
                <a href="profile.jsp"  style="color:white"><font face = "Comic sans MS" size ="1">PROFILE</font></a><hr>
                <a href="EmployerServlet?action=get-project" style="color:white"><font face = "Comic sans MS" size ="1">CURRENT PROJECTS</font></a><hr>
                <a href="ProjectForm.jsp" style="color:white"><font face = "Comic sans MS" size ="1">POST PROJECTS</font></a><hr>
                
                    <%} else if (((User) session.getAttribute("user")).getType().equals("admin")) {%>
                <a href="BrowseUserList.jsp" style="color:white"><font face = "Comic sans MS" size ="1">DELETE USER</font></a><hr>
                <a href="AdminServlet?action=browse-pending" style="color:white"><font face = "Comic sans MS" size ="1">PENDING PROJECT LIST</font></a><hr>
                    <%}%>
            </div>

            <span style="font-size:25px;cursor:pointer;color: black" onclick="openNav()">&#9776; MENU</span>
            <image src="menu/job.PNG" width="180" height="35"/>
            <div class="navigation">

                <%if (session.getAttribute("user") == null) {%>
                <h4 style="display: inline-block">Hello Guest</h4>
                <button id='reg-btn' onclick="document.getElementById('reg').style.display = 'block'">Register</button>
                <button id='log-btn' onclick="document.getElementById('log').style.display = 'block'">Login</button>

                <%} else if (((User) session.getAttribute("user")).getType().equals("admin")) {
                    Admin ad = (Admin) session.getAttribute("admin");
                %>
                <h6 style="display: inline-block">Hello Admin <%=ad.getEmail()%></h6>
                <a href="UserServlet?action=logout">Logout</a>
                
                <%} else if (((User) session.getAttribute("user")).getType().equals("employer")) {
                    Employer emp = (Employer) session.getAttribute("employer");
                %>
                <h6 style="display: inline-block">Hello Employer <%=emp.getEmail()%></h6>
                <a href="UserServlet?action=logout">Logout</a>
                
                <%} else if (((User) session.getAttribute("user")).getType().equals("freelancer")) {
                    Freelancer free = (Freelancer) session.getAttribute("freelancer");
                %>
                <h6 style="display: inline-block">Hello Freelancer <%=free.getFreelancerEmail()%></h6>
                <a href="UserServlet?action=logout">Logout</a>
                <%}%>

                <div id='log' class='modal'>
                    <div class='modal-content animate-top'>
                        <span class='button hover-red top-right font-24' onclick="document.getElementById('log').style.display = 'none'">&times;</span>
                        <form class='container padding' action='UserServlet?action=login' method='post'>
                            <label><b>Email</b></label>
                            <input class='input border margin-bottom' type='email' placeholder="Enter Email" id='email' name='email' required>
                            <label><b>Password</b></label>
                            <input class='input border margin-bottom' type='password' placeholder="Enter Password" id="password" name='password' required>                        
                            <input class='green button padding hover-dark-grey' type='submit' value='Login'>
                            <span class='button red hover-dark-grey right-16' onclick="document.getElementById('log').style.display = 'none'">Cancel</span>
                        </form>
                    </div>
                </div>

                <div id='reg' class='modal'>
                    <div class='modal-content animate-top'>
                        <span class='button hover-red top-right font-24' onclick="document.getElementById('reg').style.display = 'none'">&times;</span>
                        <form class='container padding' action='UserServlet?action=register' method='post' onsubmit="return validate(this)">
                            <label><b>Name</b></label>
                            <input class='input border margin-bottom' type='text' placeholder="Enter Name" id='name' name='name' required>
                            <label><b>Email</b></label>
                            <input class='input border margin-bottom' type='email' placeholder="Enter Email" id='email' name='email' required>
                            <label><b>Password</b></label>
                            <input class='input border margin-bottom' type='password' placeholder="Enter Password" id="reg-password" name='password' required onkeyup="check()">                        
                            <label><b>Repeat Password</b></label>
                            <input class='input border margin-bottom' type='password' placeholder="Repeat Password" id="confirm" name='confirm' required onkeyup='check()'>
                            <!--p id="fund"><b>Fund</b>
                                <input class='input border margin-bottom' type="number" placeholder="Add Fund" name="fund"></p>
                            <p id="skil"><b>Skill</b><br>
                                <select class='input border margin-bottom' name="skil">
                                    <option>coding</option>
                                    <option>cooking</option>
                                    <option>driving</option>
                                </select></p-->
                            <span id="message" style='display: block'></span>
                            <label><b>User type</b></label>
                            <input type='radio' name='type' value='freelancer' required onclick="f()"><span class='info' title='Join a project and get paid'>Freelancer</span>
                            <input type='radio' name='type' value='employer' required onclick="e()"><span class='info' title='Find the right person for your project'>Employer</span><br>
                            <input class='green button padding hover-dark-grey' type='submit' value='Register'>
                            <span class='button red hover-dark-grey right-16' onclick="document.getElementById('reg').style.display = 'none'">Cancel</span>
                        </form>                                           
                    </div>
                </div>        
            </div>          
        </div>

        <script>
            function check() {
                if (document.getElementById('reg-password').value === document.getElementById('confirm').value) {
                    document.getElementById('message').style.color = 'green';
                    document.getElementById('message').innerHTML = 'Passwords matched';
                } else {
                    document.getElementById('message').style.color = 'red';
                    document.getElementById('message').innerHTML = "Passwords didn't match";
                }
            }

            function openNav() {
                document.getElementById("mySidenav").style.width = "200px";
            }

            /* Set the width of the side navigation to 0 */
            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }

            function abc() {
                $("#fund").hide();
                $("#skil").hide();
            }
            function e() {
                $("#fund").show();
                $("#skil").hide();
            }
            function f() {
                $("#skil").show();
                $("#fund").hide();
            }
        </script>
    </body>
</html>