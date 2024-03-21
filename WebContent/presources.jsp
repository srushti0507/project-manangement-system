<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
			<h5 class="p-2" style="border-bottom:2px solid green;">Resource Requests - <%= TMHelper.getProjectName(session.getAttribute("pid").toString()) %></h5>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Request Id</th>
						<th>Project</th>
						<th>Employee Name</th>						
						<th>Resource Type</th>
						<th>Description</th>
						<th>Create Date</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%					
					List<Map<String,String>> data=DbHelper.executeDQL("SELECT r.* FROM resources r join projects p on r.pid=p.id WHERE p.mgrid=? and pid=?",
							session.getAttribute("id").toString(),session.getAttribute("pid").toString());
					for(Map<String,String> row : data){
					%>
					<tr>
						<td><%= row.get("id") %></td>
						<td><%= TMHelper.getProjectName(row.get("pid")) %></td>
						<td><%= TMHelper.getUserName((row.get("uid"))) %></td>
						<td><%= row.get("restype") %></td>
						<td><%= row.get("details") %></td>
						<td><%= row.get("createdon") %></td>
						<td><%= Integer.parseInt(row.get("status"))==1 ? "Approved":"Pending" %></td>
						<td>
						<% if(Integer.parseInt(row.get("status"))==0) { %>
						<a href="approveres?id=<%= row.get("id") %>" class="btn btn-primary btn-sm">Approve</a>
						<% } %>
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<div class="modal fade" id="req">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="requestres">
			<div class="modal-header">
				<h5>Request Resource</h5>
			</div>
			<div class="modal-body">			
				<div class="form-group">
					<label>Resource Type</label>
					<select class="form-control form-control-sm" name="type">
						<option>Hardware</option>
						<option>Software</option>
					</select>
				</div>				
				<div class="form-group">
					<label>Description</label>
					<input type="text" name="details" class="form-control form-control-sm">
				</div>						
			</div>
			<div class="modal-footer">
				<input type="submit" value="Submit Request" class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>