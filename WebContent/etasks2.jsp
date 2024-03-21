<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="eheader.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
			<h4 class="p-2" style="border-bottom:2px solid green;">Tasks</h4>
			<table class="table table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Task Title</th>
						<th>Project</th>
						<th>Status</th>
						<th>Priority</th>
						<th>Create Date</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String,String>> data=DbHelper.executeDQL("select t.id,t.title,p.title as ptitle,t.status,t.uid,t.priority,p.abbr,t.createdon from tasks t join projects p on t.pid=p.id WHERE t.uid=? and t.status!='Done'", session.getAttribute("id").toString());
					for(Map<String,String> row : data) { %>
						<tr>
							<td><%= row.get("abbr") %>-<%= row.get("id") %></td>
							<td><%= row.get("title") %></td>
							<td><%= row.get("ptitle") %></td>
							<td><%= row.get("status") %></td>
							<td><%= row.get("priority") %></td>
							<td><%= row.get("createdon") %></td>
							<td>
								<a href="taskdetails.jsp?id=<%= row.get("id") %>" class="btn btn-primary btn-sm">View</a>
							</td>
						</tr>											
					<% } %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>