<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>
<%
String cat=request.getParameter("cat")==null ? "all" : request.getParameter("cat");
String query="SELECT distinct catname from masters WHERE 1=?";
List<Map<String,String>> cats=DbHelper.executeDQL(query, "1");
List<Map<String,String>> data=DbHelper.executeDQL("select * from masters WHERE catname=?",request.getParameter("cat"));
String id=request.getParameter("id");
String mname="";
String status="";
if(id!=null){
	for(Map<String,String> master: data){
		if(master.get("id").equals(id)){
			mname=master.get("mastername");
			status=master.get("active");
		}
	}
}
%>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	<div class="row">
        	<div class="col-sm-8">
        	<div class="form-inline float-right">
        		<label class="mr-1">Select Master</label>
        		<select name="cat" class="form-control form-control-sm mr-1" onchange="filterme(this)">
       				<option value="">-- Select Category --</option>
       				<% for(Map<String,String> row : cats) { %>
   					<option <%= cat.equals(row.get("catname")) ? "selected" : ""  %>><%= row.get("catname") %></option>
   					<% } %>
        		</select>
        	</div>
        	<h4 class="p-2" style="border-bottom:2px solid green;">Masters</h4>
			<table class="table table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Category</th>
						<th>Master Name</th>
						<th>Status</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					
					for(Map<String,String> row : data) { %>
						<tr>
							<td><%= row.get("id") %></td>
							<td><%= row.get("catname") %></td>
							<td><%= row.get("mastername") %></td>
							<td>
							<% if(Integer.parseInt(row.get("active"))==1) { %>
							<span class="badge badge-success p-1">active</span>
							<% } else { %>
							<span class="badge badge-danger p-1">inactive</span> 
							<% }%>
							</td>
							<td>
								<a href="masters.jsp?cat=<%= row.get("catname") %>&id=<%= row.get("id") %>" class="btn btn-primary btn-sm">Edit</a>
							</td>
						</tr>											
					<% } %>
				</tbody>
			</table>
        	</div>
        	<div class="col-sm-4">
        		<h5 class="p-2 text-center">Create Master</h5>
        		<form method="post" action="savemaster">
        			<%
        			if(id!=null){ %>
        			<input type="hidden" name="id" value="<%= id %>">	
        		<% }
        			%>
        			<div class="form-group form-row">
        				<label class="col-sm-4">Select Category</label>
        				<div class="col-sm-8">
        				<select name="catname" required class="form-control form-control-sm">
        					<option value="">-- Select Category --</option>
        					<% for(Map<String,String> scat : cats) { %>
        					<option <%= scat.get("catname").equals(cat) ? "selected":"" %>><%= scat.get("catname") %></option>
        					<% } %>        					
        				</select>
        				</div>
        			</div>
        			<div class="form-group form-row">
        				<label class="col-sm-4">Master Name</label>
        				<div class="col-sm-8">
        				<input type="text" name="mastername" value="<%= mname %>" class="form-control form-control-sm">
        				</div>
        			</div>
        			<div class="form-group form-row">
        				<label for="active" class="col-sm-4">Active</label>
        				<div class="col-sm-8">
        				<input type="checkbox" id="active" <%= status.equals("1") ? "checked":"" %> name="active" value="1" class="form-control form-control-sm">
        				</div>
        			</div>
        			<input type="submit" value="Save Master" class="btn btn-success btn-sm">
        		</form>
        	</div>
        	</div>
			
        </div>
    </div>
</div>
<script>
function filterme(mm){
	location.href="masters.jsp?cat="+mm.value;
}
</script>
<jsp:include page="footer.jsp"></jsp:include>