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
                <h4>
                    <%
                        User u = (User) session.getAttribute("user");
                        List<Project> projects = (List<Project>) session.getAttribute("projects");
                    %>
                    <div class="col-sm-8 text-left"> 
                        <h2>Current project list</h2>
                        <hr>
                        <%if (projects == null) {
                            } else {
                                for (int i = 0; i < projects.size(); i++) {
                                    Project p = projects.get(i);%>
                                    <a href="UserServlet?action=detail&id=<%=p.getId()%>"><%=p.getName()%></a><br>
                        <%}}%>
                            
                </h4>
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