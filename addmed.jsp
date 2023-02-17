<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>

    <head>
        <title>Add Medicine</title>
        <link href="style.css" rel="stylesheet">

        <script>
            function validateAdd(){
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

             
             if(price==""){
                document.getElementById('error-container').innerHTML= "Enter Price";
                 return false;
             }

             
             if(quan==""){
                document.getElementById('error-container').innerHTML= "Enter Product quantity";
                 return false;
             }

            }
        </script>
        <style>
            .page-container, .form-container{
                display: flex;
                flex-direction: column;
            }
        </style>

    </head>

    <body>
        <div class="page-container">

            <h2>Add Medicine Record</h2>

            <%
                
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

            <div id="container1" class="form-container">
             
                <span class="error-container" id="error-container"></span>
                <form action="addmed.jsp" method="Post" onsubmit="return validateAdd()">
                    <label>Medicine Name:</label><br>
                    <input type="text" name="name" id="name"><br><br>
                    <label>Product ID:</label><br>
                    <input type="number" name="id" id="id"><br><br>
                    <label>Price:</label><br>
                    <input type="number" name="price" id="price"><br><br>
                    <label>Quantity:</label><br>
                    <input type="number" name="quantity" id="quan"><br><br>

                    <button  class="btn" type="submit" >ADD</button>
        
                </form>    
           
            </div>

            <%
                
                String name= request.getParameter("name");
                String ID = request.getParameter("id");
                String price = request.getParameter("price");
                String quantity = request.getParameter("quantity");
                
                if(ID!=null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://127.0.0.1/pharma";
                    Connection con=DriverManager.getConnection(url,"root","root");
                    Statement st=con.createStatement();

                    String query= "insert into medicine(product_id, name, quantity, price) values('"+ID+"', '"+name+"', '"+quantity+"', '"+price+"')";
                    int check = st.executeUpdate(query);
                    if(check==1){

                    
            %>
                <span><h2 style="color:green;">Data Entry Successful!</h2></span>
            <%
                    }
                    else{

                    
            %>
            <span><h2 style="color:red;">Error entering data</h2></span>

            <%
                    }
                st.close();
                con.close();
                }//end try block
                catch(Exception e){
                    out.println(e);
                }

                out.close();
                }

            %>



        </div>
    </body>
</html>