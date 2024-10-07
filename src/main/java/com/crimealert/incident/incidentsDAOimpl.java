package com.crimealert.incident;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Types;



import com.xadmin.usermanagement.model.User;

public class incidentsDAOimpl {
    private String jdbcURL = "jdbc:mysql://localhost:3306/teste";
    private String jdbcUsername = "root";
    private String jdbcPassword = "OUIAM";

    private static final String INSERT_USERS_SQL = "INSERT INTO incidents (description, localisation, date) VALUES (?, ?, ?);";
    private static final String SELECT_USER_BY_ID = "SELECT id, description, localisation,date FROM incidents WHERE id = ?";
    private static final String SELECT_ALL_USERS = "SELECT * FROM incidents";
    private static final String DELETE_USERS_SQL = "DELETE FROM incidents WHERE id = ?;";
    private static final String UPDATE_USERS_SQL = "UPDATE incidents SET description = ?, localisation = ?, date = ? WHERE id = ?;";

    public USerDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setString(1, user.getDescription());
            preparedStatement.setString(2, user.getLocalisation());
            preparedStatement.setTimestamp(3, new java.sql.Timestamp(user.getDate().getTime()));

            System.out.println(preparedStatement);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public User selectUser(int id) {
        User user = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)) {
            preparedStatement.setInt(1, id);
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String description = rs.getString("description");
                String localisation = rs.getString("localisation");

                // Assuming "incident_date" is the name of the column storing the date in the database
                String dateString = rs.getString("date");

                // Handling null or empty values
                Date date = null;
                if (dateString != null && !dateString.isEmpty()) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                    	date = dateFormat.parse(dateString);
                    } catch (ParseException e) {
                        e.printStackTrace();
                        // Handle the parsing exception as needed
                    }
                }

                user = new User(description, localisation, date);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return user;
    }


    public List<User> selectAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS)) {
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String description = rs.getString("description");
                String localisation = rs.getString("localisation");

                // Assuming "date" is the name of the column storing the date in the database
                Date date = rs.getDate("date"); // Use getDate to retrieve the date directly

                users.add(new User(id, description, localisation, date));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return users;
    }


    public boolean deleteUser(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_USERS_SQL)) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_USERS_SQL);) {
            statement.setString(1, user.getDescription());
            statement.setString(2, user.getLocalisation());

            // Check if the date is not null before setting the timestamp
            if (user.getDate() != null) {
                statement.setDate(3, new java.sql.Date(user.getDate().getTime()));
            } else {
                statement.setNull(3, Types.DATE);
            }

            statement.setInt(4, user.getId());

            System.out.println("updated User:" + statement);

            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }


    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
