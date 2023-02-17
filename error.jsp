<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<html>
    <head>
        <title>Error Page</title>
        <style>
            .error{
                color:red;
            }
        </style>
    </head>

    <body>
        <div class="page-container">

            <%
                String type = (String)request.getAttribute("error");
                
                if(type.equals("sessionExpired")){
            %>
            
            <div class="error">
                <h2>Session is expired...</h2>
            </div>

            <%
                }

                else if(type.equals("invalidSession")){

                
            %>

            <div class="error">
                <h2>Authentication Error</h2>
                <h2>You can't access this page!</h2>
            </div>
            <%
                }
            %>
        </div>
    </body>

</html>