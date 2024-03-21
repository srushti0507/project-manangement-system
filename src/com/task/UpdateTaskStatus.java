package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/updatetaskstatus")
public class UpdateTaskStatus extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String tid=req.getParameter("tid");
		String pid=req.getParameter("pid");
		String priority=req.getParameter("priority");
		String status=req.getParameter("status");
		String time=req.getParameter("timespent");
		String uid=req.getParameter("uid");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDML("update tasks set uid=?,status=?,priority=?,timespent=ifnull(timespent,0)+? WHERE id=? and pid=?", 
					uid,status,priority,time,tid,pid);
			
			session.setAttribute("msg", "Task status updated successfully");
			
			resp.sendRedirect("taskdetails.jsp?id="+tid+"&pid="+pid);
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
