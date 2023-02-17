<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>
    <head>
        <title>Cart</title>
        <link href="aPanel.css" rel="stylesheet">
        <link href="cart.css" rel="stylesheet">
    
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

        <div class="page-container">
            <div class="nav-bar">
                <ul>
                    <li><a href="userPanel.jsp">Home</a></li>
                    <li><a href="cart.jsp">Cart</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                    
                    <form class="searchbox" action="search.jsp">
                        <input type="text" placeholder="Search" name="search">
                        <button type="submit">Search</button>
                    </form>
                </ul>
                
            </div>
            
            
            <div class="cart">
                    <h2>Your Cart</h2>

            <%
                String user = (String)session.getAttribute("name");
                
                if(user!=null){
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://127.0.0.1/pharma";
                    Connection con=DriverManager.getConnection(url,"root","root");
                    Statement st=con.createStatement();

                    String query= "select * from cart where username='"+user+"'";
                    ResultSet rs = st.executeQuery(query);

                    int total = 0;
                    while(rs.next()){
                        int subtotal=0;
                        int id= rs.getInt("product_id");
                        int inCart= rs.getInt("quantity");
                        String med_name="";
                        int med_price=0;

                        Statement st2 = con.createStatement();
                        String q1= "select * from medicine where product_id='"+id+"'";
                        ResultSet rs2 = st2.executeQuery(q1);

                        if(rs2.next()){
                            med_name = rs2.getString("name");
                            med_price= rs2.getInt("price");
                        }

                        st2.close();
                        subtotal = inCart*med_price;
                        total = total + subtotal;
                        

            %>
                    <p>Item: <%= med_name %><br>
                        Quantity: <%= inCart %><br> 
                       Price: Rs.<%= subtotal %>     
                       <form action="remove.jsp" method="Post">
                        <input type="hidden" name="prodId" value="<%= id %>"/>
                        <input  type="submit" name="submit" class="remove" value="Remove item"/>
                      </form>
                    </p>

            <%
                    }// end while
           
            %>
        
             <h3>Total Amount: Rs.<%= total %></h3>
             
             
             <form action="checkout.jsp" method="Post">
                 <input type="hidden" name="userId" value="<%= user %>"/>
                 <input class="btn" type="submit" name="submit" value="CHECKOUT"/>
             </form>
             <button class="btn" ><a href="userPanel.jsp" style="color:white; text-decoration: none;">Continue Shopping</a></button>
            <%
                st.close();
                con.close();
                }// end try block
                catch(Exception e){out.println(e);}
                out.close();
              
                }// end outer if
            %>
              
        
            </div>
    

        </div>
    </body>
</html>