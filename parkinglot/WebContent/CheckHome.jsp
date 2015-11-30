<%
  if((String)session.getAttribute("IsLogin")!="success")
   {
     String loginmsg="loginfirst";
     response.sendRedirect("login.jsp?loginmsg="+loginmsg);
   }
%>
