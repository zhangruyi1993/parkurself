package parkinglot;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;  

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

	public static void ModifyPassword(String _UserName, String _NewPassword) 
	{
		String tablename = "LotManager";
		
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		
		try 
		{
			Table table = dynamoDB.getTable(tablename);
			Item item=table.getItem("username",_UserName);
			item.withString("password", _NewPassword);
			table.deleteItem("username",_UserName);
			table.putItem(item);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	public static int DetectModify(String _LotId)
	{
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		Table table = dynamoDB.getTable("ParkingInfo");
		Item item=table.getItem("Parkurself","parkurself","Id",_LotId);
		return item.getInt("AvailableSpots");
	}
	
	public static int GetReserve(String lotid)
	{
		ResultSet resv=null;
		int resvv=0;
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://54.152.199.0:3306/Parking1";
			String user = "root";
			String password = "monster";
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "SELECT COUNT(*) FROM Reservation WHERE Type=0"; 
			Statement st = conn.createStatement();
			resv=st.executeQuery(sql);
			if (resv.first())
			resvv=resv.getInt(1);
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return resvv;
	}
	
	public static int GetIncome(String lotid,String type)
	{
		ResultSet inc=null;
		int incc=0;
		Date d = new Date();
		String Start="0000-00-00";
		String End="0000-00-00";
		if(type.equals("d"))
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Start=sdf.format(d);
			Calendar cal = Calendar.getInstance();
			cal.setTime(d);
			cal.add(Calendar.DATE, 1);
			End=sdf.format(d);
		}
		else if(type.equals("m"))
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			Start=sdf.format(d)+"-01";
			End=sdf.format(d)+"-31";
		}
		else if(type.equals("y"))
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			Start=sdf.format(d)+"-01-01";
			End=sdf.format(d)+"-12-31";
		}
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://54.152.199.0:3306/Parking1";
			String user = "root";
			String password = "monster";
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "select sum(Charge) as sumvalue from History where StartTime < "+Start+" and StartTime > "+End; 
			Statement st = conn.createStatement();
			inc=st.executeQuery(sql);
			if (inc.first())
			{
		      incc=inc.getInt(1);
			}
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return incc;
	}
	
	public static void ModifyLot(String lotid, String neww,String type) 
	{
		String tablename = "ParkingInfo";
		String change=null;
		if(type.equals("n"))
		{
			change="ParkingName";
		}
		else if(type.equals("t"))
		{
			change="Total";
		}
		
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		
		try 
		{
			Table table = dynamoDB.getTable(tablename);
			Item item=table.getItem("Parkurself","parkurself","Id",lotid);
			item.withString(change, neww);
			table.deleteItem("Parkurself","parkurself","Id",lotid);
			table.putItem(item);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	public static String GetResv(String lotid)
	{
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		Table table=dynamoDB.getTable("ParkingInfo");
		Item item=table.getItem("Parkurself","parkurself","Id",lotid);
		int total=item.getInt("Total");
		
		String[][] res=new String [total][7];
		
		ResultSet resv=null;
		int Type=0;
		int isLeft=0;
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://54.152.199.0:3306/Parking1";
			String user = "root";
			String password = "monster";
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "select * from Reservation where Type="+Type+" and isLeft="+isLeft; 
			Statement st = conn.createStatement();
			resv=st.executeQuery(sql);
			int i=0;
			if(resv.first())
			{
				i++;
			    res[i][1]=resv.getString("Username");
			    res[i][2]=resv.getString("CarNumber");
			    res[i][3]=resv.getString("PhoneNumber");
			    res[i][4]=resv.getString("Price");
			    res[i][5]=resv.getString("StartTime");
			    res[i][6]=resv.getString("AbortTime");
				while(resv.next())
				{
					i++;
					res[i][1]=resv.getString("Username");
				    res[i][2]=resv.getString("CarNumber");
				    res[i][3]=resv.getString("PhoneNumber");
				    res[i][4]=resv.getString("Price");
				    res[i][5]=resv.getString("StartTime");
				    res[i][6]=resv.getString("AbortTime");
				}
			}
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int i=0;
		String ress="";
		while(i++<res.length)
		{
			if(res[i][5]==null)
				break;
			int j=0;
			while(j++<6)
				ress+=res[i][j]+" ";
		}
		return ress;
	}
	
	public static String GetChar(String lotid)
	{
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		Table table=dynamoDB.getTable("ParkingInfo");
		Item item=table.getItem("Parkurself","parkurself","Id",lotid);
		int total=item.getInt("Total");
		
		Date now= new Date();
		String[][] cha=new String [total][7];
		
		ResultSet charge=null;
		int Type=1;
		int isLeft=0;
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://54.152.199.0:3306/Parking1";
			String user = "root";
			String password = "monster";
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "select * from Reservation where Type="+Type+" and isLeft="+isLeft; 
			Statement st = conn.createStatement();
			charge=st.executeQuery(sql);
			int i=0;
			if(charge.first())
			{
				i++;
			    cha[i][1]=charge.getString("CarNumber");
			    cha[i][2]="0";
			    cha[i][3]=charge.getString("Price");
			    cha[i][4]=charge.getString("StartTime");
			    cha[i][5]=Long.toString((now.getTime()-charge.getLong("StartTime"))*charge.getInt("Price"));
				while(charge.next())
				{
					i++;
					cha[i][1]=charge.getString("CarNumber");
				    cha[i][2]="0";
				    cha[i][3]=charge.getString("Price");
				    cha[i][4]=charge.getString("StartTime");
				    cha[i][5]=Long.toString((now.getTime()-charge.getLong("StartTime"))*charge.getInt("Price"));
				}
			}
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int i=0;
		String charg="";
		while(i++<cha.length)
		{
			if(cha[i][4]==null)
				break;
			int j=0;
			while(j++<5)
				charg+=cha[i][j]+" ";
			i++;
		}
		return charg;
	}
	
	public static String GetHisto(String lotid)
	{
		DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient());
		Table table=dynamoDB.getTable("ParkingInfo");
		Item item=table.getItem("Parkurself","parkurself","Id",lotid);
		int total=item.getInt("Total");
	
		String[][] his=new String [total][7];
		
		ResultSet histo=null;

		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://54.152.199.0:3306/Parking1";
			String user = "root";
			String password = "monster";
			Connection conn = DriverManager.getConnection(url, user, password);
			String sql = "select * from History"; 
			Statement st = conn.createStatement();
			histo=st.executeQuery(sql);
			int i=0;
			if(histo.first())
			{
				i++;
			    his[i][1]=histo.getString("CarNumber");
			    his[i][2]="0";
			    his[i][3]=histo.getString("Price");
			    his[i][4]=histo.getString("StartTime");
			    his[i][5]=histo.getString("EndTime");
			    his[i][6]=histo.getString("Charge");
				while(histo.next())
				{
					i++;
					his[i][1]=histo.getString("CarNumber");
				    his[i][2]="0";
				    his[i][3]=histo.getString("Price");
				    his[i][4]=histo.getString("StartTime");
				    his[i][5]=histo.getString("EndTime");
				    his[i][6]=histo.getString("Charge");
				}
			}
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int i=0;
		String hist="";
		while(i++<his.length)
		{
			if(his[i][4]==null)
				break;
			int j=0;
			while(j++<6)
				hist+=his[i][j]+" ";
			i++;
		}
		return hist;
	}
	
	
}
