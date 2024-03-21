package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/savecomment")
public class AddComment extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String tid=req.getParameter("tid");
		String pid=req.getParameter("pid");
		String uid=session.getAttribute("id").toString();
		String comment=req.getParameter("comment");
		
		try {
			DbHelper.executeDML("INSERT into comments(tid,pid,uid,comment) VALUES(?,?,?,?)", tid,pid,uid,comment);
			
			session.setAttribute("msg", "Comment added to task");
			
			resp.sendRedirect("taskdetails.jsp?id="+tid+"&pid="+pid);
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
