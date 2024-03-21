<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>
<style>
.card-body{
	padding:10px !important;
}

</style>
<%
	String pid=session.getAttribute("pid").toString();
	String user=session.getAttribute("uname").toString();
	String uid=session.getAttribute("id").toString();
	String sql="select id,title,status,uid,priority,createdon from tasks WHERE pid=? and status=?";
	
	List<Map<String,String>> todo=DbHelper.executeDQL(sql, pid,"6");
	List<Map<String,String>> testing=DbHelper.executeDQL(sql, pid,"12");
	List<Map<String,String>> inprogress=DbHelper.executeDQL(sql, pid,"8");
	List<Map<String,String>> done=DbHelper.executeDQL(sql, pid,"14");
%>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	
			<h4 class="p-2" style="border-bottom:2px solid green;">Tasks - <%= TMHelper.getProjectName(pid) %></h4>
			
			<div class="form-row">
				<div class="col-sm-3">
					<div class="card shadow">
						<div class="card-header">
							<h6>To Do</h6>
						</div>
						<div class="card-body">
						<%
						for(Map<String,String> row : todo) { %>
							<div class="card shadow">
								<div class="card-body">
									<h6><%= row.get("title") %></h6>
									Assignee: <%= TMHelper.getUserName(row.get("uid")) %>									
								</div>
								<div class="card-footer font-weight-bold <%= TMHelper.getPriorityColor(row.get("priority")) %>">
									Priority: <%= TMHelper.getMasterName(row.get("priority")) %>
								</div>
							</div>
						<% }%>
						</div>
						<div class="card-footer">
							<small>Total Items : <%= todo.size() %></small>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
				<div class="card shadow">
						<div class="card-header">
							<h6>In Progress</h6>
						</div>
						<div class="card-body">
						<%
						for(Map<String,String> row : inprogress) { %>
							<div class="card shadow">
								<div class="card-body">
									<h6><%= row.get("title") %></h6>
									Assignee: <%= TMHelper.getUserName(row.get("uid")) %>
								</div>
								<div class="card-footer font-weight-bold <%= TMHelper.getPriorityColor(row.get("priority")) %>">
									Priority: <%= TMHelper.getMasterName(row.get("priority")) %>
								</div>
							</div>
						<% }%>
						</div>
						<div class="card-footer">
							<small>Total Items : <%= inprogress.size() %></small>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
				<div class="card shadow">
						<div class="card-header">
							<h6>In Testing</h6>
						</div>
						<div class="card-body">
						<%
						for(Map<String,String> row : testing) { %>
							<div class="card shadow">
								<div class="card-body">
									<h6><%= row.get("title") %></h6>
									Assignee: <%= TMHelper.getUserName(row.get("uid")) %>
								</div>
								<div class="card-footer font-weight-bold <%= TMHelper.getPriorityColor(row.get("priority")) %>">
									Priority: <%= TMHelper.getMasterName(row.get("priority")) %>
								</div>
							</div>
						<% }%>
						</div>
						<div class="card-footer">
							<small>Total Items : <%= testing.size() %></small>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
				<div class="card shadow">
						<div class="card-header">
							<h6>Done</h6>
						</div>
						<div class="card-body">
						<%
						for(Map<String,String> row : done) { %>
							<div class="card shadow">
								<div class="card-body">
									<h6><%= row.get("title") %></h6>
									Assignee: <%= TMHelper.getUserName(row.get("uid")) %>
								</div>
								<div class="card-footer font-weight-bold <%= TMHelper.getPriorityColor(row.get("priority")) %>">
									Priority: <%= TMHelper.getMasterName(row.get("priority")) %>
								</div>
							</div>
						<% }%>
						</div>
						<div class="card-footer">
							<small>Total Items : <%= done.size() %></small>
						</div>
					</div>
				</div>
			</div>			
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>