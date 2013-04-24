package ox.softeng.booster;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ox.softeng.gwi.SignIn;

public class UIHelper {

	
	public static Connection trySignIn(HttpServletRequest request)
	{
		boolean needToSignIn = false;
		Connection client = null;
		try{
			client = (Connection) request.getSession().getAttribute("client");
			if(client == null  || client.isClosed() || !client.isValid(0))
			{
				needToSignIn = true;
			}
		}
		catch(Exception e)
		{
			needToSignIn = true;	
		}
		if(needToSignIn)
		{
			try{
				String filename = request.getServletContext().getRealPath("/WEB-INF/dbConfig.xml");
				client = SignIn.signIn(filename);
				//String username = client.getMetaData().getUserName();
				//String dbname = client.getMetaData().getDatabaseProductName();
				request.getSession().setAttribute("client", client);
			}catch(Exception e)
			{
				System.err.println("Error in getting connection details");
				e.printStackTrace(System.err);
				return null;
			}
		}
		return client;
			
	}
	
}
