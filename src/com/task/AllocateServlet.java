package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/allocate")
public class AllocateServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pid=req.getParameter("pid");
		String uid=req.getParameter("uid");
		String startdt=req.getParameter("startdt");
		String enddt=req.getParameter("enddt");
		
		HttpSession session=req.getSession();
		
		try {
			DbHelper.executeDML("INSERT INTO team(pid,uid,startdt,enddt) value(?,?,?,?)", pid,uid,startdt,enddt);
			session.setAttribute("msg", "Allocated successfully");
			resp.sendRedirect("allocation.jsp?pid="+pid);
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
