import java.io.*;
import java.text.*;
import java.util.*;
import java.sql.*;

public class SE_Transformation {

	public static Connection dbcon;

	public static void open() throws SQLException {

		/* declare ODBC conectivity */
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		} catch (java.lang.ClassNotFoundException e) {
			System.out.print("ClassNotFoundException: ");
			System.out.println(e.getMessage());
		}

	    try {
			String url = "jdbc:odbc:SE_DBASW;";
			dbcon = DriverManager.getConnection(url);
		} catch (Exception e2) {
			dbcon = null;
		    throw new SQLException("Could not establish connection with the Database Server: " + e2.getMessage());

		}
	}

	public static void main(String args[]) {

		Statement stmt = null;
  		ResultSet rs1 = null;
  		int i = 0;
  		long startTime = System.currentTimeMillis();

		/* execute SQL statements */
		try {

			open();

			List<String> tags = new ArrayList<String>();
			List<Integer> posts = new ArrayList<Integer>();

			posts = getPosts();

        	for(Integer p : posts) {

                tags = tags(p);

				Update(p, tags);

				System.out.println(i++);
			}

			long endTime   = System.currentTimeMillis();
			long totalTime = endTime - startTime;
			int seconds = (int) ((totalTime / 1000) % 60);
			int minutes = (int) ((totalTime / 1000) / 60);
		    System.out.println(minutes + "m " + seconds + "s ");

    		dbcon.close();
		} catch(SQLException e) {
			System.out.print("SQLException: ");
			System.out.println(e.getMessage());
		}
	}

	public static void Update (Integer postid, List<String> tags) {

		Statement stmt = null;

	    /* execute SQL statements */
		try {

			stmt = dbcon.createStatement();

			for(String tag : tags) {
				stmt.executeUpdate("UPDATE transformation SET ["+ tag +"]=1 WHERE postid=" + postid + ";");
			}

			stmt.close();

			} catch(SQLException e) {
				System.out.print("SQLException: ");
				System.out.println(e.getMessage());
		}

	}

	public static List<String> tags (Integer postid) {

		Statement stmt=null;
		ResultSet rs = null;
		List<String> tags = new ArrayList<String>();

				/* execute SQL statements */
				try {

					stmt = dbcon.createStatement();
					rs = stmt.executeQuery("select tag from joining WHERE postid=" + postid + ";");
					while (rs.next()) {
						tags.add(rs.getString("tag"));

					}
					rs.close();
					stmt.close();

				} catch(SQLException e) {
					System.out.print("SQLException: ");
					System.out.println(e.getMessage());
				}
	return tags;
	}

	public static List<Integer> getPosts() {
		List<Integer> posts = new ArrayList<Integer>();

		/* execute SQL statements */
		try {
			ResultSet rs = null;
			Statement stmt = null;

			stmt = dbcon.createStatement();

			rs = stmt.executeQuery("select postid from transformation;");

			while (rs.next()) {
				posts.add(rs.getInt("postid"));
			}

			rs.close();
			stmt.close();
		} catch(SQLException e) {
			System.out.print("SQLException: ");
			System.out.println(e.getMessage());
		}
			return posts;

	}
}
