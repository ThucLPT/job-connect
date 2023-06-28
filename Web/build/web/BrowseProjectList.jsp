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
        <link rel="stylesheet" href="css/footer-distributed-with-address-and-phones.css">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
        <link href="http://fonts.googleapis.com/css?family=Cookie" rel="stylesheet" type="text/css">
        <link rel='stylesheet' type='text/css' href='style.css'>
        <link rel='stylesheet' type='text/css' href='son.css'>
        <script>
            function searchInfo() {
                var xhttp;
                var skill = document.myform.skills.value;
                var url = "UserServlet?action=browse-skills&skills=" + skill;
                if (window.XMLHttpRequest) {
                    xhttp = new XMLHttpRequest();
                } else {
                    xhttp = new ActiveXObject("MICROSOFT.XMLHTTP");
                }
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState === 4) {
                        var data = xhttp.responseText;
                        document.getElementById("mydiv").innerHTML = data;
                    }
                };
                xhttp.open("POST", url, true);
                xhttp.send();
            }
        </script>
    </head>
    <body>

        <div class="navbar">
            <jsp:include page="menu/mainmenu.jsp"/>
        </div>

        <div class="container-fluid text-center">    
            <div class="row content">
                <div class="col-sm-2 sidenavp">
                    <!--form action='UserServlet?action=browse-skills' method='post'-->
                    <form name="myform">
                        <p style="color: black;">Enter skill<input type="text" name="skills" onkeyup="searchInfo()"></p>
                        <!--<p><input type="submit" value="Search"></p>-->
                    </form>
                </div>
                <div id="mydiv" class="col-sm-8 text-left"> 
                    <hr>
                    <h4>                       
                        <div class="col-sm-8 text-left"> 
                            <h2>Project list</h2>
                            <hr>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Project Name</th>
                                        <th>Description</th>
                                        <th>Required</th>
                                    </tr>
                                </thead>
                                <%
                                    List<Project> projects = (List<Project>) session.getAttribute("bprojects");
                                    for (Project p : projects) {
                                %> 
                                <tbody>
                                    <tr>
                                        <td><a href="UserServlet?action=detail&id=<%=p.getId()%>"><%=p.getName()%></a></td>
                                        <td><%=p.getDesc()%></td>
                                        <td><%=p.getRequiredSkills()%></td><%}%>
                                    </tr>
                                </tbody>
                            </table>
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
    </body>
</html>