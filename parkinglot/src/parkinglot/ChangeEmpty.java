package parkinglot;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.Table;

/**
 * Servlet implementation class ChangeEmpty
 */
@SuppressWarnings("serial")
public class ChangeEmpty extends HttpServlet {
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int change,empty;
		String tablename = "ParkingInfo";
		
		HttpSession session=request.getSession();
		String LotId=(String) session.getAttribute("lotid");
		session.setAttribute("wronginfo", null);
		
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		Table table= dynamoDB.getTable(tablename);
		Item item=table.getItem("Parkurself","parkurself","Id",LotId);
		int newe=item.getInt("AvailableSpots");
		
		
		change=Integer.parseInt(request.getParameter("carsin"));
		empty=newe-change;
		item.withInt("AvailableSpots", empty);
		table.deleteItem("Parkurself","parkurself","Id",LotId);
		table.putItem(item);
		newe=item.getInt("AvailableSpots");

		change=Integer.parseInt(request.getParameter("carsout"));
		empty=newe+change;
		item.withInt("AvailableSpots", empty);
		table.deleteItem("Parkurself","parkurself","Id",LotId);
		table.putItem(item);
		newe=item.getInt("AvailableSpots");

		if(item.getInt("AvailableSpots")>item.getInt("Total"))
		{
			item.withInt("AvailableSpots", item.getInt("Total"));
			table.deleteItem("Parkurself","parkurself","Id",LotId);
			table.putItem(item);
			session.setAttribute("wronginfo", "minus");
		}
		else if(item.getInt("AvailableSpots")<0)
		{
			int wrongnum=0-item.getInt("AvailableSpots");
			item.withInt("AvailableSpots", 0);
			table.deleteItem("Parkurself","parkurself","Id",LotId);
			table.putItem(item);
			session.setAttribute("wronginfo", "exceed");
			session.setAttribute("wrongnum", wrongnum);
		}
		session.setAttribute("olde",item.get("AvailableSpots"));
		session.setAttribute("newe",item.get("AvailableSpots"));
		response.sendRedirect("home.jsp");
	}

}
