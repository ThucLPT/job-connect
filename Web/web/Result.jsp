<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Project"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <hr><h2>Project List</h2><hr>
        <h4>
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

        </h4>
    </body>
</html>