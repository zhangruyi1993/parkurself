<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="../incoming/Common.jsp"%>
<%@ include file="../Check.jsp"%>

<%
  response.setHeader("refresh","30");
  int temp=Integer.parseInt(String.valueOf(request.getSession(true).getAttribute("newe")));
  request.getSession(true).setAttribute("olde",temp);
  String res;
  res=parkinglot.User.GetResv((String)request.getSession().getAttribute("lotid"));
  String[] resv=res.split(" ");
  int tota=resv.length;
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
<%@ include file="../InNavbar.jsp"%>
<div class="container-fluid text-center">    
  <div class="row content">  
    <%@ include file="../InLeft.jsp" %>
    <div class="col-sm-10 text-left">
    <h1>Reservation</h1>
      <div>
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Username</th>
              <th>Car Number</th>
              <th>Phone Number</th>
              <th>Price</th>
              <th>Start Time</th>
              <th>Abort Time</th>
            </tr>
          </thead>
          <tbody id="tBody">
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script>
      var res="<%=res%>";
      var resv=res.split(" ");
      var tot="<%=tota%>";
      var con="";
      var i=0;
      
      while(i<tot-7)
      {
    	  con+="<tr><td>"+resv[i]+"</td><td>"+resv[i+1]+
  	    "</td><td>"+resv[i+2]+"</td><td>"+resv[i+3]+"</td><td>"+resv[i+4]+
	    "</td><td>"+resv[i+5]+"</td></tr>";
    	  i=i+6;
      }
      document.getElementById("tBody").innerHTML=con;
    </script>
<%@ include file="../Foot.jsp" %>
</body>
</html>