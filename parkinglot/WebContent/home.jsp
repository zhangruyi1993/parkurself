<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="incoming/Common.jsp"%>
<%@ include file="CheckHome.jsp"%>

<%
  response.setHeader("refresh","30");
  int total;
  String wronginfo=null;
  int wrongnum;
  total=Integer.parseInt(String.valueOf(request.getSession(true).getAttribute("total")));
  wronginfo=(String)request.getSession(true).getAttribute("wronginfo");
  wrongnum=Integer.parseInt(String.valueOf(request.getSession(true).getAttribute("wrongnum")));
  
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
<%@ include file="Navbar.jsp" %>
<div class="container-fluid text-center">    
  <div class="row content">  
    <%@ include file="Left.jsp" %>
    <div class="col-sm-10 text-left">
      <div class="alert alert-warning" id="nospot">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Warning!</strong> No Spots Available!
      </div>
       
      <div class="alert alert-warning" id="wrongnum">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Warning!</strong><span id="wronginfo"></span>
      </div>
       
      <h1 align="center">Welcome</h1>
      
      <form action="ChangeEmpty" method="get" role="form">
        <p align="center">
        <span id="total" ></span><span id="empty" ></span>
        </p>
        
        <p align="center">
        <label for="carsin">Cars In</label>
        <input type="text"  id="carsin" name="carsin" value=0 autofocus>
        or
        <label for="carsout">Cars Out</label>
        <input type="text"  id="carsout" name="carsout" value=0>
        </p>
        <p align="center">
        <button class="btn btn-lg btn-primary" type="submit" name="submit_button" >Submit</button>      
        </p>
      </form>
      
      <script type="text/javascript">
        var total="<%=total%>";
        var newe="<%=newe%>";
        var bound;
        var wronginfo="<%=wronginfo%>";
        var wrongnum="<%=wrongnum%>";
        document.getElementById("total").innerHTML="Total Spots:"+total+" ; ";
        document.getElementById("empty").innerHTML="Empty Spots:"+newe;
        if(newe>=0)
        	document.getElementById("nospot").style.display="none";
        else
        	document.getElementById("nospot").style.display="block";
        if(wronginfo=="minus")
        {
        	document.getElementById("wronginfo").innerHTML="The parking lot is empty and no cars can go out!";
        	document.getElementById("wrongnum").style.display="block";
        }
        else if(wronginfo=="exceed")
        {
        	document.getElementById("wronginfo").innerHTML= wrongnum+" cars can't go in the parking lot.";
        	document.getElementById("wrongnum").style.display="block";
        }
        else
        	document.getElementById("wrongnum").style.display="none";
      </script>
      
    </div>
  </div>
</div>
<%@ include file="Foot.jsp" %>
</body>
</html>