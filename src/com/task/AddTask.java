package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/addtask")
public class AddTask extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pid=req.getParameter("pid");
		String title=req.getParameter("title");
		String descr=req.getParameter("descr");
		String priority=req.getParameter("priority");
		String status=req.getParameter("status");
		String uid=req.getParameter("uid");
		
		System.out.println(uid);
		
		String role=req.getParameter("role");
		
		HttpSession session=req.getSession();
		
		try {
			
			DbHelper.executeDMLProc("call AddTask(?,?,?,?,?,?)", 
					title,descr,pid,priority,uid,status);
			
			session.setAttribute("msg", "Task added successfully");
			if(role.equals("A"))
				resp.sendRedirect("tasks.jsp?pid="+pid);
			else
				resp.sendRedirect("ptasks.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
