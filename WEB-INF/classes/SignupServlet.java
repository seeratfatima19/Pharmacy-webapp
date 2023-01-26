import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;

public class SignupServlet extends HttpServlet{


	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String f_name = request.getParameter("First Name");
			String l_name = request.getParameter("Last Name");
			String usr_name = request.getParameter("Username");
			String email = request.getParameter("Email");
			String passwd = request.getParameter("Password");
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://127.0.0.1/pharma";
			Connection con=DriverManager.getConnection(url,"root","root");
			Statement st=con.createStatement();
			
			String query = "select * from usr_records where username='"+usr_name+"'";
			ResultSet rs= st.executeQuery(query);
			
			if(rs.next()){
				out.println("<html><head></head><body><h2>This username already exists!</h2></body></html>");
			}
			else {
				query = "insert into usr_records(username, passwd, fname, lname, email) values('"+usr_name+"', '"+passwd+"', '"+f_name+"', '"+l_name+"', '"+email+"')";
				st.executeUpdate(query);
				out.println("<html><head></head><body><h2>Signup successful</h2></body></html>");
			}
			

			st.close();
			con.close();
		}
		catch(Exception e){
			out.println(e);
		}
		
		out.close();
	}

} //end class