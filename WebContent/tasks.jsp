<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>
<style>
.form-inline .bootstrap-select, .form-inline .bootstrap-select.form-control:not([class*=col-]) {
    min-width: 140px;
}
</style>
<%
	String pid=request.getParameter("pid");
	String uid=request.getParameter("assignee")==null ? "0" : request.getParameter("assignee");
	String pr=request.getParameter("priority")==null ? "0" : request.getParameter("priority");
	String st=request.getParameter("status")==null ? "0" : request.getParameter("status");
	String sql="select id,title,status,uid,priority,createdon,timespent,taskid from tasks WHERE pid=?";
	if(!uid.equals("0"))
		sql+=" and uid='"+uid+"'";
	if(!pr.equals("0"))
		sql+=" and priority='"+pr+"'";
	if(!st.equals("0"))
		sql+=" and status='"+st+"'";
	List<Map<String,String>> data=DbHelper.executeDQL(sql, pid);
%>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	
        	<button class="btn btn-success btn-sm float-right" data-target="#addpro" data-toggle="modal"><i class="fa fa-plus"></i> Add Task</button>
        	
        	<form class="float-right form-inline mr-2">
        		<input type="hidden" name="pid" value="<%= pid %>">
				<label class="mr-2">Filter</label>
				<select name="priority" class="form-control form-control-sm mr-2 selectpicker" data-style="btn-primary">
					<option value="0">All Priority</option>
					<% 
					List<Map<String,String>> pdata=TMHelper.getMastersList("Priority");
					for(Map<String,String> pp : pdata){
					%>
					<option <%= pr.equals(pp.get("id"))?"selected":"" %> value="<%= pp.get("id") %>"><%= pp.get("mastername") %></option>
					<% } %>
				</select>
				<select name="assignee" class="form-control form-control-sm mr-2 selectpicker" data-style="btn-primary">
					<option value="0">All Assignee</option>
					<% 
					List<Map<String,String>> adata=TMHelper.getEmployeesList(pid);
					for(Map<String,String> pp : adata){
					%>
					<option <%= uid.equals(pp.get("id"))?"selected":"" %> value="<%= pp.get("id") %>"><%= pp.get("uname") %></option>
					<% } %>
				</select>
				<select name="status" class="form-control form-control-sm mr-2 selectpicker" data-style="btn-primary">
					<option value="0">All Status</option>
					<% 
					List<Map<String,String>> sdata=TMHelper.getMastersList("Task Status");
					for(Map<String,String> pp : sdata){
					%>
					<option <%= st.equals(pp.get("id"))?"selected":"" %> value="<%= pp.get("id") %>"><%= pp.get("mastername") %></option>
					<% } %>
				</select>
				<input type="submit" value="Filter" class="btn btn-success btn-sm">
			</form>
        	
			<h4 class="p-2" style="border-bottom:2px solid green;">Tasks - <%= TMHelper.getProjectName(request.getParameter("pid")) %></h4>
			
			
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Task Id</th>
						<th>Task Title</th>
						<th>Status</th>
						<th>Priority</th>
						<th>Assignee</th>
						<th>Time Spent</th>
						<th>Create Date</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					
					for(Map<String,String> row : data) { %>
						<tr class="<%= row.get("status").equals("14") ? "table-success font-weight-bold":"" %>">
							<td><%= row.get("taskid") %></td>
							<td><%= row.get("title") %></td>
							<td><%= TMHelper.getMasterName(row.get("status")) %></td>
							<td><%= TMHelper.getMasterName(row.get("priority")) %></td>
							<td><%= TMHelper.getUserName(row.get("uid")) %></td>
							<td><% if(row.get("timespent")!=null) { %> <%= row.get("timespent") %>hrs <% } %></td>
							<td><%= DbHelper.formatDate(row.get("createdon")) %></td>
							<td><a href="taskdetails.jsp?id=<%= row.get("id") %>&pid=<%= pid %>" class="btn btn-primary btn-sm">View</a></td>
						</tr>						
					<% } %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<div class="modal fade" id="addpro">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="addtask">
		<input type="hidden" name="role" value="<%= session.getAttribute("role") %>">
		<input type="hidden" name="pid" value="<%= pid %>">
			<div class="modal-header">
				<h5>Add Task - <%= TMHelper.getProjectName(pid) %></h5>
			</div>
			<div class="modal-body">			
				<div class="form-group form-row">
					<label class="col-sm-4">Task Title</label>
					<div class="col-sm-8">
					<input type="text" name="title" class="form-control form-control-sm">
				</div>
				</div>				
				<div class="form-group form-row">
					<label class="col-sm-4">Description</label>
					<div class="col-sm-8">
					<textarea name="descr" rows="4" class="form-control form-control-sm"></textarea>
				</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Priority</label>
					<div class="col-sm-8">
					<select name="priority" class="form-control form-control-sm">
						<%
						for(Map<String,String> row:TMHelper.getMastersList("Priority")) {
						%>
						<option value="<%= row.get("id") %>"><%= row.get("mastername") %></option>
						<% } %>
					</select>
				</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Status</label>
					<div class="col-sm-8">
					<select name="status" class="form-control form-control-sm">
						<%
						for(Map<String,String> row:TMHelper.getMastersList("Task Status")) {
						%>
						<option value="<%= row.get("id") %>"><%= row.get("mastername") %></option>
						<% } %>
					</select>
				</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Assignee</label>
					<div class="col-sm-8">
					<select name="uid" required class="form-control form-control-sm">
						<option value="">Select Assignee</option>
						<%
						List<Map<String,String>> mgrs=DbHelper.executeDQL("SELECT id,uname,designation FROM users WHERE pid=?", pid);
						for(Map<String,String> map : mgrs){
						%>
						<option value="<%= map.get("id") %>"><%= map.get("uname") %> - <%= map.get("designation") %></option>
						<% } %>
					</select>
				</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Task" class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>