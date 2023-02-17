<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %> 


<%

String type = (String)session.getAttribute("type");

if(type==null){
    RequestDispatcher rd= request.getRequestDispatcher("error.jsp");
    request.setAttribute("error","sessionExpired");
    rd.forward(request,response);

}

String user = (String)session.getAttribute("name");
String prodId = request.getParameter("prodId");

if(user!=null){


    try{
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://127.0.0.1/pharma";
        Connection con=DriverManager.getConnection(url,"root","root");
        Statement st=con.createStatement();

        String query = "select * from cart where username = '"+user+"' and product_id='"+prodId+"'";
        ResultSet rs= st.executeQuery(query);

        if(rs.next()){
            String q2 = "delete from cart where product_id='"+prodId+"'";
            int result = st.executeUpdate(q2);

            if(result==1){            
        
%>
    <span><h3 style="color:green;">Removed from cart!</h3></span>
<%
            }// inner if
            else{

            
%>
<span><h3 style="color:red;">Can't remove item!</h3></span>
<%
            }// inner else

        }// if
        st.close();
        con.close();
    }// end try block
    catch(Exception e){out.println(e);}
    out.close();
}// outer if
%>