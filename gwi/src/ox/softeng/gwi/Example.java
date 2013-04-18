package ox.softeng.gwi;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
  public class Example{
   public static Integer countmainClass(Connection c) throws SQLException{
  PreparedStatement ps = c.prepareStatement("select count(*) from mainClass");
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer i = rs.getInt(1);
      return i;
   }

   public static Integer countsecondaryClass(Connection c) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select count(*) from secondaryClass");
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer i = rs.getInt(1);
      return i;
   }


}