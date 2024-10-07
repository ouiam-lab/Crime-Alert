
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;


/**
 * ControllerServlet.java
 * This servlet acts as a page controller for the application, handling all
 * requests from the user.
 * @email Ramesh Fadatare
 */
@WebServlet("/")

public class Incidenteservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private USerDAO userDAO;
	
	public void init() {
		userDAO = new USerDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		try {
			switch (action) {
			case "/new":
				showNewForm(request, response);
				break;
			case "/insert":
				insertUser(request, response);
				break;
			case "/delete":
				deleteUser(request, response);
				break;
			case "/edit":
				showEditForm(request, response);
				break;
			case "/update":
				updateUser(request, response);
				break;
			default:
				listUser(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}

	private void listUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<Incident> listUser = userDAO.selectAllIncidents();
		request.setAttribute("listUser", listUser);
		RequestDispatcher dispatcher = request.getRequestDispatcher("incidente -list.jsp");
		dispatcher.forward(request, response);
	}

	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("user-form.jsp");
		dispatcher.forward(request, response);
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Incident existingUser = userDAO.selectUser(id);
		RequestDispatcher dispatcher = request.getRequestDispatcher("user-form.jsp");
		request.setAttribute("user", existingUser);
		dispatcher.forward(request, response);

	}

	private void insertUser(HttpServletRequest request, HttpServletResponse response) 
	        throws SQLException, IOException {
	    String description = request.getParameter("description");
	    String localisation = request.getParameter("localisation");
	    
	    // Assuming "incident_date" is the name of the column storing the date in the database
	    String dateString = request.getParameter("date");

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

	    User newUser = new User(description, localisation, date);
	    userDAO.insertUser(newUser);
	    response.sendRedirect("list");
	}



	private void updateUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
	    int id = Integer.parseInt(request.getParameter("id"));
	    String description = request.getParameter("description");
	    String localisation = request.getParameter("localisation");

	    // Assuming "incident_date" is the name of the column storing the date in the database
	    String dateString = request.getParameter("date");

	    // Handling null or empty values
	    Date incidentDate = null;
	    if (dateString != null && !dateString.isEmpty()) {
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        try {
	            incidentDate = dateFormat.parse(dateString);
	        } catch (ParseException e) {
	            e.printStackTrace();
	            // Handle the parsing exception as needed
	        }
	    }

	    User user = new User(id, description, localisation, incidentDate);
	    userDAO.updateUser(user);
	    response.sendRedirect("list");
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		userDAO.deleteUser(id);
		response.sendRedirect("list");

	}

}