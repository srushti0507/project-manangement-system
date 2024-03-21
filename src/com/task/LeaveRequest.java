package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/leaverequest")
public class LeaveRequest extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		
		String fromdate=req.getParameter("fromdate");
		String todate=req.getParameter("fromdate");
		String reason=req.getParameter("reason");
		String uid=session.getAttribute("id").toString();
		
		try {
			DbHelper.executeDML("insert into leaves(fromdate,todate,reason,uid) values(?,?,?,?)", 
					fromdate,todate,reason,uid);
			session.setAttribute("msg", "Leave requested successfully");
			resp.sendRedirect("eleavereq.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
