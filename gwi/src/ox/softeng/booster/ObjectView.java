package ox.softeng.booster;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import ox.softeng.gwi.SignIn;

/**
 * Servlet implementation class ObjectView
 */
public class ObjectView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ObjectView() {
        super();
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("service() called on ObjectView");
		response.setContentType("application/json");
		
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		
		String className = request.getParameter("className");
		String objectID = request.getParameter("objectID");
		
		JSONObject result = new JSONObject();
		
		try{ // Get Object Description
			//getDBUSERByUserId is a stored procedure
			CallableStatement callableStatement = client.prepareCall("call `GET_OBJECT_DESCRIPTION`(?,?,?)");
			callableStatement.setString(1, className);
			callableStatement.setString(2, objectID);
			callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
			 
			// execute getDBUSERByUserId store procedure
			callableStatement.executeUpdate();
			 
			String description = callableStatement.getString(3);
			result.put("description", description);
		}
		catch(Exception e)
		{
			e.printStackTrace(System.err);
			response.getOutputStream().write("Error in getting object view (description / id) from database".getBytes("UTF-8"));
		}
		try{
			PreparedStatement ps = client.prepareStatement("call `GET_OBJECT_BROWSE_LOCATION`(?,?)");
			ps.setString(1, className);
			ps.setString(2, objectID);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				result.put("prev",rs.getString("prev"));
				result.put("next",rs.getString("next"));
				result.put("first",rs.getString("first"));
				result.put("last",rs.getString("last"));
				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace(System.err);
			response.getOutputStream().write("Error in getting object browse location from database".getBytes("UTF-8"));
		}
		
		
		
		JSONArray jsonArray = new JSONArray();
		JSONObject obj = new JSONObject();
		
		try{
			PreparedStatement ps = client.prepareStatement("call `GET_OBJECT`(?,?)");
			ps.setString(1, className);
			ps.setString(2, objectID);
			ResultSet rs = ps.executeQuery();
			
			LinkedHashMap <String, JSONObject> attributesHashMap = new LinkedHashMap <String, JSONObject>();
			
			while(rs.next())
			{
				String attName = rs.getString("ATT_NAME");
				
				String attPrimType = rs.getString("ATT_PRIM_TYPE");
				String attTypeMult = rs.getString("TYPE_MULT");
				if(attributesHashMap.containsKey(attName))
				{
					JSONObject jsono = attributesHashMap.get(attName);
					//System.out.println(attName);
					if("String".equalsIgnoreCase(attPrimType))
					{
						JSONArray stringValues = (JSONArray) jsono.get("stringValues");
						stringValues.add(rs.getString("STRING_VALUE"));
					}
					else if("Password".equalsIgnoreCase(attPrimType))
					{
						JSONArray stringValues = (JSONArray) jsono.get("stringValues");
						stringValues.add("********");
					}
					else if("Integer".equalsIgnoreCase(attPrimType))
					{
						JSONArray intValues = (JSONArray) jsono.get("intValues");
						intValues.add(rs.getInt("INT_VALUE"));
					}
					else if("Boolean".equalsIgnoreCase(attPrimType))
					{
						JSONArray intValues = (JSONArray) jsono.get("intValues");
						intValues.add(rs.getInt("INT_VALUE"));
					}
					else if("Decimal".equalsIgnoreCase(attPrimType))
					{
						JSONArray decimalValues = (JSONArray) jsono.get("decimalValues");
						decimalValues.add(rs.getInt("DECIMAL_VALUE"));
					}
					else if("Time".equalsIgnoreCase(attPrimType))
					{
						JSONArray timeValues = (JSONArray) jsono.get("timeValues");
						timeValues.add(rs.getTime("TIME_VALUE"));
					}
					else if("Date".equalsIgnoreCase(attPrimType))
					{
						JSONArray dateValues = (JSONArray) jsono.get("dateValues");
						dateValues.add(rs.getTimestamp("DATE_VALUE"));
					}
					else if("DateTime".equalsIgnoreCase(attPrimType))
					{
						JSONArray dateTimeValues = (JSONArray) jsono.get("dateTimeValues");
						dateTimeValues.add(rs.getTimestamp("DATETIME_VALUE"));
					}
					else if("SetValue".equalsIgnoreCase(attPrimType))
					{
						JSONArray setValues = (JSONArray) jsono.get("setValues");
						setValues.add(rs.getString("SET_VALUE"));
					}
					else if("ClassRef".equalsIgnoreCase(attPrimType))
					{
						JSONArray oidValues = (JSONArray) jsono.get("oidValues");
						JSONArray objDescs = (JSONArray) jsono.get("objDescs");
						oidValues.add(rs.getString("OID_VALUE"));
						objDescs.add(rs.getString("OBJ_DESC"));
					}
				}
				else
				{
					obj = new JSONObject();
					JSONArray intValues = new JSONArray();
					JSONArray decimalValues = new JSONArray();
					JSONArray stringValues = new JSONArray();
					JSONArray timeValues = new JSONArray();
					JSONArray dateValues = new JSONArray();
					JSONArray dateTimeValues = new JSONArray();
					JSONArray setValues = new JSONArray();
					JSONArray oidValues = new JSONArray();
					JSONArray objDescs = new JSONArray();
					
					obj.put("attName", attName);
					obj.put("attPrimType", attPrimType );
					obj.put("attTypeMult", attTypeMult );
					obj.put("attClassName", rs.getString("CLASS_NAME"));
					if("Integer".equalsIgnoreCase(attPrimType))
					{
						intValues.add(rs.getInt("INT_VALUE"));
					}
					else if("Boolean".equalsIgnoreCase(attPrimType))
					{
						intValues.add(rs.getInt("INT_VALUE"));
					}
					else if("Decimal".equalsIgnoreCase(attPrimType))
					{
						decimalValues.add(rs.getBigDecimal("DECIMAL_VALUE").stripTrailingZeros());
					}
					else if("String".equalsIgnoreCase(attPrimType))
					{
						stringValues.add(rs.getString("STRING_VALUE"));
					}
					else if("Password".equalsIgnoreCase(attPrimType))
					{
						stringValues.add("********");
					}
					else if("Time".equalsIgnoreCase(attPrimType))
					{
						timeValues.add(rs.getString("TIME_VALUE"));
					}
					else if("Date".equalsIgnoreCase(attPrimType))
					{
						dateValues.add(rs.getString("DATE_VALUE"));
					}
					else if("DateTime".equalsIgnoreCase(attPrimType))
					{
						dateTimeValues.add(rs.getString("DATETIME_VALUE"));
					}
					else if("SetValue".equalsIgnoreCase(attPrimType))
					{
						setValues.add(rs.getString("SET_VALUE"));
					}
					else if("ClassRef".equalsIgnoreCase(attPrimType))
					{
						oidValues.add(rs.getString("OID_VALUE"));
						objDescs.add(rs.getString("OBJ_DESC"));
					}					
					
					obj.put("intValues", intValues);
					obj.put("decimalValues", decimalValues);
					obj.put("stringValues", stringValues);
					obj.put("dateTimeValues", dateTimeValues);
					obj.put("dateValues", dateValues);
					obj.put("timeValues", timeValues);
					obj.put("setValues", setValues);
					obj.put("oidValues", oidValues);
					obj.put("objDescs", objDescs);
					//System.out.println(attName);
					attributesHashMap.put(attName, obj);
					
				}
			}
		jsonArray.addAll(attributesHashMap.values());
		result.put("attributes", jsonArray);
		
		JSONArray methods = new JSONArray();
		JSONObject method = new JSONObject();
		
		
		ps = client.prepareStatement("call `GET_OBJECT_METHOD_NAMES`(?, ?, ?)");
		//ps = client.prepareStatement("call `GET_OBJECT_METHOD_NAMES`(?)");
		ps.setString(1, className);
		ps.setString(2, objectID);
		ps.setString(3, (String) request.getSession().getAttribute("UserId"));
		rs = ps.executeQuery();
		rs.beforeFirst();
		
		while(rs.next())
		{
			method = new JSONObject();
			method.put("methodName", rs.getString("methodName"));
			method.put("methodAvailability", rs.getInt("methodAvailable"));
			methods.add(method);
				
		}
		
		
		result.put("methods", methods);
		
		
		}catch(Exception e)
		{
			e.printStackTrace(System.err);
			response.getOutputStream().write("Error in getting object view (attributes) from database".getBytes("UTF-8"));
		}
		
		response.getOutputStream().write(result.toJSONString().getBytes("UTF-8"));
		response.getOutputStream().flush();
		
		
	}

}
