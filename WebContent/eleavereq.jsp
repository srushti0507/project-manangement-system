<%@page import="java.time.LocalDate"%>
<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="eheader.jsp"></jsp:include>
<%
String month=String.format("%02d",LocalDate.now().getMonthValue());
String year=String.valueOf(LocalDate.now().getYear());
String uid=session.getAttribute("id").toString();
String pid=session.getAttribute("pid").toString();
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
        	<button class="btn btn-success btn-sm float-right" data-target="#attendance" data-toggle="modal"><i class="fa fa-plus"></i> Make Request</button>
        	<jsp:include page="msg.jsp"></jsp:include>
        	<form class="form-inline float-right">
        		<label class="mr-1">Select Month</label>
        		<input type="month" id="month" name="month" value="<%= year+"-"+month %>" class="form-control form-control-sm mr-1">
        		<button class="btn btn-success btn-sm mr-1">Filter</button>
        	</form>
        	<h4 class="p-2" style="border-bottom:2px solid green;">Leave Request</h4>
        	<div class="form-row">      		
      		<div class="col-sm-7" id="details">
      			<table class="table table-sm">
      				<thead>
      					<tr>
      						<th>From Date</th>
      						<th>To Date</th>
      						<th>Reason</th>
      						<th>Status</th>
      					</tr>
      				</thead>
      				<tbody>
      				<%      				
      				String sql="select * from leaves WHERE uid=? and month(fromdate)=? and year(fromdate)=? order by fromdate desc";
					List<Map<String,String>> adata=DbHelper.executeDQL(sql, uid,month,year);
					for(Map<String,String> row : adata) { %>
      					<tr>
      						<td><%= DbHelper.formatDate(row.get("fromdate")) %></td>
      						<td><%= DbHelper.formatDate(row.get("todate")) %></td>
      						<td><%= row.get("reason") %></td>
      						<td><% if(Integer.parseInt(row.get("approved"))==0) { %>
      						<span class="badge badge-primary">Pending</span>
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
		<form class="modal-content" method="post" action="leaverequest">			
			<div class="modal-header">
				<h5>Leave Request</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">Leave From</label>
					<div class="col-sm-8">
					<input type="date" id="fromdate" required name="fromdate" class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Leave To</label>
					<div class="col-sm-8">
					<input type="date" id="todate" required name="todate" class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Reason</label>
					<div class="col-sm-8">
					<input type="text" name="reason" class="form-control form-control-sm">
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
document.getElementById("fromdate").valueAsDate=dd;
document.getElementById("todate").valueAsDate=dd;
dd.setDate(dd.getDate()-6);
document.getElementById("fromdate").setAttribute("min",dd.toISOString().slice(0, -14));
document.getElementById("todate").setAttribute("min",dd.toISOString().slice(0, -14));
</script>
<jsp:include page="footer.jsp"></jsp:include>