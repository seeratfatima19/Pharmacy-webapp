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
				HttpSession session= request.getSession(true);
				
				String pass= rs.getString("passwd");
				String type= rs.getString("user_type");
				
				if(pass.equals(passwd)){
					
					session.setAttribute("name",usr_name);
					session.setAttribute("passwd",pass);
					session.setAttribute("type",type);
					
					if(type.equals("user"))
					{
						RequestDispatcher rd= request.getRequestDispatcher("userPanel.jsp");
						rd.forward(request,response);
					}
					
					if(type.equals("admin"))
					{
						RequestDispatcher rd= request.getRequestDispatcher("adminPanel.jsp");
						rd.forward(request,response);
					}
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
		
		
		public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		
			response.sendRedirect("error.jsp");
		
		}
}// end class
	
	