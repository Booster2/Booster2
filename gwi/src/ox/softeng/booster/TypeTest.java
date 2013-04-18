package ox.softeng.booster;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
  import java.util.Vector;
  public class TypeTest{
   public static Integer countmainClass(Connection c) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select count(*) from mainClass");
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer i = rs.getInt(1);
      return i;
   }

   public static String retrievemainClassatt1(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att1 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      String ret = rs.getString(1);
      return ret;
   }

   public static Integer retrievemainClassatt2(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att2 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer ret = rs.getInt(1);
      return ret;
   }

   public static String retrievemainClassatt3(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att3 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      String ret = rs.getString(1);
      return ret;
   }

   public static Integer retrievemainClassatt4(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att4 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer ret = rs.getInt(1);
      return ret;
   }

   public static Integer retrievemainClassatt5(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievemainClassatt6(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievemainClassatt7(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static String retrievemainClassatt8(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att8 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      String ret = rs.getString(1);
      return ret;
   }

   public static Integer retrievemainClassatt9(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att9 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer ret = rs.getInt(1);
      return ret;
   }

   public static String retrievemainClassatt10(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att10 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      String ret = rs.getString(1);
      return ret;
   }

   public static Integer retrievemainClassatt11(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att11 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer ret = rs.getInt(1);
      return ret;
   }

   public static Integer retrievemainClassatt12(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievemainClassatt13(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievemainClassatt14(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Vector<String> retrievemainClassatt15(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att15 from mainClass_att15 where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<String> ret = new Vector<String>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getString(1));
      return ret;
   }

   public static Vector<Integer> retrievemainClassatt16(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att16 from mainClass_att16 where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Vector<String> retrievemainClassatt17(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att17 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<String> ret = new Vector<String>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getString(1));
      return ret;
   }

   public static Vector<Integer> retrievemainClassatt18(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att18 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Vector<Integer> retrievemainClassatt19(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att19 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Vector<Integer> retrievemainClassatt20(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att20 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Vector<Integer> retrievemainClassatt21(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select att21 from mainClass where mainClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Integer countsecondaryClass(Connection c) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select count(*) from secondaryClass");
      ResultSet rs = ps.executeQuery();
      rs.beforeFirst();
      rs.next();
      Integer i = rs.getInt(1);
      return i;
   }

   public static Integer retrievesecondaryClassattA(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievesecondaryClassattB(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Vector<Integer> retrievesecondaryClassattC(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select attC from secondaryClass where secondaryClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Integer retrievesecondaryClassattD(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievesecondaryClassattE(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Vector<Integer> retrievesecondaryClassattF(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select attF from secondaryClass where secondaryClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }

   public static Integer retrievesecondaryClassattG(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Integer retrievesecondaryClassattH(Connection c, Integer id) throws SQLException{
      return 0;
   }

   public static Vector<Integer> retrievesecondaryClassattI(Connection c, Integer id) throws SQLException{
      PreparedStatement ps = c.prepareStatement("select attI from secondaryClass where secondaryClassId = ?");
      ps.setInt(1,id);
      ResultSet rs = ps.executeQuery();
      Vector<Integer> ret = new Vector<Integer>();
      rs.beforeFirst();
      while(rs.next())
        ret.add(rs.getInt(1));
      return ret;
   }


}