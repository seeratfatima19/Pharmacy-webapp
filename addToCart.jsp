<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 



<html>
    <head>
        <title>Cart</title>
    </head>

    <body>
      <%
              
        String type = (String)session.getAttribute("type");

        if(type==null){
            RequestDispatcher rd= request.getRequestDispatcher("error.jsp");
            request.setAttribute("error","sessionExpired");
            rd.forward(request,response);


        }

        String prodId= request.getParameter("addCart");
        String user = (String)session.getAttribute("name");
        

        if(prodId!=null){
            try{
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://127.0.0.1/pharma";
                Connection con=DriverManager.getConnection(url,"root","root");
                Statement st=con.createStatement();

                String query= "select * from cart where username='"+user+"' and product_id = '"+prodId+"'";
                ResultSet rs= st.executeQuery(query);
                int quan=0;
                int result=0;

                if(rs.next()){
                    quan = rs.getInt("quantity");
                    quan= quan+1;
                    String q2= "update cart set quantity='"+quan+"' where username='"+user+"' and product_id = '"+prodId+"'";
                    result =st.executeUpdate(q2);

                }

                else{
                   quan =1;
                   String q3= "insert into cart(username, product_id, quantity) values('"+user+"','"+prodId+"','"+quan+"')";
                   result =st.executeUpdate(q3);

                }

                
                if(result==1){

        %>
                 <span><h2 style="color:green;">Item Added to Cart!</h2></span>

        <%
                }//end if

                else{

        %>
                <span><h2 style="color:red;">Can't add to cart!</h2></span>

        <%
                }// end else
                st.close();
                con.close();
            }// end try block
            catch(Exception e){out.println(e);}
            out.close();
        }// outer if
        %>

    </body>
</html>