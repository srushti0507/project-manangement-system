package config;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Database Configuration File
 * @author Anand Singh
 *
 */
public class DbHelper {
	
	/**
	 * Function to create Connection in common
	 * @return Connection object
	 * @throws Exception
	 */
	public static Connection connect() throws Exception {
        //Class.forName("com.mysql.jdbc.Driver");        
        Class.forName("com.mysql.cj.jdbc.Driver");        
        final String URL = "jdbc:mysql://localhost/project_mgmt";
        final String USER = "root";
        final String PWD = "admin";
        Connection con = DriverManager.getConnection(URL, USER, PWD);
        return con;
    }
	
	/**
	 * Execute DML Statement Helper method
	 * @param sql
	 * @param params
	 * @throws Exception
	 */
	public static void executeDML(String sql,String ...params) throws Exception {
		Connection con=connect();
		PreparedStatement ps=con.prepareStatement(sql);
		for(int i=1;i<=params.length;i++) {
			ps.setString(i,params[i-1]);
		}
		ps.executeUpdate();
		con.close();
	}
	
	/**
	 * Execute DML Statement Helper method
	 * @param sql
	 * @param params
	 * @throws Exception
	 */
	public static void executeDMLProc(String sql,String ...params) throws Exception {
		Connection con=connect();
		CallableStatement cs=con.prepareCall(sql);
		for(int i=1;i<=params.length;i++) {
			cs.setString(i,params[i-1]);
		}
		cs.executeUpdate();
		con.close();
	}
	
	/**
	 * execute Query
	 * @param sql
	 * @param params
	 * @return
	 */
	public static List<Map<String,String>> executeDQL(String sql,String ...params) throws Exception {
		Connection con=connect();
		PreparedStatement ps=con.prepareStatement(sql);
		for(int i=1;i<=params.length;i++) {
			ps.setString(i,params[i-1]);
		}
		ResultSet rs=ps.executeQuery();
		List<Map<String,String>> list=new ArrayList<Map<String,String>>();
		ResultSetMetaData rsm=rs.getMetaData();
        while(rs.next()){            
            Map<String,String> map=new HashMap<>();
            for(int i=1;i<=rsm.getColumnCount();i++){
                String colname=rsm.getColumnLabel(i);
                map.put(colname,rs.getString(colname));
            }
            list.add(map);
        }
		con.close();
		return list;
	}
	
	/**
	 * execute Query return single result
	 * @param sql
	 * @param params
	 * @return
	 */
	public static Map<String,String> executeDQLReturnSingle(String sql,String ...params) throws Exception {
		Connection con=connect();
		PreparedStatement ps=con.prepareStatement(sql);
		for(int i=1;i<=params.length;i++) {
			ps.setString(i,params[i-1]);
		}
		ResultSet rs=ps.executeQuery();
		Map<String,String> map=null;
		ResultSetMetaData rsm=rs.getMetaData();
        if(rs.next()){            
            map=new HashMap<>();
            for(int i=1;i<=rsm.getColumnCount();i++){
                String colname=rsm.getColumnLabel(i);
                map.put(colname,rs.getString(colname));
            }
        }
		con.close();
		return map;
	}
	
	/**
	 * execute Query return count
	 * @param sql
	 * @param params
	 * @return
	 */
	public static String singleValue(String sql,String ...params) throws Exception {
		Connection con=connect();
		PreparedStatement ps=con.prepareStatement(sql);
		for(int i=1;i<=params.length;i++) {
			ps.setString(i,params[i-1]);
		}
		ResultSet rs=ps.executeQuery();	
		String result=null;
        if(rs.next()){            
            result=rs.getString(1);
        }
		con.close();
		return result;
	}
	
	/**
	 * Function to format date
	 * @param date
	 * @return Date in String 
	 * @throws Exception
	 */
	public static String formatDate(String date) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String target = new SimpleDateFormat("E, dd-MMM-yyyy").format(sdf.parse(date));
        return target;
    }
    
	
    public static String today() throws Exception {        
        String target = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return target;
    }
    
}
