<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Theme Made By www.w3schools.com - No Copyright -->
        <title>Bootstrap Theme Company Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel='stylesheet' type='text/css' href='style.css'>
        <link rel='stylesheet' type='text/css' href='son.css'>
    </head>
    <body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

        <div class="navbar">
            <jsp:include page="menu/mainmenu.jsp"/>
        </div>

        <div class="jumbotron text-center">
            <h1>JOB-CONNECTION</h1> 
            <p>The site to connect freelancer to employer</p> 
            <form>
                <button type="button" class="btn btn-warning" style="background-color: #f44336">
                    <a href="UserServlet?action=browse" style="color:white"><font face = "Comic sans MS" size ="1">BROWSE PROJECTS</font></a></button>

            </form>
        </div>

        <!-- Container (About Section) -->
        <div id="about" class="container-fluid">
            <div class="row">
                <div class="col-sm-8">
                    <h2>About This Site</h2><br>
                    <h4>Our website is a freelance and crowdsourcing marketplace.The platform is also utilized by talents from all over the world, giving businesses and entrepreneurs a global pool of competitive freelancers.</h4><br>
                    <p>With our website, employers can find the talent they need to do various jobs. The marketplace is vast so they can rest assured they will find the right person for their project.
                        In our website, employers have a wide range of freelancers available to them. The platform provides them with an avenue to find the best talent for a project. They have access to a pool of workers who are competitive and who bid to offer them their services. Aside from that, employers can also reach out to potential hires whose portfolios attract them.
                        Employers can easily narrow down their talent search. The freelancer marketplace has a program that tags elite-level workers. This allows the employer to seek a talent from the best of the best to ensure the finest outcome for their project.
                        Some employers prefer hourly contracts so our website has put in place milestone settings. These allow the employer to set milestones a freelancer has to reach before they are able to receive payments. This assures employers that workers provide what is due to them.</p>
                    <br><button id='reg-btn' onclick="document.getElementById('reg').style.display = 'block'">REGISTER NOW</button>
                </div>

                <div class="col-sm-4">
                    <span class="glyphicon logo"> <image src="job-logo.png" width="300" height="300"></span>
                </div>
            </div>
        </div>

        <div class="container-fluid bg-grey">
            <div class="row">
                <div class="col-sm-4">
                    <span class="glyphicon logo"><image src="g.jpg" width="300" height="300"></span>
                </div>
                <div class="col-sm-8">
                    <h2>Our Values</h2><br>
                    <h4><strong>MISSION:</strong> With our website, employers can find the talent they need to do various jobs. The marketplace is vast so they can rest assured they will find the right person for their project.
                        In our website, employers have a wide range of freelancers available to them. The platform provides them with an avenue to find the best talent for a project. They have access to a pool of workers who are competitive and who bid to offer them their services. Aside from that, employers can also reach out to potential hires whose portfolios attract them.
                        Employers can easily narrow down their talent search. The freelancer marketplace has a program that tags elite-level workers. This allows the employer to seek a talent from the best of the best to ensure the finest outcome for their project.
                        Some employers prefer hourly contracts so our website has put in place milestone settings. These allow the employer to set milestones a freelancer has to reach before they are able to receive payments. This assures employers that workers provide what is due to them.</h4><br>
                </div>
            </div>
        </div>

        <!-- Container (Services Section) -->
        <div id="services" class="container-fluid text-center">
            <h2>SERVICES</h2>
            <h4>What we offer</h4>
            <br>
            <div class="row slideanim">
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-wrench logo-small"></span>
                    <h4 style="color:#303030;">RIGHT FREELANCER</h4>
                </div>
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-certificate logo-small"></span>
                    <h4>CONVENIENT</h4>
                </div>
                <div class="col-sm-4">
                    <span class="glyphicon glyphicon-lock logo-small"></span>
                    <h4>JOB DONE</h4>
                </div>
            </div>
            <br>
        </div>

        <!-- Container (Portfolio Section) -->
        <div id="portfolio" class="container-fluid text-center bg-grey">


            <h2>What our customers say</h2>
            <div id="myCarousel" class="carousel slide text-center" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <h4>"EXCELLLENT WEBSITE"<br><span>Thuc</span></h4>
                    </div>
                    <div class="item">
                        <h4>"GREAT FREELANCERS"<br><span>Thong</span></h4>
                    </div>
                    <div class="item">
                        <h4>"5 STARS FOR SURE"<br><span>Son</span></h4>
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control green" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control green" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>

        <!-- Container (Pricing Section) -->

        <!-- Container (Contact Section) -->
        <div id="contact" class="container-fluid bg-grey">
            <h2 class="text-center">CONTACT</h2>
            <h3 class="text-center">Name: Nguyễn Quốc Sơn <br>
                Id: ITITIU15054 <br>
                School: International University <hr>

                Name: Bùi Nguyễn Hoàng Thông <br>
                Id: ITITIU15001 <br>
                School: International University <hr>

                Name: Lê Phạm Tri Thức <br>
                Id: ITITIU15022 <br>
                School: International University <hr></h3>
        </div>
        <input id="result" type="hidden" value="<%=request.getParameter("result")%>">
        <script>
            function openNav() {
                document.getElementById("mySidenav").style.width = "200px";
            }

            /* Set the width of the side navigation to 0 */
            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }
            if (document.getElementById("result").value === "exist") {
                alert("Email already exist");
            } else if (document.getElementById("result").value === "wrong") {
                alert("Wrong username or password");
            }
        </script>
    </body>
</html>