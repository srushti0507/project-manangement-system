package com.task;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import config.DbHelper;

@WebServlet("/processleave")
public class ProcessLeaveRequest extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ids=req.getParameter("ids");
		String type=req.getParameter("type");
		HttpSession session=req.getSession();
		String sql="";
		try {
			if(type.equals("approve")) {
				DbHelper.executeDML("UPDATE leaves SET approved=1 WHERE find_in_set(id,?)", ids);
				sql="insert into attendance(adate,progress,logtime,tid,pid,approved) "
						+ "SELECT fromdate,'On Leave',0,uid,(select pid from users WHERE id=uid limit 1),1 from leaves "
						+ "WHERE find_in_set(id,?)";
				DbHelper.executeDML(sql, ids);
			}
			else {
				DbHelper.executeDML("UPDATE leaves SET approved=2 WHERE find_in_set(id,?)", ids);
				sql="insert into attendance(adate,progress,logtime,tid,pid,approved) "
						+ "SELECT fromdate,'Absent',0,uid,(select pid from users WHERE id=uid limit 1),1 from leaves "
						+ "WHERE find_in_set(id,?)";
				DbHelper.executeDML(sql, ids);
			}
			session.setAttribute("msg", "Leaves stored successfully");
			
		}
		catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
	}
}
