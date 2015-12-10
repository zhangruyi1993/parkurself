package parkinglot;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.Table;


/**
 * Servlet implementation class CheckLogin
 */
@SuppressWarnings("serial")
public class CheckLogin extends HttpServlet {
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @return 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String remember = request.getParameter("remember-me");
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(0);
		String lotid=null;
		try 
		{
			lotid = User.ChkLogin(username, password);
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (lotid!=null) {
			session.setAttribute("username",username);
			session.setAttribute("password", password);
			session.setAttribute("lotid", lotid);
			session.setAttribute("IsLogin", "success");
			
			if(remember!=null){
				Cookie cookie = new Cookie("username", username);
				cookie.setMaxAge(90*24*60*60);
			}
			
			//load the spot info
			String tablename = "ParkingInfo";
			DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
			Table table= dynamoDB.getTable(tablename);
			Item item=table.getItem("Parkurself","parkurself","Id", lotid);
			session.setAttribute("total",item.get("Total"));
			session.setAttribute("olde",item.get("AvailableSpots"));
			session.setAttribute("newe",item.get("AvailableSpots"));
			session.setAttribute("wronginfo","");
			session.setAttribute("wrongnum",0);
			session.setAttribute("lotname", item.get("ParkingName"));
			session.setAttribute("longitude", item.get("Longitude"));
			session.setAttribute("latitude", item.get("Latitude"));
			session.setAttribute("open", item.get("OpeningTime"));
			session.setAttribute("close", item.get("ClosingTime"));
			session.setAttribute("price", item.get("Price"));
			session.setAttribute("changepsw", null);
			session.setAttribute("changename", null);
			session.setAttribute("changetotal", null);
			response.sendRedirect("home.jsp");
		}
		else
		{
			session.setAttribute("IsLogin", "fail");
			response.sendRedirect("login.jsp");
		}
	}

}
