<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="../incoming/Common.jsp"%>
<%@ include file="../Check.jsp"%>

<%
  response.setHeader("refresh","30");
  String changename=(String)request.getSession().getAttribute("changename");
  session.setAttribute("changename", null);
  String changetotal=(String)request.getSession().getAttribute("changetotal");
  session.setAttribute("changetotal", null);
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
      <strong>Success!</strong>
    </div>
    
    <script>
      var changename="<%=changename%>";
      var changetotal="<%=changetotal%>";
      if(changename=="success"||changetotal=="success")
    	  document.getElementById("success").style.display="block";
    </script>
    
      <h1>Lot Information</h1>
      <hr>
      <p><strong>Lot Name : </strong><% out.print(request.getSession().getAttribute("lotname")); %><div><a type="button" class="btn btn-primary" href="ChangeName.jsp">Change Name</a></div></p>
      <p><strong>Location : </strong><% out.print(request.getSession().getAttribute("latitude")+","+request.getSession().getAttribute("longitude"));%></p>
      <p><strong>Open Time : </strong><% out.print(request.getSession().getAttribute("open")+"-"+request.getSession().getAttribute("close"));%></p>
      <p><strong>Total Number of Parking Spots : </strong><% out.print(request.getSession().getAttribute("total")); %><div><a type="button" class="btn btn-primary" href="ChangeTotal.jsp">Change Number</a></div></p>
    </div>
  </div>
</div>
<%@ include file="../Foot.jsp" %>
</body>
</html>