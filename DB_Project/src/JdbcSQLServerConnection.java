import java.sql.*;

public class JdbcSQLServerConnection {

	public static void main(String[] args) {

		Connection con = null;
		String conUrl = "jdbc:sqlserver://BIGGY-LAPTOP\\SQLEXPRESS; user=sa;password=camtse57;";

		try {
			// ...
			con = DriverManager.getConnection(conUrl);
			if (con != null) {
				DatabaseMetaData dm = (DatabaseMetaData) con.getMetaData();
				System.out.println("Driver name: " + dm.getDriverName());
				System.out.println("Driver version: " + dm.getDriverVersion());
				System.out.println("Product name: " + dm.getDatabaseProductName());
				System.out.println("Product version: " + dm.getDatabaseProductVersion());
			}
			// ...
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}