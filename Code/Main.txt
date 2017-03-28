import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;
import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class Main {

	private static int menu() {
		System.out.println("\n Welcom to Biggy's Car Parking.\n");
		System.out.println("*********************************");
		System.out.println("* 1. Check-In the vehicle.	*");
		System.out.println("* 2. Check-Out the vehicle.	*");
		System.out.println("* 3. Check slots availability.	*");
		System.out.println("* 4. Generate parking reports.	*");
		System.out.println("* 5. System data reset.		*");
		System.out.println("* 6. Exit.			*");
		System.out.println("*********************************");
		System.out.println();

		Scanner scan = new Scanner(System.in);
		int selection = 0;
		System.out.print("Enter : ");

		try {
			selection = scan.nextInt();
		} catch (InputMismatchException e) {
			String er = scan.next();
		}

		System.out.println();
		return selection;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Scanner scan = new Scanner(System.in);
		int selection = 0;
		String carBillID;
		int count = 0;
		int size = 0, carP = 0, vanP = 0, truckP = 0;

		do {
			System.out.print("Set maximum parking slots : ");
			try {
				size = scan.nextInt();
			} catch (InputMismatchException e) {
				System.out.println(" Invalid Arguments.");
				String er = scan.next();
			}
		} while (size == 0);

		count = size;

		do {
			System.out.print("Set Car fee : ");
			try {
				carP = scan.nextInt();
			} catch (InputMismatchException e) {
				System.out.println(" Invalid Arguments.");
				String er = scan.next();
			}
		} while (carP == 0);
		do {
			System.out.print("Set Van fee : ");
			try {
				vanP = scan.nextInt();
			} catch (InputMismatchException e) {
				System.out.println(" Invalid Arguments.");
				String er = scan.next();
			}
		} while (vanP == 0);
		do {
			System.out.print("Set Truck fee : ");
			try {
				truckP = scan.nextInt();
			} catch (InputMismatchException e) {
				System.out.println(" Invalid Arguments.");
				String er = scan.next();
			}
		} while (truckP == 0);

		// Class.forName("con.microsoft.jbdc.sqlserver.SQLServerDriver");
		Connection con = null;
		String conUrl = "jdbc:sqlserver://BIGGY-LAPTOP\\SQLEXPRESS;DatabaseName=DB_Project; user=sa;password=camtse57;";

		try {
			// ...
			con = DriverManager.getConnection(conUrl);
			Statement stmt = con.createStatement();
			String sql = null;

			sql = "DELETE FROM Bill";
			stmt.executeUpdate(sql);
			sql = "DELETE FROM Car";
			stmt.executeUpdate(sql);
			sql = "DELETE FROM Payment";
			stmt.executeUpdate(sql);

			stmt.setMaxRows(size);
			sql = "INSERT INTO Payment(Type , Fee) VALUES ('Car' , '" + carP + "')";
			stmt.executeUpdate(sql);
			sql = "INSERT INTO Payment(Type , Fee) VALUES ('Van' , '" + vanP + "')";
			stmt.executeUpdate(sql);
			sql = "INSERT INTO Payment(Type , Fee) VALUES ('Truck' , '" + truckP + "')";
			stmt.executeUpdate(sql);

			while (true) {
				boolean error = false;
				selection = menu();
				if (selection < 1 || selection > 6) {
					System.out.println(" Invalid Arguments.");
					error = true;
				}
				if (!error) {
					switch (selection) {

					case 1: {
						System.out.println(".......Check-In Process Starts.......");
						if (count != 0) {
							System.out.print(" Enter the car's License ID. : ");
							String licenseID = scan.next();
							
							String query = "SELECT * FROM Car WHERE LicenseID Like '" + licenseID + "'";
							ResultSet rs = stmt.executeQuery(query);
							rs.next();

							int scanType = 0;
							String type = null;
							do {
								System.out.println(" Enter the type of car\n 1.) Car\n 2.) Van\n 3.) Truck");
								System.out.print("  : ");
								try {
									scanType = scan.nextInt();
								} catch (InputMismatchException e) {
									String er = scan.next();
								}
								if (scanType == 1)
									type = "Car";
								else if (scanType == 2)
									type = "Van";
								else if (scanType == 3)
									type = "Truck";
								else
									System.out.println(" Invalid Arguments.");
							} while (scanType < 1 || scanType > 3);

							System.out.print(" Enter the brand of car : ");
							String carBrand = scan.next();

							System.out.print(" Enter the color of car : ");
							String carColor = scan.next();

							System.out.print(" Enter the car's owner name : ");
							String ownerName = scan.next();

							char[] chars = "ABCD0123456789".toCharArray();
							StringBuilder sb = new StringBuilder();
							Random random = new Random();
							for (int l = 0; l < 4; l++) {
								char c = chars[random.nextInt(chars.length)];
								sb.append(c);
							}

							carBillID = sb.toString();
							if (type.equals("Car")) {
								sql = "INSERT INTO Car(LicenseID , Type , Brand , Color) VALUES ('" + licenseID
										+ "' ,'Car', '" + carBrand + "' , '" + carColor + "')";
								stmt.executeUpdate(sql);
							} else if (type.equals("Van")) {
								sql = "INSERT INTO Car(LicenseID , Type , Brand , Color) VALUES ('" + licenseID
										+ "' ,'Van', '" + carBrand + "' , '" + carColor + "')";
								stmt.executeUpdate(sql);
							} else if (type.equals("Truck")) {
								sql = "INSERT INTO Car(LicenseID , Type , Brand , Color) VALUES ('" + licenseID
										+ "' ,'Truck', '" + carBrand + "' , '" + carColor + "')";
								stmt.executeUpdate(sql);
							}

							System.out.println("**************************************");
							System.out.println(" Car's Bill ID. : " + carBillID);

							sql = "INSERT INTO Bill(BillID , LicenseID , OwnerName , Fee) VALUES ('" + carBillID
									+ "' ,(SELECT LicenseID FROM Car WHERE LicenseID = '" + licenseID + "'), '"
									+ ownerName + "' , (SELECT Fee FROM Payment WHERE Type = '" + type + "'))";
							stmt.executeUpdate(sql);

							System.out.println();
							count--;

						} else {
							System.out.println(" \tSorry , Parking is full.");
						}
						break;
					}

					case 2: {
						System.out.println(".......Check-In Process Starts.......");
						if (count != size) {
							System.out.print(" Enter the car's Bill ID. : ");
							String scanBillID = scan.next();
							System.out.println("**************************************");
							String query = "SELECT * FROM Bill WHERE BillID Like '" + scanBillID + "'";
							ResultSet rs = stmt.executeQuery(query);
							rs.next();
							String BillID = rs.getString(1);
							String LicenseID = rs.getString(2);
							String OwnerName = rs.getString(3);
							String Fee = rs.getString(4);
							query = "SELECT * FROM Car WHERE LicenseID Like '" + LicenseID + "'";
							rs = stmt.executeQuery(query);
							rs.next();
							String Type = rs.getString(2);
							String Brand = rs.getString(3);
							String Color = rs.getString(4);
							System.out.println("Bill ID.\t|License ID.\t|Type\t|Brand\t|Color\t|Onwer Name\t|Payment");
							System.out.println(BillID + "\t\t|" + LicenseID + "\t\t|" + Type + "\t|" + Brand + "\t|"
									+ Color + "\t|" + OwnerName + "\t\t|" + Fee);
							System.out.println(" Thank you come again !!\n");
							count++;
							sql = "DELETE Bill WHERE BillID = '" + scanBillID + "'";
							stmt.executeUpdate(sql);
							sql = "DELETE Car WHERE LicenseID = '" + LicenseID + "'";
							stmt.executeUpdate(sql);
						} else {
							System.out.println(" \tParking is empty.");
						}

						System.out.println();
						break;
					}

					case 3: {
						System.out.println(".......Check the Slot Available Process Starts.......");
						if (count != 0) {
							System.out.println(" \tAvailable Slots No is : " + count);
							System.out.println();
						} else if (count == 0) {
							System.out.println(" \t\tParking is full.");
						}
						break;
					}

					case 4: {
						System.out.println(".......Generates Parking Report.......");
						System.out.println("Bill ID.\t|License ID.\t|Type\t|Brand\t|Color\t|Onwer Name\t|Payment");
						String query = "SELECT * FROM Report";
						ResultSet rs = stmt.executeQuery(query);
						while (rs.next()) {
							System.out.println(rs.getString(1) + "\t\t|" + rs.getString(2) + "\t\t|" + rs.getString(3)
									+ "\t|" + rs.getString(4) + "\t|" + rs.getString(5) + "\t|" + rs.getString(6)
									+ "\t\t|" + rs.getString(7));
						}
						if (count == size)
							System.out.println(" \tParking is empty.");
						System.out.println();
						break;
					}

					case 5: {
						do {
							System.out.print("Set maximum parking slots : ");
							try {
								size = scan.nextInt();
							} catch (InputMismatchException e) {
								System.out.println(" Invalid Arguments.");
								String er = scan.next();
							}
						} while (size == 0);

						count = size;

						do {
							System.out.print("Set Car fee : ");
							try {
								carP = scan.nextInt();
							} catch (InputMismatchException e) {
								System.out.println(" Invalid Arguments.");
								String er = scan.next();
							}
						} while (carP == 0);
						do {
							System.out.print("Set Van fee : ");
							try {
								vanP = scan.nextInt();
							} catch (InputMismatchException e) {
								System.out.println(" Invalid Arguments.");
								String er = scan.next();
							}
						} while (vanP == 0);
						do {
							System.out.print("Set Truck fee : ");
							try {
								truckP = scan.nextInt();
							} catch (InputMismatchException e) {
								System.out.println(" Invalid Arguments.");
								String er = scan.next();
							}
						} while (truckP == 0);

						stmt.setMaxRows(size);
						sql = "UPDATE Payment SET Type='Car' , Fee = '" + carP + "' WHERE Type='Car'";
						stmt.executeUpdate(sql);
						sql = "UPDATE Payment SET Type='Van' , Fee = '" + vanP + "' WHERE Type='Van'";
						stmt.executeUpdate(sql);
						sql = "UPDATE Payment SET Type='Truck' , Fee = '" + truckP + "' WHERE Type='Truck'";
						stmt.executeUpdate(sql);

						sql = "DELETE FROM Bill";
						stmt.executeUpdate(sql);
						sql = "DELETE FROM Car";
						stmt.executeUpdate(sql);

						stmt.setMaxRows(size);
						break;
					}

					case 6: {
						System.out.println(" Thank you come again !!\n");
						System.exit(1);
					}

					}

				}
			}

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
