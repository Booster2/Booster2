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


/**
 * Servlet implementation class ClassCardinality
 */
public class ClassCardinality extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassCardinality() {
        super();
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("service() called on ClassCardinality");
		response.setContentType("application/json");
		
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		
		String className = request.getParameter("className");

		JSONObject result = new JSONObject();
		
		try{ // Get Object Description
			//getDBUSERByUserId is a stored procedure
			CallableStatement callableStatement = client.prepareCall("call `GET_NO_OBJECTS_FOR_CLASS`(?,?)");
			callableStatement.setString(1, className);
			callableStatement.registerOutParameter(2, java.sql.Types.INTEGER);
			 
			// execute getDBUSERByUserId store procedure
			callableStatement.executeUpdate();
			 
			Integer cardinality = callableStatement.getInt(2);
			result.put("cardinality", cardinality);
		}
		catch(Exception e)
		{
			e.printStackTrace(System.err);
			response.getOutputStream().println("Error in getting class cardinality from database");
		}

		response.getOutputStream().println(result.toJSONString());
		response.getOutputStream().flush();
		
		
	}

}
