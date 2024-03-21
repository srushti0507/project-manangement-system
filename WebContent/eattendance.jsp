<%@page import="java.time.LocalDate"%>
<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="eheader.jsp"></jsp:include>
<%
String month=String.format("%02d",LocalDate.now().getMonthValue());
String year=String.valueOf(LocalDate.now().getYear());
if(request.getParameter("month")!=null){
	int mm=Integer.parseInt(request.getParameter("month").split("-")[1]);
	int yy=Integer.parseInt(request.getParameter("month").split("-")[0]);
	month=String.format("%02d",mm);
	year=String.valueOf(yy);
}
%>
<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<button class="btn btn-success btn-sm float-right" data-target="#attendance" data-toggle="modal"><i class="fa fa-plus"></i> Mark Attendance</button>
        	<jsp:include page="msg.jsp"></jsp:include>
        	<form class="form-inline float-right">
        		<label class="mr-1">Select Month</label>
        		<input type="month" id="month" name="month" value="<%= year+"-"+month %>" class="form-control form-control-sm mr-1">
        		<button class="btn btn-success btn-sm mr-1">Filter</button>
        	</form>
        	<h4 class="p-2" style="border-bottom:2px solid green;">Attendance</h4>
        	<div class="form-row">
      		<div class="col-sm-5">
      			<table class="table">
      				<thead>
      					<tr>
      						<th>Project Name</th>
      						<th>Manager</th>
      						<th>Days</th>
      					</tr>
      				</thead>
      				<tbody>
      				<%
      				String pid=session.getAttribute("pid").toString();
      				String uid=session.getAttribute("id").toString();
					String sql="select id,title,mgrid from projects WHERE id=?";
					List<Map<String,String>> data=DbHelper.executeDQL(sql, pid);
					for(Map<String,String> row : data) { %>
      					<tr>
      						<th><%= row.get("title") %></th>
      						<th><%= TMHelper.getUserName(row.get("mgrid")) %></th>
      						<th><%= TMHelper.getEmployeeAttendance(uid,month,year) %> days</th>
      					</tr>
      					<% } %>
      				</tbody>
      			</table>
      		</div>
      		<div class="col-sm-7" id="details">
      			<table class="table table-sm">
      				<thead>
      					<tr>
      						<th>Date</th>
      						<th>Task Details</th>
      						<th>Hours</th>
      						<th>Status</th>
      					</tr>
      				</thead>
      				<tbody>
      				<%      				
      				sql="select * from attendance WHERE tid=? and month(adate)=? and year(adate)=? order by adate desc";
					List<Map<String,String>> adata=DbHelper.executeDQL(sql, uid,month,year);
					for(Map<String,String> row : adata) { %>
      					<tr>
      						<td><%= DbHelper.formatDate(row.get("adate")) %></td>
      						<td><%= row.get("progress") %></td>
      						<td><%= row.get("logtime") %>Hr.</td>
      						<td><% if(Integer.parseInt(row.get("approved"))==0) { %>
      						<span class="badge badge-primary">Unapproved</span>
      						<% } else if(Integer.parseInt(row.get("approved"))==1) { %>   
      						<span class="badge badge-success">Approved</span>
      						<% }  else { %>
      						<span class="badge badge-danger">Rejected</span>
      						<% } %>
      						</td>
      					</tr>
      					<% } %>
      				</tbody>
      			</table>
      		</div> 
      		</div> 	
        </div>
    </div>
</div>
<div class="modal fade" id="attendance">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="attendance">			
			<div class="modal-header">
				<h5>Mark Attendance</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">Date</label>
					<div class="col-sm-8">
					<input type="date" id="adate" required name="adate" class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Progress Details</label>
					<div class="col-sm-8">
					<input type="text" name="progress" class="form-control form-control-sm">
				</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Log Time</label>
					<div class="col-sm-8">
					<input type="number" min="1" max="12" name="logtime" maxlength="5" class="form-control form-control-sm">
				</div>
				</div> 				
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Attendance" class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<script>
var dd=new Date();
document.getElementById("adate").valueAsDate=dd;
document.getElementById("adate").setAttribute("max",dd.toISOString().slice(0, -14));
dd.setDate(dd.getDate()-6);
document.getElementById("adate").setAttribute("min",dd.toISOString().slice(0, -14));
</script>
<jsp:include page="footer.jsp"></jsp:include>