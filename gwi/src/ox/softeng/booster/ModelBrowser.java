package ox.softeng.booster;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class ModelBrowser
 */
public class ModelBrowser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	JSONObject modelObj = new JSONObject();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModelBrowser() {
        super();
		
		
		
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        System.out.println("service() called on ModelBrowser");
		response.setContentType("application/json");
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		JSONArray classArray = new JSONArray();
		try{
			PreparedStatement classesPs = client.prepareStatement("select * from _Meta_Classes");
			ResultSet classesRs = classesPs.executeQuery();
			while(classesRs.next())
			{
				String className = classesRs.getString("className");
				JSONObject classObject = new JSONObject();
				classObject.put("name", className);
				JSONArray attsArray = new JSONArray();
				PreparedStatement attsPs = client.prepareStatement("select * from _Meta_Attributes where class = '" + className + "';");
				ResultSet attsRs = attsPs.executeQuery();
				while(attsRs.next())
				{
					JSONObject attObject = new JSONObject();
					attObject.put("name", attsRs.getString("attName"));
					attObject.put("primType", attsRs.getString("primType"));
					attObject.put("typeMultiplicity", attsRs.getString("typeMultiplicity"));
					attObject.put("className", attsRs.getString("className"));
					attObject.put("setName", attsRs.getString("setName"));
					attObject.put("direction", attsRs.getString("direction"));
					attObject.put("oppAttName", attsRs.getString("oppAttName"));
					attObject.put("isId", attsRs.getBoolean("isId"));
					attsArray.add(attObject);
				}
				classObject.put("attributes", attsArray);

				JSONArray methsArray = new JSONArray();
				PreparedStatement methsPs = client.prepareStatement("select * from _Meta_Methods where class = '" + className + "';");
				ResultSet methsRs = methsPs.executeQuery();
				while(methsRs.next())
				{
					JSONObject methObject = new JSONObject();
					methObject.put("name", methsRs.getString("methodName"));
					methObject.put("html", methsRs.getString("html"));
					methsArray.add(methObject);
				}
				classObject.put("methods", methsArray);

				classArray.add(classObject);
				modelObj.put("classes", classArray);
			}
		}catch(Exception e)
		{
			System.err.println("Error!");
		}
		response.getOutputStream().println(modelObj.toJSONString());
		response.getOutputStream().flush();

	}

}
