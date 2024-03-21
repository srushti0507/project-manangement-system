<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="eheader.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	<button class="btn btn-success btn-sm float-right" data-target="#req" data-toggle="modal"><i class="fa fa-plus"></i> Create Request</button>
			<h4 class="p-2" style="border-bottom:2px solid green;">Resource Requests</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Request Id</th>
						<th>Project</th>						
						<th>Resource Type</th>
						<th>Description</th>
						<th>Create Date</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String,String>> data=DbHelper.executeDQL("SELECT * FROM resources WHERE uid=?", session.getAttribute("id").toString());
					for(Map<String,String> row : data){
					%>
					<tr>
						<td><%= row.get("id") %></td>
						<td><%= TMHelper.getProjectName(row.get("pid")) %></td>
						<td><%= row.get("restype") %></td>
						<td><%= row.get("details") %></td>
						<td><%= DbHelper.formatDate(row.get("createdon")) %></td>
						<td><%= Integer.parseInt(row.get("status"))==1 ? "Approved":"Pending" %></td>
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