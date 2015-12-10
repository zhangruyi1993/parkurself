<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<%@ include file="incoming/Common.jsp"%>

<%
   if(request.getParameter("send_button")!=null)
   {
      request.getSession().invalidate();
   }
%>
   
<%
  String IsLogin=null; 
  String loginmsg = request.getParameter("loginmsg");
  IsLogin=(String)request.getSession(true).getAttribute("IsLogin");
  if(IsLogin=="success")
	  response.sendRedirect("home.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utsf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Parkurself : Parking Lot Managing System</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">
    
    
    
  </head>
  
  <body>
    <div class="container">
      <div class="alert alert-warning" id="warning">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Warning!</strong> Wrong Username or Password!
      </div>
      
      <script type="text/javascript">
      var a = "<%=IsLogin%>";
      if(a=="fail")    	  
    	  document.getElementById("warning").style.display="block";
      else
    	  document.getElementById("warning").style.display="none";
      
      </script>
          
      <form action="CheckLogin" method="get" class="form-loginin">
        <h2 class="form-loginin-heading">Manager Login</h2>
        <label for="Username" class="sr-only">Username</label>
        <input type="text" name="username" class="form-control" placeholder="Username" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password"  name="password" class="form-control" placeholder="Password" required>
        <div class="checkbox">
          <label> 
            <input type="checkbox" name="remember-me" value="remember"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="send_button" >Login in</button>
      </form>
  </div>
</div>
     
    
    

   <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
  </body>
</html>