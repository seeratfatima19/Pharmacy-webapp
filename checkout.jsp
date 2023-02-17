<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>
    <head>
        <title>Checkout</title>
        <link href="style.css" rel="stylesheet">
        <link href="signup.css" rel="stylesheet">
        <link href="aPanel.css" rel="stylesheet">

        <script src="checkoutValid.js"></script>
   
    </head>

    <body>
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

        %>
        <div class="page-container" style="background-color: #e9e9e9; background-image: none;">
            
            <div class="form-container">
                <h2>Checkout</h2>
                <span class="error-container" id="error-container"></span>
                <form action="checkout.jsp" method="post" onsubmit="return validate()">
                <div class="row-1">
                    <span class="col-1">
                    <label>Name:</label><br> 
                    <input type="text" name="Name" id="name"><br><br>
                    </span>

                    <span class="col-2">
                    <label>Contact:</label><br>
                    <input type="text" name="contact" id="contact" onkeypress="return contactCheck(event)"><br><br>
                    </span>
                </div>

                <div class="row-2">
                    <span class="col-1">
                    <label>Adress:</label><br>
                    <input type="text" name="address" id="address"><br><br>
                    </span>

                    <span class="col-2">
                    <label>Email:</label><br>
                    <input type="email" name="Email" id="mail"><br><br>
                    </span>
                </div>
            
                <input class="btn" type="submit" value="Place Order"/>
            </form>
            </div>

            <%
            
                String name=request.getParameter("Name");
              String username=(String)session.getAttribute("name");
              
            if(name!=null){

                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://127.0.0.1/pharma";
                    Connection con=DriverManager.getConnection(url,"root","root");
                    Statement st=con.createStatement();
                    Statement st2 =con.createStatement();

                    String query="Select * from cart where username='"+username+"' ";
                    ResultSet rs= st.executeQuery(query);

                    while(rs.next()){
                        int c_id = rs.getInt("product_id");
                        int c_quantity = rs.getInt("quantity");

                        String q2 = "select * from medicine where product_id='"+c_id+"'";
                        ResultSet rs1 = st2.executeQuery(q2);

                        if(rs1.next()){
                            int quan = rs1.getInt("quantity");
                            quan = quan - c_quantity;

                            String q3="update medicine set quantity ='"+quan+"' where product_id='"+c_id+"'";
                            st2.executeUpdate(q3);
                        }
                    }
                    String q4 = "delete from cart where username='"+username+"'";
                    int result=   st2.executeUpdate(q4);
                    if(result>0){
            %>
                        <span><h2 style="color:green;">Order placed</h2></span>
            <%
                    }
                    else{
            %>
                        <span><h2 style="color:red;">Couldn't place Order</h2></span>
           
            <%
                    }
                    
                    st.close();
                    st2.close();
                    con.close();
                }//try
                catch(Exception e){out.println(e);}
                out.close();
            }//outer if
            %>

        </div>
    </body>

</html>