<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
  String username=null;
  String lotid=null;
  int olde,newe,diff;
  lotid=(String)request.getSession(true).getAttribute("lotid");
  username=(String)request.getSession(true).getAttribute("username");
  olde=Integer.parseInt(String.valueOf(request.getSession(true).getAttribute("olde")));
  newe=Integer.parseInt(String.valueOf(request.getSession(true).getAttribute("newe")));
  
  try 
	{
		newe = parkinglot.User.DetectModify(lotid);
		request.getSession(true).setAttribute("newe",newe);
	} 
	catch (Exception e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  
    diff=olde-newe;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" id="welcome"></a>
    </div>
    <script>
      var cnt ="<%=username%>";      
      document.getElementById("welcome").innerHTML = cnt+",hello!";
    </script>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li id="home" class="active"><a  href="home.jsp">Home</a></li>
        <li id="account"><a href="UserInformation/UserInfo.jsp">Account Information</a></li>
        <li id="reserve"><a href="Reservation/Reservation.jsp">Reservation<span class="badge" id="reservation"></span></a></li>
      </ul>
      <script>       
        var diff="<%=diff%>";
        if(diff!=0)
        {
        	document.getElementById("reservation").innerHTML=diff;
        }
      </script>      
      <form action="Logout" method="get">
      <ul class="nav navbar-nav navbar-right">
        <li><button class="btn btn-primary" type="submit" name="send_button"><span class="glyphicon glyphicon-log-out")></span>Logout</button></li>
      </ul>
       </form>
    </div>
  </div>
</nav>
</html>