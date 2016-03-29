<%-- 
    Document   : Header
    Created on : 15-mrt-2016, 13:42:39
    Author     : Milton
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="com.example.i18n.text" />
<!DOCTYPE html>
<html lang="${language}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="language">
                <a href="LogIn.jsp"> <!-- Dutch -->
                    <div id="lan_nl">                    
                    </div>                                          
                </a>   
                <a href="LogIn.jsp"> <!-- English -->
                    <div id="lan_eng">
                    </div>
                </a>
            </div>
            <div class="container row">
                <div class="col-md-2">
                    <a href="index.jsp">
                        <img id="logo" src="images/logo.jpg"/>
                    </a>
                </div>
                <div id="wrapper" class="col-md-10">
                    <div class="collapse navbar-collapse">
                        <br/>
                        <ul class="nav navbar-nav">
                            <li>
                                <a href="LogIn.jsp">Log-In</a>
                            </li>
                            <li>
                                <a href="apply.jsp">Apply</a>
                            </li>
                            <li>
                                <a href="#about">About</a>
                            </li>
                            <li>
                                <a href="#contact">Contact</a>
                            </li>
                            
                        </ul>
                    </div>                     
                </div>
            </div>
        </nav>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
    </body>
</html>
