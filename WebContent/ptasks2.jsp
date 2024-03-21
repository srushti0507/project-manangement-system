<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	<a href="" class="btn btn-success btn-sm float-right" data-target="#addpro" data-toggle="modal"><i class="fa fa-plus"></i> Add Task</a>
			<h4 class="p-2" style="border-bottom:2px solid green;">Tasks</h4>
			<table class="table table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Task Title</th>
						<th>Project</th>
						<th>Status</th>
						<th>Priority</th>
						<th>Assignee</th>
						<th>Created Date</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String,String>> data=DbHelper.executeDQL("select t.id,t.title,p.title as ptitle,t.status,t.uid,t.priority,p.abbr,t.createdon from tasks t join projects p on t.pid=p.id WHERE 1=?", "1");
					for(Map<String,String> row : data) { %>
						<tr class="<%= row.get("status").equals("Done") ? "table-success font-weight-bold":"" %>">
							<td><%= row.get("abbr") %>-<%= row.get("id") %></td>
							<td><%= row.get("title") %></td>
							<td><%= row.get("ptitle") %></td>
							<td><%= row.get("status") %></td>
							<td><%= row.get("priority") %></td>
							<td><%= TMHelper.getUserName(row.get("uid")) %></td>
							<td><%= row.get("createdon") %></td>
							<td><a href="taskdetails.jsp?id=<%= row.get("id") %>" class="btn btn-primary btn-sm">View</a></td>
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
			<div class="modal-header">
				<h5>Add Task</h5>
			</div>
			<div class="modal-body">
			<div class="form-group">
					<label>Select Project</label>
					<select name="pid" required class="form-control form-control-sm">
						<option value="">Select Project</option>
						<%
						List<Map<String,String>> projs=DbHelper.executeDQL("SELECT id,title FROM projects where 1=?", "1");
						for(Map<String,String> map : projs){
						%>
						<option value="<%= map.get("id") %>"><%= map.get("title") %></option>
						<% } %>
					</select>
				</div>
				<div class="form-group">
					<label>Task Title</label>
					<input type="text" name="title" class="form-control form-control-sm">
				</div>				
				<div class="form-group">
					<label>Description</label>
					<textarea name="descr" rows="4" class="form-control form-control-sm"></textarea>
				</div>
				<div class="form-group">
					<label>Priority</label>
					<select name="priority" class="form-control form-control-sm">
						<option>Highest</option>
						<option>High</option>
						<option selected>Medium</option>
						<option>Low</option>
					</select>
				</div>
				<div class="form-group">
					<label>Status</label>
					<select name="status" class="form-control form-control-sm">
						<option selected>To Do</option>
						<option>Backend Development</option>
						<option>Frontend Development</option>
						<option>Bug Fixes</option>
						<option>In Progress</option>
						<option>Development Done</option>
						<option>QA Testing</option>
						<option>Frontend Integration</option>
						<option>Testing on Client</option>
						<option>Done</option>
					</select>
				</div>
				<div class="form-group">
					<label>Assignee</label>
					<select name="uid" required class="form-control form-control-sm">
						<option value="">Select Assignee</option>
						<%
						List<Map<String,String>> mgrs=DbHelper.executeDQL("SELECT id,uname,designation FROM users WHERE role!=? and id in(select uid from team WHERE pid in(SELECT pid from projects where mgrid=?))", "A",session.getAttribute("id").toString());
						for(Map<String,String> map : mgrs){
						%>
						<option value="<%= map.get("id") %>"><%= map.get("uname") %> - <%= map.get("designation") %></option>
						<% } %>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Task" class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>