<%-- 
    Document   : LogIn
    Created on : 22-mrt-2016, 9:07:35
    Author     : Milton
--%>

<%@page import="BusinessLayer.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Copy</title>
        <link rel="stylesheet" href="bootstrap.css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <%
        Cookie[] cookies = request.getCookies();
        boolean loggedIn = false;

        if(cookies != null)
        {
            for(Cookie cookie : cookies)
            {
                if(cookie.getName().equals("username"))
                {
                    loggedIn = true;
                    
                    Cookie killMyCookie = new Cookie(cookie.getName(), null);
                    killMyCookie.setMaxAge(-1);
                    //killMyCookie.setPath("/");
                    response.addCookie(killMyCookie);
                    
                    response.sendRedirect("index.jsp");
                }                    
            }
        }
        
        if(!loggedIn)
        {
        %>
        <div id="content" class="row col-md-12">
            <h1>Log-In</h1>
            <form method="post" name="form1" action="${pageContext.request.contextPath}/MyServlet">
                <div class="row col-md-12">
                    <div class="col-md-1">
                        Username:
                    </div>
                    <div class="col-md-11">
                        <input type="text" name="fUsername">
                    </div>
                </div>
                <div class="row col-md-12">
                    <div class="col-md-1">
                        Password:
                    </div>
                    <div class="col-md-11">
                        <input type="password" name="fPassword">
                    </div>
                </div>
                <div class="row col-md-12">
                    <div class="col-md-1">
                        <input type="submit">
                    </div>
                </div>                
            </form>
        </div>   
        <%
        }
        %>
        <jsp:include page="footer.jsp"/>
    </body>
</html>
