package ox.softeng.booster;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class ClassSearch
 */
@WebServlet("/ClassSearch")
public class ClassSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassSearch() {
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

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("service() called on ClassSearch");
		response.setContentType("application/json");

		String className;
		String searchOrderBy;
		String searchDirection;
		Integer searchStart;
		Integer searchLimit;
		String searchTerm;
		try{
			className = request.getParameter("className");
			searchOrderBy = request.getParameter("searchOrderBy");
			searchDirection = request.getParameter("searchDirection");
			searchStart = Integer.parseInt(request.getParameter("searchStart"));
			searchLimit = Integer.parseInt(request.getParameter("searchLimit"));
			searchTerm = request.getParameter("searchTerm");
		}catch(Exception e)
		{
			return;
		}
		
		JSONObject result = new JSONObject();
		
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		
		try{ 
			CallableStatement cs = 
					client.prepareCall(
							"call `GET_OBJECT_DESCRIPTION_AS_TABLE`(?, ?, ?, ?, ?, ?, ?)");
			cs.setString(1, className);
			cs.setString(2, searchOrderBy);
			cs.setString(3, searchDirection);
			cs.setInt(4, searchStart);
			cs.setInt(5, searchLimit);
			cs.setString(6, searchTerm);
			cs.registerOutParameter(7, java.sql.Types.INTEGER);
			ResultSet rs = cs.executeQuery();
			Integer total = cs.getInt(7);
			result.put("total", total);
			ResultSetMetaData metaData = rs.getMetaData();
			JSONArray columnNames = new JSONArray();
			int count = metaData.getColumnCount();
			for (int i = 1; i <= count; i++)
			{
				String columnName = metaData.getColumnName(i); 
				if(!columnName.equalsIgnoreCase("ID"))
				{
					columnNames.add(columnName);
				}
			}
			result.put("columns", columnNames);
			JSONArray rows = new JSONArray();
			while(rs.next())
			{
				JSONArray data = new JSONArray();
				for (int i = 1; i <= count; i++)
				{
					String columnName = metaData.getColumnName(i); 
					data.add(rs.getObject(i));
					
				}
				rows.add(data);
				
			}
			result.put("rows", rows);
		
		}catch(Exception e)
		{
			e.printStackTrace(System.err);
			response.getOutputStream().println("Error in getting class table from database");
		}
		response.getOutputStream().println(result.toJSONString());
		response.getOutputStream().flush();

		
	}

	
}
