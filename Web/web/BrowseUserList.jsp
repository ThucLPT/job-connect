<%@page import="java.util.List"%>
<%@page import="Controller.PasswordEncryption"%>
<%@page import="Model.User"%>
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
                    <form action='AdminServlet?action=browse-user' method='post'>
                        <p style="color: black;">Enter user name<input type="text" name="name"></p>
                        <p><input type="submit" value="Seach"></p>
                    </form>
                </div>
                <div class="col-sm-8 text-left"> 
                    <hr>
                    <h4>

                        <%
                            List<User> users = (List<User>) session.getAttribute("users");
                            if (users == null) {
                            } else {%>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Email</th>
                                    <th>Name</th>
                                    <th>Type</th>
                                </tr>
                            </thead>
                            <%for (User u : users) {%>
                            <tbody>
                                <tr>
                                    <td><%=u.getEmail()%></td>
                                    <td><%=u.getName()%></td>
                                    <td><%=u.getType()%></td>
                                    <td><a href="AdminServlet?action=delete-user&email=<%=u.getEmail()%>">Delete user</a></td>
                                </tr>
                            </tbody>
                            <%}%>
                        </table>
                        <%}%>
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

    </body>
</html>