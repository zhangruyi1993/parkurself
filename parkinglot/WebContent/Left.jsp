<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">   
    <div class="col-sm-2 sidenav">
    <p>
      <a data-toggle="collapse" href="#collapse1">Account Information</a>
      <div id="collapse1" class="panel-collapse collapse">
        <ul class="list-group">
          <li class="list-group-item"><a href="UserInformation/UserInfo.jsp">User Information</a></li>
          <li class="list-group-item"><a href="UserInformation/ChangePassword.jsp">Change Password</a></li>
        </ul>
        </div>
      </p>
      <p>
        <a data-toggle="collapse" href="#collapse2">Parking Lot Information</a>
        <div id="collapse2" class="panel-collapse collapse">
        <ul class="list-group">
          <li class="list-group-item"><a href="ParkingLot/LotInfo.jsp">Lot Information</a></li>
          <li class="list-group-item"><a href="ParkingLot/ChangeName.jsp">Change Name</a></li>
          <li class="list-group-item"><a href="ParkingLot/ChangeTotal.jsp">Change Total</a></li>
        </ul>
        </div>
      </p>
      <p><a href="Reservation/Reservation.jsp">Reservation Information</a></p>
      <p><a href="Charging/Charging.jsp">Charging Information</a></p>
      <p>
        <a data-toggle="collapse" href="#collapse3">History Information</a>
        <div id="collapse3" class="panel-collapse collapse">
        <ul class="list-group">
          <li class="list-group-item"><a href="History/History.jsp">Order History</a></li>
          <li class="list-group-item"><a href="History/Daily.jsp">Daily Income</a></li>
          <li class="list-group-item"><a href="History/Monthly.jsp">Monthly Income</a></li>
          <li class="list-group-item"><a href="History/Yearly.jsp">Yearly Income</a></li>
        </ul>
        </div>
      </p>
    </div>
</html>