package com.task;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import config.DbHelper;

@WebServlet("/adduser")
@MultipartConfig
public class AddUser extends HttpServlet {

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
		String role=req.getParameter("role");
		String desgn=req.getParameter("designation");
		String pwd=req.getParameter("pwd");
		String pid=req.getParameter("pid");
		System.out.println(pid);
		Part photo=req.getPart("photo");
		String filename="pics/NoImage.jpg";
		HttpSession session=req.getSession();
		
		try {
			if(photo!=null) {
				filename="pics/"+Calendar.getInstance().getTimeInMillis()+".jpg";
				String path=req.getServletContext().getRealPath("/");
				Files.copy(photo.getInputStream(), Paths.get(path,filename), StandardCopyOption.REPLACE_EXISTING);
			}
			
			DbHelper.executeDMLProc("call AddUser(?,?,?,?,?,?,?,?,?)", 
						uname,userid,gender,dob,filename,role,desgn,pwd,pid);
			
			session.setAttribute("msg", "User added successfully");
			
			if(session.getAttribute("role").equals("A")) {
				resp.sendRedirect("users.jsp");
			}else {
				resp.sendRedirect("employees.jsp");	
			}
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
