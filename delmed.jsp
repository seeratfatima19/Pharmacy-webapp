<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>

    <head>
        <title>Delete Medicine Record</title>
        <link href="style.css" rel="stylesheet">

        <script>
            function validateDel(){
                var name = document.getElementById("name").value;
                var id = document.getElementById("id").value;
                
             if(name==""){   
                document.getElementById('error-container').innerHTML= "Name can't be empty!";
                 return false;
             }

             if(id==""){
                document.getElementById('error-container').innerHTML= "Enter Product ID";
                 return false;
             }
            }
        </script>
        <style>
            .page-container{
                display: flex;
                flex-direction: column;
            }
        </style>
    </head>
    <body>

        <div class="page-container">

            <h2>Delete Medicine Record</h2>

            <%
                if(session==null){
                    response.sendRedirect("login.html");
                }                
                String type = (String)session.getAttribute("type");
            
                if(type==null){
                    RequestDispatcher rd= request.getRequestDispatcher("error.jsp");
                    request.setAttribute("error","sessionExpired");
                    rd.forward(request,response);

                }
                if(type.equals("user") ){
                    RequestDispatcher rd= request.getRequestDispatcher("error.jsp");
                    request.setAttribute("error","invalidSession");
                    rd.forward(request,response);

                }
    
            %>

            <div class="form-container">
             
                <span class="error-container" id="error-container"></span>
                <form onsubmit="return validateDel()" action="delmed.jsp" method="Post" >
                    <label>Medicine Name:</label><br>
                    <input type="text" name="name" id="name"><br><br>
                    <label>Product ID:</label><br>
                    <input type="number" name="id" id="id"><br><br>
                    
                    <button  class="btn" type="submit" >DELETE</button>
        
                </form>    
           
            </div>
            

            <%
                String name= request.getParameter("name");
                String ID = request.getParameter("id");
                if(ID!=null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://127.0.0.1/pharma";
                    Connection con=DriverManager.getConnection(url,"root","root");
                    Statement st=con.createStatement();

                    String query="delete from medicine where product_id= '"+ID+"' and name = '"+name+"'";
                    int check = st.executeUpdate(query);

                    if(check==1){

            %>

                <span><h2 style="color:green;">Record Deleted</h2></span>
            <%
                    }    
                    else{                    
            %>
                <span><h2 style="color:red;">Error: query not executed! </h2></span>

            <%
                    }
                    st.close();
                    con.close();
                } // end try block
                catch(Exception e){ out.println(e); }
                out.close();
                }
            %>
        </div>
    </body>
</html>