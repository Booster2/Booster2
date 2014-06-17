package ox.softeng.booster;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Locale;
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
public class methodPrecondition extends HttpServlet {
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
		System.out.println("size: " + request.getParameterMap().size());
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
			LinkedHashMap<String, String> paramTypes = new LinkedHashMap <String,String>();
			LinkedHashMap<String, String> paramInOuts = new LinkedHashMap <String,String>();
			String callStatement = "select `" + className + "_" + methodName + "_available_inputs` (";

			while(rs.next())
			{
				
				String paramName = rs.getString("paramName");
				String paramType = rs.getString("paramType");
				String inOut = rs.getString("paramInOut");
				paramTypes.put(paramName, paramType);
				if(inOut.equalsIgnoreCase("input"))
				{
					if(noParams!=0)
					{
						callStatement += ",";
					}
					callStatement += "?";
					if(requestParameters.get(paramName) == null)
					{
						methodInputParameterValues.put(paramName, null);
					}
					else{
		
						if(paramType.equalsIgnoreCase("String") || paramType.equalsIgnoreCase("SetValue") || paramType.equalsIgnoreCase("Password"))
						{
							methodInputParameterValues.put(paramName, requestParameters.get(paramName)[0]);
						}
						else if(paramType.equalsIgnoreCase("Integer") || paramType.equalsIgnoreCase("ClassRef"))
						{
							methodInputParameterValues.put(paramName, Integer.parseInt(requestParameters.get(paramName)[0]));
						}
						else if(paramType.equalsIgnoreCase("Decimal"))
						{
						    NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());
					        Number parsed = nf.parse(requestParameters.get(paramName)[0]);
					        BigDecimal bd1 = new BigDecimal(parsed.toString());
							methodInputParameterValues.put(paramName, bd1);
						}
						else if(paramType.equalsIgnoreCase("Date"))
						{
					        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
					        Date date = formatter.parse(requestParameters.get(paramName)[0]);
							methodInputParameterValues.put(paramName, new java.sql.Date(date.getTime()));
						}
						else if(paramType.equalsIgnoreCase("Time"))
						{
					        java.sql.Time time = java.sql.Time.valueOf(requestParameters.get(paramName)[0]);
							methodInputParameterValues.put(paramName, time);
						}
						else if(paramType.equalsIgnoreCase("DateTime"))
						{
							SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
					        Date date = formatter.parse(requestParameters.get(paramName)[0]);
					        System.out.println("Date: " + date);
							methodInputParameterValues.put(paramName, new java.sql.Timestamp(date.getTime()));
						}
					}
					paramInOuts.put(paramName + "_in", inOut);
				}
				else{
					paramInOuts.put(paramName + "_out", inOut);
				}
				//String paramMultiplicity = rs.getString("paramMultiplicity");
			
				noParams ++;
				
			}
			callStatement += ")";
			System.out.println("callStatement: " + callStatement);
			cs = client.prepareCall(callStatement);
			System.out.println("methodInputParameterValues.size()" + methodInputParameterValues.size());
		    Iterator<Entry<String, Object>>  it = methodInputParameterValues.entrySet().iterator();
		    int paramNo = 1;
		    while (it.hasNext()) {
		        Map.Entry <String, Object> pairs = (Map.Entry <String, Object>)it.next();
		        String paramType = paramTypes.get(pairs.getKey());
		        if(paramInOuts.get(pairs.getKey() + "_in").equalsIgnoreCase("input"))
		        {
			        if(paramType.equalsIgnoreCase("String") || paramType.equalsIgnoreCase("SetValue") || paramType.equalsIgnoreCase("Password"))
			        {
						if(pairs.getValue() == null)
						{
							cs.setNull(paramNo, java.sql.Types.VARCHAR);
						}
						else{
							cs.setString(paramNo,(String)pairs.getValue());
						}
						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
			        }
					else if(paramType.equalsIgnoreCase("Integer") || paramType.equalsIgnoreCase("ClassRef"))
					{
						if(pairs.getValue() == null)
						{
							cs.setNull(paramNo, java.sql.Types.INTEGER);
						}
						else{
							cs.setInt(paramNo,(Integer)pairs.getValue());
						}
						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
					}
					else if(paramType.equalsIgnoreCase("Decimal"))
					{
						if(pairs.getValue() == null)
						{
							cs.setNull(paramNo, java.sql.Types.DECIMAL);
						}
						else{
							cs.setBigDecimal(paramNo,(BigDecimal)pairs.getValue());
						}

						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
					}
					else if(paramType.equalsIgnoreCase("Time"))
					{
						if(pairs.getValue() == null)
						{
							cs.setNull(paramNo, java.sql.Types.TIME);
						}
						else{
							cs.setTime(paramNo,(java.sql.Time)pairs.getValue());
						}
						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
					}
					else if(paramType.equalsIgnoreCase("Date"))
					{
						if(pairs.getValue() == null)
						{
							cs.setNull(paramNo, java.sql.Types.DATE);
						}
						else{
							cs.setDate(paramNo,(java.sql.Date)pairs.getValue());
						}
						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
					}
					else if(paramType.equalsIgnoreCase("DateTime"))
					{
						if(pairs.getValue() == null)
						{
							cs.setNull(paramNo, java.sql.Types.TIMESTAMP);
						}
						else{
							cs.setTimestamp(paramNo,(Timestamp)pairs.getValue());
						}
						System.out.println("Putting: " + pairs.getKey() + "," + pairs.getValue());
					}
		        }
		        it.remove(); // avoids a ConcurrentModificationException
		        paramNo++;
		    }

			
			cs.execute();
			rs = cs.getResultSet();
			rs.beforeFirst();
			while(rs.next())
			{
				System.out.println("precondition: "+ rs.getInt(1));
				result.put("_precondition", rs.getBoolean(1));
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			result.put("_success", false);
			result.put("_precondition", false);
		}
		
		response.getOutputStream().println(result.toJSONString());
		response.getOutputStream().flush();

		return;
		
	}

	/**
     * @see HttpServlet#HttpServlet()
     */
    public methodPrecondition() {
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
