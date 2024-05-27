package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

import dao.UsersDao;
import dao.VerifyPinsDao;
import entities.Users;
import entities.VerifyPin;
import helper.ConnectionProvider;
import helper.GEmailSender;
import helper.GeneratePinCode;

/**
 * Servlet implementation class ForgotePasswordSentCodeServlet
 */
public class ForgotePasswordSentCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotePasswordSentCodeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
		System.out.println(email);
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		Users u = dao.getUserByEmail(email);
		HttpSession sc =request.getSession();
		VerifyPinsDao pinsDao = new VerifyPinsDao(ConnectionProvider.main());
		if(u.getUser_email()==null) {
			sc.setAttribute("user404", "User Not Found!");
			response.sendRedirect("reset_password.jsp");
		}else if(u.getUser_is_approved()==0) {
			sc.setAttribute("not-approved", "Account is not Approved by Admin yet!");
			response.sendRedirect("reset_password.jsp");
		}else {
			VerifyPinsDao pinDao = new VerifyPinsDao(ConnectionProvider.main());
			VerifyPin vpin = pinDao.getVerifyCode(u.getUser_id());
			
			if(vpin.getPin_code()==null) {
				//sent pin
				VerifyPin verify_pin = new VerifyPin();
				verify_pin.setPin_code(GeneratePinCode.getCode());
				verify_pin.setUser_id(u.getUser_id());
				verify_pin.setIs_for_reset_password(1);
				GEmailSender gEmailSender = new GEmailSender();
				boolean f=false;
				//f = gEmailSender.sendEmail(u.getUser_email().strip(), "rujr2002@gmail.com", "Account Verification Code for QuizeManagement", "Your varification code is this 6 characters =>  " + verify_pin.getPin_code()+"\n   (This code will expire in 10 minutes.)");
				pinsDao.saveVerifyCode(verify_pin);
				if(f) {
					sc.setAttribute("sent_forgot_pass", "Check Your Email!");
					response.sendRedirect("reset_password.jsp");
				}else {
					sc.setAttribute("something_wrong", "Something Went Wrong!");
					response.sendRedirect("reset_password.jsp");
				}
			}else {
				if(vpin.getIs_for_reset_password()==1 && !vpin.getExpire_date().before(new Date())) {
					sc.setAttribute("already_sent_forgot_pass", "Already Sent Your PIN!");
					response.sendRedirect("reset_password.jsp");
				}
				else{
					if(vpin.getIs_for_reset_password()==1 && vpin.getExpire_date().before(new Date())){
						pinsDao.deleteVerifyCode(vpin.getUser_id(), 1);
					}
					//sent pin
					VerifyPin verify_pin = new VerifyPin();
					verify_pin.setPin_code(GeneratePinCode.getCode());
					verify_pin.setUser_id(u.getUser_id());
					verify_pin.setIs_for_reset_password(1);
					GEmailSender gEmailSender = new GEmailSender();
					boolean f=false;
					//f = gEmailSender.sendEmail(u.getUser_email().strip(), "rujr2002@gmail.com", "Account Verification Code for QuizeManagement", "Your varification code is this 6 characters =>  " + verify_pin.getPin_code()+"\n   (This code will expire in 10 minutes.)");
					pinsDao.saveVerifyCode(verify_pin);
					if(f) {
						sc.setAttribute("sent_forgot_pass", "Check Your Email!");
						response.sendRedirect("reset_password.jsp");
					}
					sc.setAttribute("something_wrong", "Something Went Wrong!");
					response.sendRedirect("reset_password.jsp");
				}
			}
			System.out.println(vpin);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
