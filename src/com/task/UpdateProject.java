package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/updateproject")
public class UpdateProject extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String title=req.getParameter("title");
		String abbr=req.getParameter("abbr");
		String descr=req.getParameter("descr");
		String pid=req.getParameter("pid");
		String enddt=req.getParameter("enddt");
		String status=req.getParameter("status");
		String mgrid=req.getParameter("mgrid");
		
		HttpSession session=req.getSession();
		
		String role=session.getAttribute("role").toString();
		
		try {
			if(mgrid==null) {
			DbHelper.executeDML("UPDATE projects SET title=?,abbr=?,description=?,enddt=?,status=? WHERE id=?", 
					title,abbr,descr,enddt,status,pid);
			} else {
				DbHelper.executeDML("UPDATE projects SET title=?,abbr=?,description=?,enddt=?,status=?,mgrid=? WHERE id=?", 
						title,abbr,descr,enddt,status,mgrid,pid);
			}
			session.setAttribute("msg", "Project updated successfully");
			System.out.println(mgrid);
			if(role.equals("A")) {
				resp.sendRedirect("projects.jsp");
			}else {
				resp.sendRedirect("pprojects.jsp");
			}
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
