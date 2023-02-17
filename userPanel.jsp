<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>
    <head>
        <title>User Dashboard</title>
        <link href="aPanel.css" rel="stylesheet">

        <style>

            .nav-bar{
                display:block;
                overflow:hidden;
            }

            .searchbox{
                float: right;
                padding: 6px;
                margin-top: 8px;
                margin-right: 16px;
                border: none;
                font-size: 17px;
            }

            input[type=text]{
                
                border-style: none;
            }

        </style>
    </head>

    <body>
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

                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://127.0.0.1/pharma";
                    Connection con=DriverManager.getConnection(url,"root","root");
                    Statement st=con.createStatement();
    
                    String query= "select * from medicine";
                    ResultSet rs= st.executeQuery(query);

            %>
            
            <div class="table-container">
                 <h2>Medicines list</h2>
                              
                <table>
                    <tr>
                    <th>Name</th>
                    <th>Price (Rs.)</th>
                    <th>Availability</th>
                    <th>Add to Cart</th>
                    </tr>
           
                    <%
                    while(rs.next()){
                        String name= rs.getString("name");
                        int id = rs.getInt("product_id");
                        int quantity = rs.getInt("quantity");
                        int price = rs.getInt("price");
                        String available;

                        if(quantity>0){
                    %>
        
                    
                            <tr>
                                <td> <%= name %> </td>
                                <td> <%= price %> </td>
                                <td style="color:green;"> Available</td>
                                <td><form action="addToCart.jsp" method="Post">
                                    <input type="hidden" name="addCart" value="<%= id %>"/>
                                    <input type="submit"name="submit" value="Add To Cart">
                                    
                                    <a href="addToCart.jsp?addCart=<%= id %>">Add to cart</a>
                                </form></td>
                            </tr>
                            
                    <%
                        }
                        else{

                    %>
                    <tr>
                        <td> <%= name %> </td>
                        <td> <%= price %> </td>
                        <td style="color:red;">Not Available</td>
            
                    </tr>
                    <%
                            }
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