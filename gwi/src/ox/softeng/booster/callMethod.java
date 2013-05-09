package ox.softeng.booster;

import java.io.IOException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class callMethod
 */
public class callMethod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		
		JSONObject result = new JSONObject();
		
		String className = request.getParameter("_className");
		String methodName = request.getParameter("_methodName");

		System.out.println("calling: " + methodName);
		
		
		Map<String, String[]> requestParameters = request.getParameterMap();
		for(String parameter : requestParameters.keySet()) {
		    	System.out.println("with parameter: (" + parameter + "," + requestParameters.get(parameter)[0] + ")");
		}
		try{ 
			CallableStatement cs = client.prepareCall("call `METHOD_PARAMS`(?,?)");
			cs.setString(1, className);
			cs.setString(2, methodName);
			ResultSet rs = cs.executeQuery();
			rs.beforeFirst();

			int noParams = 0;
			
			LinkedHashMap<String, Object> methodInputParameterValues = new LinkedHashMap <String,Object>();
			LinkedHashMap<String, Object> methodOutputParameterValues = new LinkedHashMap <String,Object>();
			LinkedHashMap<String, String> paramTypes = new LinkedHashMap <String,String>();
			LinkedHashMap<String, String> paramInOuts = new LinkedHashMap <String,String>();
			String callStatement = "call `" + className + "_" + methodName + "`(";

			while(rs.next())
			{
				if(noParams!=0)
				{
					callStatement += ",";
				}
				callStatement += "?";
				
				String paramName = rs.getString("paramName");
				String paramType = rs.getString("paramType");
				String inOut = rs.getString("paramInOut");
				paramTypes.put(paramName, paramType);
				paramInOuts.put(paramName, inOut);
				if(inOut.equalsIgnoreCase("input"))
				{
					if(paramType.equalsIgnoreCase("String") || paramType.equalsIgnoreCase("SetValue"))
					{
						methodInputParameterValues.put(paramName, requestParameters.get(paramName)[0]);
					}
					else if(paramType.equalsIgnoreCase("Integer") || paramType.equalsIgnoreCase("ClassRef"))
					{
						methodInputParameterValues.put(paramName, Integer.parseInt(requestParameters.get(paramName)[0]));
					}
				}
				//String paramMultiplicity = rs.getString("paramMultiplicity");
			
				noParams ++;
				
			}
			callStatement += ")";

			cs = client.prepareCall(callStatement);
			System.out.println("methodInputParameterValues.size()" + methodInputParameterValues.size());
		    Iterator<Entry<String, Object>>  it = methodInputParameterValues.entrySet().iterator();
		    int paramNo = 1;
		    while (it.hasNext()) {
		        Map.Entry <String, Object> pairs = (Map.Entry <String, Object>)it.next();
		        
		        String paramType = paramTypes.get(pairs.getKey());
		        if(paramInOuts.get(pairs.getKey()).equalsIgnoreCase("input"))
		        {
			        if(paramType.equalsIgnoreCase("String") || paramType.equalsIgnoreCase("SetValue"))
			        {
			        	cs.setString(paramNo,(String)pairs.getValue());
			        	System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
			        }
					else if(paramType.equalsIgnoreCase("Integer") || paramType.equalsIgnoreCase("ClassRef"))
					{
						cs.setInt(paramNo,(Integer)pairs.getValue());
						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
					}
		        }
		        else if(paramInOuts.get(pairs.getKey()).equalsIgnoreCase("output"))
		        {
			        if(paramType.equalsIgnoreCase("String") || paramType.equalsIgnoreCase("SetValue"))
			        {
			        	cs.registerOutParameter(paramNo, java.sql.Types.VARCHAR);
			        	System.out.println("Registering: " + pairs.getKey() + "," + pairs.getValue());
			        }
					else if(paramType.equalsIgnoreCase("Integer") || paramType.equalsIgnoreCase("ClassRef"))
					{
						cs.registerOutParameter(paramNo, java.sql.Types.INTEGER);
						System.out.println("Registering: " + pairs.getKey() + "," + pairs.getValue());
					}
		        }
		        it.remove(); // avoids a ConcurrentModificationException
		        paramNo++;
		    }

			
			cs.execute();
			result.put("_success", true);
			JSONArray outputParameterValues = new JSONArray();
			rs.beforeFirst();
			while(rs.next())
			{
				String paramName = rs.getString("paramName");
				String paramType = rs.getString("paramType");
				String inOut = rs.getString("paramInOut");
				String paramClassName= rs.getString("paramClassName");
				String paramSetName = rs.getString("paramSetName");
				paramTypes.put(paramName, paramType);
				paramInOuts.put(paramName, inOut);
				if(inOut.equalsIgnoreCase("output"))
				{
		        	JSONObject obj = new JSONObject();
					
					//obj.put("paramMutiplicity", paramMultiplicity);
					if(paramType.equalsIgnoreCase("String"))
			        {
			        	String strOutput = cs.getString(paramNo);
			        	obj.put("value", strOutput);
			        	System.out.println("Retrieving: " + paramName + "," + result);
			        }
					else if(paramType.equalsIgnoreCase("Integer") || paramType.equalsIgnoreCase("ClassRef"))
					{
			        	Integer intOutput = cs.getInt(paramNo);
			        	obj.put("value", intOutput);
			        	System.out.println("Retrieving: " + paramName + "," + result);
					}
					obj.put("paramName", paramName);
					obj.put("paramType", paramType);
					obj.put("paramClassName", paramClassName);
					obj.put("paramSetName", paramSetName);
					outputParameterValues.add(obj);

				}
				//String paramMultiplicity = rs.getString("paramMultiplicity");
							
			}
			result.put("outputParameterValues", outputParameterValues);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			result.put("_success", false);
			result.put("outputParameterValues", null);
		}
		
		response.getOutputStream().println(result.toJSONString());
		response.getOutputStream().flush();

		return;
		
	}

	/**
     * @see HttpServlet#HttpServlet()
     */
    public callMethod() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
