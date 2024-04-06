package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import dao.UsersDao;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		Users u=new Users();
		u.setUser_first_name(request.getParameter("fname"));
		u.setUser_last_name(request.getParameter("lname"));
		u.setUser_id(Long.parseLong(request.getParameter("id")));
		u.setUser_email(request.getParameter("email"));
		u.setUser_password(request.getParameter("password"));
		u.setUser_is_teacher(Integer.parseInt(request.getParameter("role")));
		
		System.out.println(u);
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		int f = dao.saveUser(u);
		PrintWriter out = response.getWriter();
		out.print(f);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
