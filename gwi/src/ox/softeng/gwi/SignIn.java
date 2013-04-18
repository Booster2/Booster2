package ox.softeng.gwi;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;


import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import ox.softeng.gwi.Dbconnection;


public class SignIn {
	
	public static Connection signIn(String filename)
	{
		Connection superuser = null;
			boolean valid = true;
			String inputConfig = new String("");
			// Sign in Super user
			JAXBContext jc = null;
			Dbconnection dbc = null;

			try{
				byte[] buffer = new byte[(int) new File(filename).length()];
				BufferedInputStream f = new BufferedInputStream(new FileInputStream(filename));
				f.read(buffer);
				f.close();
				inputConfig = new String(buffer);
				//System.out.println("Read config file");
				
			}catch(IOException e)
			{
				System.out.println("System error: cannot create superuser connection");
				valid = false;
				
			}

			try {
				jc = JAXBContext.newInstance("ox.softeng.gwi");
				Unmarshaller unmarshaller = (Unmarshaller)jc.createUnmarshaller();
				InputStream is = new ByteArrayInputStream(inputConfig.getBytes("UTF-8"));
				dbc = (Dbconnection) unmarshaller.unmarshal(is);
				//System.out.println("Here 1");
			}catch(Exception e)
			{
				System.out.println("System error: cannot create superuser connection");
				System.out.println("Cannot read configuration file to get superuser details");
				e.printStackTrace();
				valid = false;
			}

			String host = dbc.getHost();
			//System.out.println("dbc host:" + dbc.getHost());
			String port = dbc.getPort();
			String jdbcusername = dbc.getUsername();
			String jdbcpassword = dbc.getPassword();
			String databaseName = dbc.getDbname();

			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
			String url = "jdbc:mysql://" + host + ":" + port + "/" + databaseName;

			// System.out.println("url: " + url);

			try
			{
				superuser = DriverManager.getConnection (url, jdbcusername, jdbcpassword);
				//System.out.println(superuser.getMetaData().getDatabaseProductName());
				valid = true;
				
			}
			catch(Throwable th)
			{
				//Logout("System error: cannot create superuser connection", request, out);
				System.out.println("Cannot create superuser connection");
				th.printStackTrace();
				valid = false;
			}
			if(valid && superuser!= null)
			{
				return superuser;
			}
			else
			{
				return null;
			}
	}
	
}