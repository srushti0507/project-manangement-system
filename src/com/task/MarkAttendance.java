package com.task;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;
import config.TMHelper;

@WebServlet("/attendance")
public class MarkAttendance extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		
		String adate=req.getParameter("adate");
		String progress=req.getParameter("progress");
		String log=req.getParameter("logtime");
		String tid=session.getAttribute("id").toString();
		String pid=TMHelper.getEmployeeProjectId(tid);
		System.out.println(tid);
		
		try {
			Map<String,String> result=DbHelper.executeDQLReturnSingle("SELECT count(*) as count from attendance WHERE adate=? and tid=?", adate,tid);
			System.out.println(result);
			if(result.get("count").equals("1")) {
				session.setAttribute("error", "Attendance already marked");
			}else {
				DbHelper.executeDML("insert into attendance(adate,progress,logtime,tid,pid) values(?,?,?,?,?)", adate,progress,log,tid,pid);
				session.setAttribute("msg", "Attendance marked successfully");
			}
			resp.sendRedirect("eattendance.jsp");
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
