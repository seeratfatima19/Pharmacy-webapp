<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 


<html>
    <head>
        <title>Update Medicine Records</title>

        <style>
            .page-container{
                display: flex;
                flex-direction: column;
            }
        </style>

        <script>
            function validateUpdate(){
                var price = document.getElementById("price").value;
                var id = document.getElementById("id").value;
                var quantity = document.getElementById("quan").value;
                
                if(id==""){   
                document.getElementById('error-container').innerHTML= "Enter Id";
                 return false;
                }

                if(price==""){   
                document.getElementById('error-container').innerHTML= "Enter price";
                 return false;  
                 }

                 if(quantity==""){
                    document.getElementById('error-container').innerHTML= "Enter quantity";
                     return false;  
                    
                 }

  
            }
        </script>
    </head>

    <body>
        <div class="page-container">
            <h2>Update Medicine Record</h2>

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
                <form action="updatemed.jsp" method="Post" onsubmit="validateUpdate()">
                    
                    <label>Product ID:</label><br>
                    <input type="number" name="id" id="id"><br><br>
                    <label>Price:</label><br>
                    <input type="number" name="price" id="price"><br><br>
                    <label>Quantity:</label><br>
                    <input type="number" name="quantity" id="quan"><br><br>
                    
                    <button  class="btn" type="submit" >UPDATE</button>
        
                </form>    
           
            </div>

            <%
                String price= request.getParameter("price");
                String ID = request.getParameter("id");
                String quantity = request.getParameter("quantity");

                if(ID!=null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://127.0.0.1/pharma";
                    Connection con=DriverManager.getConnection(url,"root","root");
                    Statement st=con.createStatement();

                    String query="update medicine set price='"+price+"', quantity= '"+quantity+"'where product_id= '"+ID+"'";
                    int check = st.executeUpdate(query);

                    if(check==1){

                    

            %>
                <span><h2 style="color:green;">Record Updated</h2></span>

            <%
                    }
                    else{

                    
            %>
                <span><h2 style="color:red;">Couldn't update record!</h2></span>
            
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