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

import org.json.simple.JSONObject;

/**
 * Servlet implementation class UserLogin
 */
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogin() {
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
		System.out.println("service() called on UserLogin");
		response.setContentType("application/json");
		Connection client = UIHelper.trySignIn(request);
		if(client == null)
		{
			return;
		}
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try{
			PreparedStatement ps = client.prepareStatement("call validatePassword(?,?)");
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs == null){
				// return user back to the login screen
				//response.getOutputStream().write("Error in signing in".getBytes("UTF-8"));
				JSONObject result = new JSONObject();
				result.put("_success", false);
				response.getOutputStream().write(result.toJSONString().getBytes("UTF-8"));
				response.getOutputStream().flush();
			}
			else
			{
				while(rs.next())
				{
					System.out.println("username: " + rs.getString(1));
					request.getSession().setAttribute("Username", rs.getString("username"));
					request.getSession().setAttribute("UserId", rs.getString("UserId"));
				}
			}
		}catch(Exception e)
		{
			e.printStackTrace(System.err);
			//System.err.print(e.getStackTrace());
			response.getOutputStream().write("Error in signing in".getBytes("UTF-8"));
		}
		
		
		JSONObject result = new JSONObject();
		result.put("_success", true);
		response.getOutputStream().write(result.toJSONString().getBytes("UTF-8"));
		response.getOutputStream().flush();
		
	
	}

}
