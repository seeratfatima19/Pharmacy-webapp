
<%

        response.setHeader("Cache-control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        session.setAttribute("type",null);
        session.removeAttribute("type");
        session.invalidate();
        response.sendRedirect("login.html");      
        


%>

