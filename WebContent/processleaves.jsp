<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	<button id="approve" class="btn btn-success btn-sm float-right">Approve</button>
        	<button id="reject" class="btn btn-danger btn-sm float-right mr-2">Reject</button>
			<h5 class="p-2" style="border-bottom:2px solid green;">Leave Request Process - <%= TMHelper.getProjectName(session.getAttribute("pid").toString()) %></h5>
			<table class="table table-sm">
				<thead>
					<tr>
						<th><input type="checkbox" id="all" name="all" value="1"></th>
						<th>Request Date</th>
						<th>Employee Name</th>
						<th>From Date</th>
						<th>To Date</th>
						<th>Reason</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Map<String,String>> data=DbHelper.executeDQL("select * from leaves WHERE approved=? order by id desc", "0");
					for(Map<String,String> row : data) { %>
						<tr>
							<td><input type="checkbox" class="att" value="<%= row.get("id") %>"></td>
							<td><%= DbHelper.formatDate(row.get("reqdate")) %></td>
							<td><%= TMHelper.getUserName(row.get("uid")) %></td>
							<td><%= DbHelper.formatDate(row.get("fromdate")) %></td>
							<td><%= DbHelper.formatDate(row.get("todate")) %></td>
							<td><%= row.get("reason") %></td>
						</tr>						
					<% } %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<script>
$(function(){
	$("#all").change(function(){
		let state=$("#all").is(":checked");
		if(state){
			$(".att").prop("checked",true);
		}
		else{
			$(".att").prop("checked",false);
		}		
	});
	
	$("#approve").click(function(){
		let attend=[];
		$(".att:checked").each(function(){
			console.log($(this).val());
			attend.push($(this).val())
		})
		console.log(attend);
		console.log(attend.join(","));
		$.ajax({
			url:'/Project_Management/processleave',
			type:'post',
			data:{'ids':attend.join(","),'type':'approve'},
			success:function(response){
				location.href="processleaves.jsp";
			}
		});
	});
	
	$("#reject").click(function(){
		let attend=[];
		$(".att:checked").each(function(){
			console.log($(this).val());
			attend.push($(this).val())
		})
		console.log(attend);
		console.log(attend.join(","));
		$.ajax({
			url:'/Project_Management/processleave',
			type:'post',
			data:{'ids':attend.join(","),'type':'reject'},
			success:function(response){
				location.href="processleaves.jsp";
			}
		});
	});
});
</script>
<jsp:include page="footer.jsp"></jsp:include>