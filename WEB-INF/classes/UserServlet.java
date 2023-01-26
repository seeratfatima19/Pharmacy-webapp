import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;


public class UserServlet extends HttpServlet{


	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String usr_name = request.getParameter("Username");
			String passwd = request.getParameter("Password");
			
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://127.0.0.1/pharma";
			Connection con=DriverManager.getConnection(url,"root","root");
			Statement st=con.createStatement();
			
			
			String query = "Select * from usr_records where username= '"+usr_name+"' ";
			ResultSet rs= st.executeQuery(query);
		
			if(rs.next()){
				
				String pass= rs.getString("passwd");
		
				if(pass.equals(passwd)){
					out.println("<html><head></head><body><h2>Login Successful</h2></body></html>");
				}
		
				else{
					out.println("<html><head></head><body><h2>Wrong Password entered</h2></body></html>");
				}
			}
			
			else{
				out.println("<html><head></head><body><h2>Record Doesn't exist</h2></body></html>");
				
			}
			
			
			st.close();
			con.close();
		}
		
		catch(Exception e){
			out.println(e);
		}
		
		
			out.close();
	}// end do Post
	
}// end class
	
	