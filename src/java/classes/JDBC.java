package classes;

import java.sql.*;
import java.util.ArrayList;

public class JDBC {

    private Connection con;
    private Statement stmt;
    private boolean isConnected;
    private String message;

    public void connect() {
        String dbname = "db_coin";
        String username = "root";
        String password = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                    + dbname, username, password);
            stmt = con.createStatement();
            isConnected = true;
            message = "DB connected";
        } catch (Exception e) {
            isConnected = false;
            message = e.getMessage();
        }
    }

    private void disconnect() {
        try {
            stmt.close();
            con.close();
        } catch (Exception e) {
            message = e.getMessage();
        }
    }

    public void runQuery(String query) {
        try {
            connect();
            int result = stmt.executeUpdate(query);
            message = "info: " + result + " rows affected";
        } catch (Exception e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public ArrayList<ArrayList<Object>> query(String query) {
        ArrayList<ArrayList<Object>> result = new ArrayList<>();
        try {
            connect(); // koneksi ke database
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                ArrayList<Object> row = new ArrayList<>();
                for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                    row.add(rs.getObject(i));
                }
                result.add(row);
            }
        } catch (SQLException e) {
            System.out.println("Query error: " + e.getMessage());
        } finally {
            disconnect(); // tutup koneksi
        }
        return result;
    }
}
