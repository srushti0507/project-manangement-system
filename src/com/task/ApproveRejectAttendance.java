package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/approvereject")
public class ApproveRejectAttendance extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ids=req.getParameter("ids");
		String type=req.getParameter("type");
		HttpSession session=req.getSession();
		try {
			if(type.equals("approve"))
				DbHelper.executeDML("UPDATE attendance SET approved=1 WHERE find_in_set(id,?)", ids);
			else
				DbHelper.executeDML("UPDATE attendance SET approved=2 WHERE find_in_set(id,?)", ids);
			
			session.setAttribute("msg", "Attendance stored successfully");
			
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
