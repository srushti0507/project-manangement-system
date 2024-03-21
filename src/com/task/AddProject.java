package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/addproject")
public class AddProject extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String title=req.getParameter("title");
		String abbr=req.getParameter("abbr");
		String descr=req.getParameter("descr");
		String startdt=req.getParameter("startdt");
		String enddt=req.getParameter("enddt");
		String mgrid=req.getParameter("mgrid");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("insert into projects(title,abbr,description,startdt,enddt,mgrid,status) values(?,?,?,?,?,?,?)", 
					title,abbr,descr,startdt,enddt,mgrid,"19");
			
			session.setAttribute("msg", "Project added successfully");
			
			resp.sendRedirect("projects.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
