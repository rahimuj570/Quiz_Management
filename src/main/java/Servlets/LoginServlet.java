package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UsersDao;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		Users u = null;
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		if (request.getParameter("email_id").contains("@")) {
			u = dao.getUser("email", request.getParameter("email_id"), request.getParameter("password"));
		} else {
			u = dao.getUser("id", request.getParameter("email_id"), request.getParameter("password"));
		}
		HttpSession s = request.getSession();
		if (u == null) {
			s.setAttribute("user404", "User not found!");
			response.sendRedirect("login.jsp");
		} else if (u.getUser_is_approved() == 0) {
			s.setAttribute("not-approved", "Your account is not approved yet!");
			response.sendRedirect("login.jsp");
		} else {
			s.setAttribute("current_user", u);
			if (u.getUser_is_teacher() == 1) {
				response.sendRedirect(request.getContextPath() + "/teacher/dashboard.jsp");
			} else if (u.getUser_is_admin() == 1) {
				response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
			} else {
				response.getWriter().append("dashboard");
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
