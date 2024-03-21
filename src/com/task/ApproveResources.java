package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/approveres")
public class ApproveResources extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id=req.getParameter("id");
		HttpSession session=req.getSession();
		try {			
			DbHelper.executeDML("UPDATE resources SET status=1 WHERE id=?", id);
			
			session.setAttribute("msg", "Resource approved successfully");
			resp.sendRedirect("presources.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
