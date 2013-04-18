package ox.softeng.gwi;

import ox.softeng.gwi.ObjectModel.*;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;


import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;



public class ObjectModelReader {

	public static ObjectModel readObjectModel(String filename)
	{
		String inputConfig = new String("");
		// Sign in Super user
		JAXBContext jc = null;
		ObjectModel om = null;

		try{
			byte[] buffer = new byte[(int) new File(filename).length()];
			BufferedInputStream f = new BufferedInputStream(new FileInputStream(filename));
			f.read(buffer);
			f.close();
			inputConfig = new String(buffer);
			//System.out.println("Read config file");

		}catch(IOException e)
		{
			System.out.println("System error: cannot read object model file");
			return null;
		}

		try {
			jc = JAXBContext.newInstance("ox.softeng.gwi.ObjectModel");
			Unmarshaller unmarshaller = (Unmarshaller)jc.createUnmarshaller();
			InputStream is = new ByteArrayInputStream(inputConfig.getBytes("UTF-8"));
			om = (ObjectModel) unmarshaller.unmarshal(is);
			//System.out.println("Here 1");
		}catch(Exception e)
		{
			System.out.println("System error: cannot create object model");
			System.out.println("Cannot read configuration file to get object model");
			e.printStackTrace();
			return null;
		}
		return om;

	}

}