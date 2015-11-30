<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="../incoming/Common.jsp"%>
<%@ include file="../Check.jsp"%>

<%
  response.setHeader("refresh","60");
  String changepsw=null;
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
</head>
<body>
<%@ include file="../InNavbar.jsp" %>
<div class="container-fluid text-center">    
  <div class="row content">  
    <%@ include file="../InLeft.jsp" %>
    <div class="col-sm-10 text-left">
    
      <div class="alert alert-warning" id="fail">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Warning!</strong> Wrong Username or Password!
      </div>
    
      <form action="ChangePassword.jsp" method="get" role="form">
        <h2 class="form-loginin-heading">Change Password</h2>
         <hr>
         <div class="form-group">
        <label for="Username" class="sr-only">Username</label>
        <input type="text" name="username" class="form-control" placeholder="Username" required autofocus>
        </div>
        <div class="form-group">
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password"  name="password" class="form-control" placeholder="Password" required>
        </div>
         <div class="form-group">
        <label for="inputPassword" class="sr-only">NewPassword</label>
        <input type="password"  name="newpassword" class="form-control" placeholder="New Password" required>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="send_button">Change</button>
      </form>
      
    <% 
    String inusername=request.getParameter("username");
	String inpassword=request.getParameter("password");
	String newpassword=request.getParameter("newpassword");
	request.getSession(true);	
	try 
	{
		if(inusername.equals(null)||inpassword.equals(null)||newpassword.equals(null))
		{
			session.setAttribute("changepsw", null);
		}
		else if(parkinglot.User.ChkLogin(inusername, inpassword)!=null)
		{
			parkinglot.User.ModifyPassword(username, newpassword);
			session.setAttribute("changepsw", "success");
			response.sendRedirect("UserInfo.jsp");
		}
		else
			session.setAttribute("changepsw", "fail");
		changepsw=(String)session.getAttribute("changepsw");
	} 
	catch (Exception e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    %>
    <script>
      var changepsw="<%=changepsw%>";
      if(changepsw=="null")
      {
    	  document.getElementById("fail").style.display="none";
    	  document.getElementById("success").style.display="none";
      }
      else if(changepsw=="success")
      {
    	  document.getElementById("fail").style.display="none";
    	  document.getElementById("success").style.display="block";
    	  
      }
      else if(changepsw=="fail")
      {
    	  document.getElementById("fail").style.display="block";
    	  document.getElementById("success").style.display="none";
      }
    </script>
    </div>
  </div>
</div>
<%@ include file="../Foot.jsp" %>
</body>
</html>