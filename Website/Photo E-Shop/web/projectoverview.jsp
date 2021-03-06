<%-- 
    Document   : projectoverview
    Created on : 5-apr-2016, 10:52:37
    Author     : Stefan
--%>

<%@page import="BusinessLayer.Project"%>
<%@page import="BusinessLayer.ProjectOverview"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Package.Database"%>
<%@page import="javax.swing.JTable"%>
<%@page import="BusinessLayer.Connection"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@page import="BusinessLayer.Connection"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="Languages.Language" />
<!DOCTYPE html>
<html lang="${language}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <script type="text/javascript">
            function validateForm() 
            {
                var a = document.forms["myForm"]["Name"].value;
                var b = document.forms["myForm"]["Client"].value;
                var c = document.forms["myForm"]["StartDate"].value;
                var d = document.forms["myForm"]["EndDate"].value;
                if (a == null || a == "") {
                    alert("Name must be filled out");
                    return false;
                }
                if (b == null || b == "") {
                    alert("Client must be filled out");
                    return false;
                }
                if (c == null || c == "") {
                    alert("Startdate must be filled out");
                    return false;
                }
                if (d == null || d == "") {
                    alert("Enddate must be filled out");
                    return false;
                }
                
            }
        </script>
            <%
                Connection connection = new Connection();
                Database database = new Database();
                int projectid = 1;
                ProjectOverview po = ProjectOverview.getInstance();
                Cookie[] cookies = request.getCookies();
                Database db = new Database();
                String email = "test";
                for (Cookie cookie : cookies)
                {
                    if(cookie.getName().equals("Email"))
                    {
                        email = cookie.getValue();
                    }
                }
                po.loadProjects(email);
                


                
            %>   
            <form name="myForm" id="projectform" action="${pageContext.request.contextPath}/Projectoverviewservlet" on submit="return validateForm()" method="POST" enctype="multipart/form-data">
                <div id="projectdiv" >
                <TABLE id = "projecttable" BORDER =1 id="left">
                    <TR>
                        <TH><fmt:message key="project.label.select" /></TH>
                        <TH><fmt:message key="project.label.name" /></TH>
                        <TH><fmt:message key="project.label.client" /></TH>
                        <TH><fmt:message key="project.label.start" /></TH>
                        <TH><fmt:message key="project.label.end" /></TH>
                    </TR>
                    
                
        <%
            ResultSet resultset = null;
            if(db.Connect())
            {
                resultset = db.GetQuery("select Projectid, \"Name\", Client, StartDate, EndDate from \"Project\" where CompanyID =(select CompanyId from Company where UserID = (Select UserID from \"User\" where Email = '" + email + "'))"); //vervangen door variable
            }
            while (resultset.next())
            {
        %>
            <TR>
                <TD><input type="radio" name="selectproject" value="<%= resultset.getInt("Projectid") %>"></td></TD>
                <TD><%= resultset.getString("Name") %> </TD> 
                <TD><%= resultset.getString("Client") %> </TD> 
                <TD><%= resultset.getString("StartDate") %> </TD> 
                <TD><%= resultset.getString("EndDate") %> </TD> 
            </TR>
        <% 
            } 
        %>
            </TABLE> 
            <input type="submit" name="deleteproject" value="<fmt:message key="project.button.deleteproject" />" class="break"/>
            <input type="submit" name="openproject" value="<fmt:message key="project.button.openproject" />" class="break"/>
            </div>
            <div id="right">
                <%
                    
                    Project project = (Project)(request.getAttribute("project"));
                    request.setAttribute("project", project);
                    if(project!= null)
                    {
                     //select hier ook via de koppeltabel alle images van een project
                        //select * from Picture where project == selected project id
                %>
                        <label for="name" class="nobreak"><fmt:message key="project.label.name" /></label><input type="text" name="name" class="break" value="<%= project.getName()%>"/>
                        <label for="client" class="nobreak"><fmt:message key="project.label.client" /></label><input type="text" name="client" class="break" value="<%= project.getClient()%>"/>
                        <label for="startdate" class="nobreak"><fmt:message key="project.label.start" /></label><input type="date" name="startdate" class="break" value="<%= project.getStartDate() %>"/>
                        <label for="endddate" class="nobreak"><fmt:message key="project.label.end" /></label><input type="date" name="enddate" class="break" value="<%= project.getEndDate() %>"/>
                <%
                    }
                    else
                    {
                %>
                        <label for="name" class="nobreak"><fmt:message key="project.label.name" /></label><input type="text" name="name" class="break" value=""/>
                        <label for="name" class="nobreak"><fmt:message key="project.label.client" /></label><input type="text" name="client" class="break" value=""/>
                        <label for="name" class="nobreak"><fmt:message key="project.label.start" /></label><input type="date" name="startdate" class="break" value=""/>
                        <label for="name" class="nobreak"><fmt:message key="project.label.end" /></label><input type="date" name="enddate" class="break" value=""/>
                <%
                    }
                %>
                
                <input type="submit" name ="Save" value="<fmt:message key="project.button.save" />" onclick="validatForm()"/>
                
            </div>
            <div id="upload">
                <div id="picturepart">
                    <TABLE id = "picturetable" BORDER =1>
                        <TR>
                            <th><fmt:message key="project.label.select" /></th>
                            <TH><fmt:message key="project.label.images" /></TH>
                        </TR>
                        <%
                            //String project = "test";//selected project uit projectengridview
                            if(db.Connect())
                            {
                                //resultset = db.GetQuery("select images from project where projectname = '" + project +  "'"); //vervangen door variable
                            }
                            while (resultset.next())
                            {
                        %>
                        <TR>
                            <TD><input type="checkbox" name="select" value="<fmt:message key="project.label.select" />"></TD>
                            <TD><!--<%//= resultset.getString("Name") %> --></TD> 
                        </TR>
                        <% 
                            } 
                        %>
                    </table>

                    <input type="file"  name="fileupload" value="<fmt:message key="project.button.choosefile" />"/>
                    <input type="submit" name="submit"  value="<fmt:message key="project.button.uploadfile" />" />
                    <input type="submit" name="deleteimage" value="<fmt:message key="project.button.delete" />"/>
                    <input type="submit" name="importimage" value="<fmt:message key="project.button.import" />"/>
                </div>       
                <input type="submit" name="koppel" value="<fmt:message key="project.button.link" />"/>
                
                <div id="emailpart">
                    <TABLE id = "emailtable" BORDER =1 id="left">
                        <TR>
                            <th><fmt:message key="project.label.select" /></th>
                            <TH><fmt:message key="project.label.emails" /></TH>
                        </TR>
                        <%
                            //project = "test";//selected project uit projectengridview
                        try    
                        {
                            File file = new File("test.txt");
                            FileReader fileReader = new FileReader(file);
                            BufferedReader bufferedReader = new BufferedReader(fileReader);
                            StringBuffer stringBuffer = new StringBuffer();
                            String line;
                            while ((line = bufferedReader.readLine()) != null) {
                                    stringBuffer.append(line);
                                    stringBuffer.append("\n");
                            }
                            fileReader.close();
                            System.out.println("Contents of file:");
                            System.out.println(stringBuffer.toString());
                        
                        
                        %>
                        <TR>
                            <TD><input type="checkbox" name="select" value="<fmt:message key="project.label.select" />"></TD>
                            <TD><%= line%></TD> 
                        </TR>
                        <% 
                            } 
                           catch (IOException e) 
                            {
                                e.printStackTrace();
                            }
                        %>
                    </table>
                    <input type="submit" name="addemail"  value="<fmt:message key="project.button.addEmail" />" /><!-- insert uploaded image naar database (blob)-->
                    <input type="submit" name="deleteemail" value="<fmt:message key="project.button.deleteEmail" />"/>
                    <input type="submit" name="importemail" value="<fmt:message key="project.button.importEmail" />"/>
                </div>  
  
            </div>
                    
            </form>
            <%
               /*if ("POST".equalsIgnoreCase(request.getMethod())) {
               File file ;
               int maxFileSize = 5000 * 1024;
               int maxMemSize = 5000 * 1024;
               ServletContext context = pageContext.getServletContext();
               String filePath = "C:\\xampp\\tomcat\\webapps\\Photo_E-Shop\\images\\";

               // Verify the content type
               String contentType = request.getContentType();
               if ((contentType.indexOf("multipart/form-data") >= 0)) {

                  DiskFileItemFactory factory = new DiskFileItemFactory();
                  // maximum size that will be stored in memory
                  factory.setSizeThreshold(maxMemSize);
                  // Location to save data that is larger than maxMemSize.
                  factory.setRepository(new File("C:\\xampp\\tomcat\\webapps\\Photo_E-Shop\\images\\"));

                  // Create a new file upload handler
                  ServletFileUpload upload = new ServletFileUpload(factory);
                  // maximum file size to be uploaded.
                  upload.setSizeMax( maxFileSize );
                  try{ 
                     // Parse the request to get file items.
                     List fileItems = upload.parseRequest(request);

                     // Process the uploaded file items
                     Iterator i = fileItems.iterator();
            //
            //         out.println("<html>");
            //         out.println("<head>");
            //         out.println("<title>JSP File upload</title>");  
            //         out.println("</head>");
            //         out.println("<body>");
                     while ( i.hasNext () ) 
                     {
                        FileItem fi = (FileItem)i.next();
                        if ( !fi.isFormField () )	
                        {
                        // Get the uploaded file parameters
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();
                        // Write the file
                        if( fileName.lastIndexOf("\\") >= 0 ){ 
                        file = new File( filePath + 
                        fileName.substring( fileName.lastIndexOf("\\"))) ;
                        }else{
                        file = new File( filePath + 
                        fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                        }
                        fi.write( file ) ;
                        
                        
                        BufferedImage in = ImageIO.read(file);
                        //select project id van selected project
                        
                        //insert ook in koppeltabel
                        out.println("Uploaded Filename: " + filePath + 
                        fileName + "<br>");
                        }
                     }
            //         out.println("</body>");
            //         out.println("</html>");
                  }catch(Exception ex) {
                     System.out.println(ex);
                  }
               }else{
            //      out.println("<html>");
            //      out.println("<head>");
            //      out.println("<title>Servlet upload</title>");  
            //      out.println("</head>");
            //      out.println("<body>");
            //      out.println("<p>No file uploaded</p>"); 
            //      out.println("</body>");
            //      out.println("</html>");
               }
                }*/
            %>            

        <jsp:include page="footer.jsp"/>
    </body>
</html>
