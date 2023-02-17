<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 

<html>
    <head>
        <title>Search</title>
    </head>
    
    <style>
        .page-container{
            display:flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
    </style>

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

            String search = request.getParameter("search"); // can be product id or name

            if(search!=null){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://127.0.0.1/pharma";
                Connection con=DriverManager.getConnection(url,"root","root");
                Statement st=con.createStatement();

                String query= "select * from medicine where name='"+search+"' or product_id = '"+search+"'";
                ResultSet rs= st.executeQuery(query);
                
                if(rs.next()){

                    String name = rs.getString("name");
                    int id = rs.getInt("product_id");
                    int quantity= rs.getInt("quantity");
                    int price = rs.getInt("price");
                
                    if(quantity>0){
            

        %>
                        <div class="card">
                            <h2><%= name %></h2>
                            <p>
                                Price: Rs. <%= price %> <br/>
                                Availablity: Available <br/>
                            </p>

                            <form action="addToCart.jsp" method="Post">
                                <input type="hidden" name="addCart" value="<%= id %>"/>
                                <input type="submit"name="submit" value="Add To Cart">
                            </form>

                           
                        </div>
        <%
                    } //iner if
                    else{

                    
        %>
                        <div class="card">
                            <h2><%= name %></h2>
                            <p>
                                Price: Rs. <%= price %> <br/>
                                Availablity: Not Available <br/>
                            </p>
                        </div>

        <%
                    }// inner else
                }// outer if

                else{
        %>
        <span><h2 style="color:red;">No medicine found!</h2></span>

        <%
                }// outer else
                st.close();
                con.close();
            }// end try block
            catch(Exception e){ out.println(e);}
            out.close();
        }
        %>
    </body>
</html>