package parkinglot;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.Table;

public class User {
	public String UserName, Password;

	public User()
	{
	};
  
	public String getUserName() 
	{
		return UserName;
	}

	public void setUserName(String s) 
	{
		this.UserName = s;
	}

	public String getPassword() 
	{
		return Password;
	}

	public void setPassword(String s)
	{
		this.Password = s;
	}

	/*
	 * Check Login
	 */
	public static String ChkLogin(String _UserName, String _Password)
			throws Exception 
	{
		String tablename = "LotManager";
		String lotid=null;
		
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		
		try 
		{
			Table table = dynamoDB.getTable(tablename);
			Item item= table.getItem("username",_UserName);
			if(item.get("password").equals(_Password))
			{
				lotid=item.get("LotId").toString();
			}
		} 
		catch (Exception e)
		{
			System.err.println(e);
		}
		
		return lotid;
	}
	
	/*
	 * Modify Password
	 */

	public static String ModifyPassword(String _UserName, String _NewPassword) 
	{
		String tablename = "LotManager";
		
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		
		try 
		{
			Table table = dynamoDB.getTable(tablename);
			table.updateItem("username", _NewPassword);
			return "1";

		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return e.toString();
		}
	}
	
	public static int DetectModify(String _LotId)
	{
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		Table table = dynamoDB.getTable("ParkingInfo");
		Item item=table.getItem("Parkurself","parkurself","Id",_LotId);
		return item.getInt("AvailableSpots");
	}
	
	public static ResultSet GetReserve(String lotid)
	{
		ResultSet resv=null;
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/parkurself";
			String user = "root";
			String password = "monster";
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "SELECT COUNT(*) FROM reservation"; 
			Statement st = conn.createStatement();
			resv=st.executeQuery(sql);
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resv;
	}
}
