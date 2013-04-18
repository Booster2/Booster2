package ox.softeng.booster;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;

import ox.softeng.gwi.SignIn;



/**
 * Servlet implementation class ClassList
 */
public class ClassList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init() called on ClassList");
		
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("service() called on ClassList");
		response.setContentType("application/json");
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		
		JSONArray jsonArray = new JSONArray();
		JSONObject obj = new JSONObject();
		
		try{
			PreparedStatement ps = client.prepareStatement("call `COUNT_ALL_RECORDS_BY_TABLE`()");
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				obj = new JSONObject();
				String className = rs.getString("TABLE_NAME");
				obj.put("className", className);
				obj.put("noObjects", rs.getInt("RECORD_COUNT"));
				obj.put("minId", rs.getInt("MIN_ID"));
				PreparedStatement classMethodsPS = client.prepareStatement("call `GET_CLASS_METHOD_NAMES`(?)");
				classMethodsPS.setString(1, className);
				ResultSet classMethodsRS = classMethodsPS.executeQuery();
				JSONArray classMethodsArray = new JSONArray();
				while(classMethodsRS.next())
				{
					JSONObject method = new JSONObject();
					method.put("methodName", classMethodsRS.getString("methodName"));
					classMethodsArray.add(method);

				}
				obj.put("classMethods", classMethodsArray);
				
				jsonArray.add(obj);
			}
		}catch(Exception e)
		{
			System.err.print(e.getStackTrace());
			response.getOutputStream().println("Error in getting class list from database;");
		}
		
		response.getOutputStream().println(jsonArray.toJSONString());
		response.getOutputStream().flush();
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet() called on ClassList");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost() called on ClassList");
	}

}
