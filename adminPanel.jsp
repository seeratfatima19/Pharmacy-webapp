<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>
    <head>
        <title>Admin Panel</title>
        <link href="aPanel.css" rel="stylesheet">
    
    </head>

    <body>
       
        <div class="page-container">
            
            <div class="nav-bar">
                <ul>
                    <li><a href="addmed.jsp">Add Medicine</a></li>
                    <li><a href="delmed.jsp">Delete Medicine</a></li>
                    <li><a href="updatemed.jsp">Update Medicine</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                  </ul>
            </div>

            <h2>Admin Dashboard</h2>
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

          
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://127.0.0.1/pharma";
                Connection con=DriverManager.getConnection(url,"root","root");
                Statement st=con.createStatement();

                String query= "select * from medicine";
                ResultSet rs= st.executeQuery(query);

            %>
            <div class="table-container">
                <table>
                    <tr>
                    <th>Product ID</th>
                    <th>Name</th>
                    <th>Price (Rs.)</th>
                    <th>Quantity</th>
                    </tr>
                    

            <%
            while(rs.next()){
                String name= rs.getString("name");
                int id = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                
            %>

            
                    <tr>
                        <td> <%= id %> </td>
                        <td> <%= name %> </td>
                        <td> <%= price %> </td>
                        <td> <%= quantity %> </td>
                    
                    </tr>
                    
            <%
                
                }// end while
            %>
                </table>
                  
            </div>

            <%
                st.close();
                con.close();
                }//end try
                catch(Exception e){ out.println(e);}
                out.close();
            %>
            
          
            
        </div>
     

    </body>
</html>