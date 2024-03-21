package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/savemaster")
public class AddMaster extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String catname=req.getParameter("catname");
		String mastername=req.getParameter("mastername");
		String id=req.getParameter("id");
		String active=req.getParameter("active")==null ? "0" : "1";
		HttpSession session=req.getSession();
		
		try {
			
			if(id!=null) {
				DbHelper.executeDML("update masters set catname=?,mastername=?,active=? WHERE id=?",catname,mastername,active,id);
				session.setAttribute("msg", "Master updated successfully");
			}else {
				DbHelper.executeDML("insert into masters(catname,mastername,active) values(?,?,?)",catname,mastername,active);			
				session.setAttribute("msg", "Master added successfully");
			}
			resp.sendRedirect("masters.jsp?cat="+catname);
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
