<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
			<h4 class="p-2" style="border-bottom:2px solid green;">Project Report</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Project Title</th>
						<th>Manager</th>
						<th>Create Date</th>
						<th>Total Task</th>
						<th>Completed</th>
						<th>Progress</th>
						<th>Status</th>
						<th>Active</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String,String>> data=DbHelper.executeDQL("select count(t.pid) as total,p.id,p.title as ptitle,p.status,p.mgrid,p.createdon,p.active from tasks t right join projects p on p.id=t.pid WHERE 1=? group by p.id", "1");
					for(Map<String,String> row : data) { 
					int total=Integer.parseInt(row.get("total"));
					int completed=Integer.parseInt(TMHelper.getCompletedTask(row.get("id")));
					int progress=0;
					if(completed>0)
						progress=(completed*100)/total;
					%>
						<tr>
							<td><%= row.get("id") %></td>
							<td><%= row.get("ptitle") %></td>
							<td><%= TMHelper.getUserName(row.get("mgrid")) %></td>
							<td><%= DbHelper.formatDate(row.get("createdon")) %></td>
							<td><%= total %></td>
							<td><%= completed %></td>
							<td>
							<div class="progress">
							  <div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%= progress %>%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<small><%= progress %>% completed</small>
							</td>
							<td><%= TMHelper.getMasterName(row.get("status")) %></td>
							
							<td>
								<% if(Integer.parseInt(row.get("active"))==0) { %>
								<span class="badge badge-danger">Inactive</span>
								<%} else { %>
								<span class="badge badge-success">Active</span>
								<% } %>
							</td>
							
							<td><a href="tasks.jsp?pid=<%= row.get("id") %>" class="btn btn-primary btn-sm">Tasks</a></td>
						</tr>						
					<% } %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>