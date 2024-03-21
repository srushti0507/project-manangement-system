<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>
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
						<th>Total Task</th>
						<th>Task completed</th>
						<th>Progress</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String,String>> data=DbHelper.executeDQL("select count(t.id) as total,p.id,p.title as ptitle,p.status,p.mgrid from tasks t right join projects p on p.id=t.pid WHERE p.mgrid=? group by t.pid", session.getAttribute("id").toString());
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
							<td><%= total %></td>
							<td><%= completed %></td>
							<td>
							<div class="progress">
							  <div class="progress-bar progress-bar-striped" role="progressbar" style="width: <%= progress %>%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<small><%= progress %>% completed</small>
							</td>
							<td><%= TMHelper.getUserName(row.get("mgrid")) %></td>
							<td><a href="ptasks.jsp" class="btn btn-primary btn-sm">View</a></td>
						</tr>						
					<% } %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>