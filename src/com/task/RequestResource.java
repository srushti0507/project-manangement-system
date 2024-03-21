package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;
import config.TMHelper;

@WebServlet("/requestres")
public class RequestResource extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String type=req.getParameter("type");
		String details=req.getParameter("details");
		String uid=session.getAttribute("id").toString();
		String pid=session.getAttribute("pid").toString();
		
		try {
			DbHelper.executeDML("INSERT INTO resources(restype,details,uid,pid) VALUES(?,?,?,?)", type,details,uid,pid);
			
			session.setAttribute("msg", "Request saved successfully");
			
			resp.sendRedirect("eresources.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
