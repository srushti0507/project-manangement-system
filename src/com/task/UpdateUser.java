package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/updateuser")
public class UpdateUser extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String userid=req.getParameter("email");
		String gender=req.getParameter("gender");
		String uname=req.getParameter("uname");
		String dob=req.getParameter("dob");
		String desgn=req.getParameter("designation");
		String pwd=req.getParameter("pwd");
		String id=req.getParameter("id");
		
		HttpSession session=req.getSession();
		
		try {
			
			
			DbHelper.executeDML("update users SET uname=?,email=?,gender=?,dob=?,designation=?,pwd=? WHERE id=?", 
					uname,userid,gender,dob,desgn,pwd,id);
			
			session.setAttribute("msg", "User updated successfully");
			if(session.getAttribute("role").equals("M")) {
				resp.sendRedirect("employees.jsp");
			}else {
				resp.sendRedirect("users.jsp");
			}
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
