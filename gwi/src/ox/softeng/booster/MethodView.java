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

import ox.softeng.booster.UIHelper;

/**
 * Servlet implementation class ObjectView
 */
public class MethodView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MethodView() {
        super();
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("service() called on ObjectView");
		response.setContentType("application/json");
		

		String className = request.getParameter("className");
		String methodName = request.getParameter("methodName");
		
		JSONObject result = new JSONObject();
		
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		
		try{ 
			PreparedStatement ps = client.prepareStatement("call `METHOD_PARAMS`(?,?)");
			ps.setString(1, className);
			ps.setString(2, methodName);
			ResultSet rs = ps.executeQuery();

			JSONArray jsonArray = new JSONArray();
			JSONObject obj = new JSONObject();

			while(rs.next())
			{
				if(rs.getString("paramInOut").equalsIgnoreCase("input"))
				{
					obj = new JSONObject();
					String paramName = rs.getString("paramName");
					String paramType = rs.getString("paramType");
					String paramMultiplicity = rs.getString("paramMultiplicity");
					String paramSetName = rs.getString("paramSetName");
					String paramClassName = rs.getString("paramClassName");
					
					if("SetValue".equalsIgnoreCase(paramType) && 
							!"".equalsIgnoreCase(paramSetName) &&
							!result.containsKey(paramSetName))
					{
						PreparedStatement setvalueps = client.prepareStatement("call `GET_SET_VALUES`(?)");
						setvalueps.setString(1, paramSetName);
						ResultSet setValuesRS = setvalueps.executeQuery();
						JSONArray valuesArray = new JSONArray();
						while(setValuesRS.next())
						{
							
							String value = setValuesRS.getString(1);
							System.out.println("Value: " + value);
							valuesArray.add(value);
						}
						obj.put("values", valuesArray);

						
						
					}
					if("ClassRef".equalsIgnoreCase(paramType) && 
							!"".equalsIgnoreCase(paramClassName) &&
							!result.containsKey(paramClassName))
					{
						PreparedStatement setvalueps = client.prepareStatement("call `GET_CLASS_VALUES`(?)");
						setvalueps.setString(1, paramClassName);
						ResultSet setValuesRS = setvalueps.executeQuery();
						JSONArray valuesArray = new JSONArray();
						while(setValuesRS.next())
						{
							int oid = setValuesRS.getInt("OBJECT_ID");
							String desc = setValuesRS.getString("DESCRIPTION");
							//System.out.println("Value: " + value);
							JSONObject objvalue = new JSONObject();
							objvalue.put("id", oid);
							objvalue.put("desc", desc);
							valuesArray.add(objvalue);
						}
						obj.put("values", valuesArray);

						
						
					}
					obj.put("paramName", paramName);
					obj.put("paramType", paramType);
					obj.put("paramSetName", paramSetName);
					obj.put("paramMutiplicity", paramMultiplicity);
					
					jsonArray.add(obj);
				}
			}
			
			result.put("parameters", jsonArray);
			
			

		}
		catch(Exception e)
		{
			e.printStackTrace(System.err);
			response.getOutputStream().println("Error in getting method params from database");
		}
		
		
		response.getOutputStream().println(result.toJSONString());
		response.getOutputStream().flush();
		
		
	}

}
