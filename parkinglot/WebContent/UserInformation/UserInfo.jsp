<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="../incoming/Common.jsp"%>
<%@ include file="../Check.jsp"%>

<%
  response.setHeader("refresh","30");
  String changepsw=(String)request.getSession().getAttribute("changepsw");
  session.setAttribute("changepsw", null);
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
    
    <div class="alert alert-success" id="success" style="display:none">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
      <strong>Success!</strong> The new password is set successfully!
    </div>
    
    <script>
      var changepsw="<%=changepsw%>";
      if(changepsw=="success")
      {
    	  document.getElementById("success").style.display="block";
      }
    </script>
    
      <h1>UserInfo</h1>
      <hr>
      <p><strong>Username : </strong><% out.print(username); %><div><a type="button" class="btn btn-primary" href="ChangePassword.jsp">Change Password</a></div></p>
      <p><strong>Parking lot name : </strong><% out.print(request.getSession().getAttribute("lotname"));%></p>
      <p><strong>Number of present reservation : </strong>
      <%
        try 
  	    {
  		    out.println(parkinglot.User.GetReserve((String)request.getSession().getAttribute("lotid")));
  	    } 
  	    catch (Exception e) 
  	    {
  	    	// TODO Auto-generated catch block
  		    e.printStackTrace();
  	    }
      %>
      </p>
      <a href="../History/History.jsp"><strong>Income : </strong></a> 
        <p><a href="../History/Daily.jsp">Daily : </a>
        <%
        try 
  	    {
  		    out.println(parkinglot.User.GetIncome((String)request.getSession().getAttribute("lotid"),"d"));
  	    } 
  	    catch (Exception e) 
  	    {
  	    	// TODO Auto-generated catch block
  		    e.printStackTrace();
  	    }
        %>
        </p>
        <p><a href="../History/Monthly.jsp">Monthly : </a>
        <%
        try 
  	    {
  		    out.println(parkinglot.User.GetIncome((String)request.getSession().getAttribute("lotid"),"m"));
  	    } 
  	    catch (Exception e) 
  	    {
  	    	// TODO Auto-generated catch block
  		    e.printStackTrace();
  	    }
        %>
        </p>
        <p><a href="../History/Yearly.jsp">Yearly : </a>
        <%
        try 
  	    {
  		    out.println(parkinglot.User.GetIncome((String)request.getSession().getAttribute("lotid"),"y"));
  	    } 
  	    catch (Exception e) 
  	    {
  	    	// TODO Auto-generated catch block
  		    e.printStackTrace();
  	    }
        %>
        </p>
    </div>
  </div>
</div>
<%@ include file="../Foot.jsp" %>
</body>
</html>