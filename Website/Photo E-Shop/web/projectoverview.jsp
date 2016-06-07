<%-- 
    Document   : projectoverview
    Created on : 5-apr-2016, 10:52:37
    Author     : Stefan
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Package.Database"%>
<%@page import="javax.swing.JTable"%>
<%@page import="BusinessLayer.Connection"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="row col-md-6">
            <%
                Connection connection = new Connection();
                Database database = new Database();
                int projectid = 1;
            %>
        </div>
        <div id="content" class="row col-md-12"></div>
            <div></div>    
            
            

            <form id="projectform" action="${pageContext.request.contextPath}/projectoverviewclass" method="post" enctype="multipart/form-data">
                <div id="projectdiv" >
                <TABLE id = "projecttable" BORDER =1 id="left">
                    <TR>
                        <TH>Select</TH>
                        <TH>Name</TH>
                        <TH>Client</TH>
                        <TH>Start</TH>
                        <TH>End</TH>
                    </TR>
                    
                
        <%
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
            ResultSet resultset = null;
            if(db.Connect())
            {
                resultset = db.GetQuery("select \"Name\", Client, StartDate, EndDate from \"Project\" where CompanyID =(select CompanyId from Company where UserID = (Select UserID from \"User\" where Email = '" + email + "'))"); //vervangen door variable
            }
            while (resultset.next())
            {
        %>
            <TR>
                <TD><input type="radio" name="select" value="select"></td></TD>
                <TD><%= resultset.getString("Name") %> </TD> 
                <TD><%= resultset.getString("Client") %> </TD> 
                <TD><%= resultset.getString("StartDate") %> </TD> 
                <TD><%= resultset.getString("EndDate") %> </TD> 
            </TR>
        <% 
            } 
        %>
            </TABLE> 
            <input type="button" name="deleteproject" value="Delete Selected Project" class="break"/>
            <input type="button" name="deleteproject" value="Delete Selected Project" class="break"/>
            </div>
            <div id="right">
                <label for="name" class="nobreak">Name</label><input type="text" name="name" class="break"/>
                <label for="name" class="nobreak">Client</label><input type="text" name="client" class="break"/>
                <label for="name" class="nobreak">Start</label><input type="date" name="startdate" class="break"/>
                <label for="name" class="nobreak">End</label><input type="date" name="enddate" class="break"/>
                <input type="button" value="Save"/>
                
            </div>
            <div id="upload">
                <div id="picturepart">
                    <TABLE id = "picturetable" BORDER =1>
                        <TR>
                            <th>Select</th>
                            <TH>Images</TH>
                        </TR>
                        <%
                            String project = "test";//selected project uit projectengridview
                            if(db.Connect())
                            {
                                //resultset = db.GetQuery("select images from project where projectname = '" + project +  "'"); //vervangen door variable
                            }
                            while (resultset.next())
                            {
                        %>
                        <TR>
                            <TD><input type="checkbox" name="select" value="select"></TD>
                            <TD><!--<%//= resultset.getString("Name") %> --></TD> 
                        </TR>
                        <% 
                            } 
                        %>
                    </table>

                    <input type="file"  name="fileupload" value="Upload a file"/>
                    <input type="submit" name="submit"  value="Upload File" /><!-- insert uploaded image naar database (blob)-->
                    <input type="button" name="deleteimage" value="Delete"/>
                    <input type="button" name="importimage" value="Import"/>
                </div>       
                <input type="button" name="koppel" value="<-Link->"/>
                
                <div id="emailpart">
                    <TABLE id = "emailtable" BORDER =1 id="left">
                        <TR>
                            <th>Select</th>
                            <TH>Emails</TH>
                        </TR>
                        <%
                            project = "test";//selected project uit projectengridview
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
                            <TD><input type="checkbox" name="select" value="select"></TD>
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
                    <input type="button" name="addemail"  value="add" /><!-- insert uploaded image naar database (blob)-->
                    <input type="button" name="deleteemail" value="Delete"/>
                    <input type="button" name="importemail" value="Import"/>
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
