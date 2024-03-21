<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%
String pid=request.getParameter("pid");
String tid=request.getParameter("id");
if(session.getAttribute("role").equals("A")){
%>
<jsp:include page="header.jsp"></jsp:include>
<% } else if(session.getAttribute("role").equals("M")) { %>
<jsp:include page="pheader.jsp"></jsp:include>
<% } else if(session.getAttribute("role").equals("E")) { %>
<jsp:include page="eheader.jsp"></jsp:include>
<% } %>
<div class="container-fluid p-2">
	<div class="card shadow" style="min-height: 90vh">
		<div class="card-body">
			<jsp:include page="msg.jsp"></jsp:include>
			<%
        	Map<String,String> td=DbHelper.executeDQLReturnSingle("SELECT * FROM tasks WHERE id=? and pid=?", tid,pid);
        	List<Map<String,String>> users=DbHelper.executeDQL("SELECT id,uname FROM users WHERE pid=?", pid);
        	%>
			<div class="row">
				<div class="col-sm-8">
					<h4 class="p-2" style="border-bottom: 2px solid green;">
					<%= td.get("taskid") %> - <%= td.get("title") %></h4>
					<h6 class="p-1">Description</h6>
					<div class="m-2 p-1">
						<%for(String line :  td.get("descr").split("\n")) { %>
						<p class="m-1"><%= line %></p>
						<% } %>
					</div>
					<div class="card">
						<div class="card-body">
							<form method="post" action="savecomment">
								<input type="hidden" name="tid" value="<%= tid %>"> <input
									type="hidden" name="pid" value="<%= pid %>">
								<textarea placeholder="Comments here" name="comment"
									class="form-control" style="resize: none;"></textarea>
								<input type="submit" value="Submit"
									class="btn btn-primary btn-sm my-2">
							</form>
						</div>
					</div>

					<%
		       			List<Map<String,String>> comments=DbHelper.executeDQL("SELECT * FROM comments WHERE tid=? and pid=? order by 1 desc", tid,pid);
        		if(comments.size()>0) {
        		%>
					<div class="card">
						<div class="card-body p-2">
							<%
		       			for(Map<String,String> row : comments){
		       			%>
							<div class="border-bottom p-2">
								<h6 class="text-right"><%= TMHelper.getUserName(row.get("uid")) %>
									comments on
									<%= DbHelper.formatDate(row.get("createdon")) %></h6>
								<%for(String line :  row.get("comment").split("\n")) { %>
									<p class="m-1"><%= line %></p>
								<% } %>
							</div>
							<%} %>
						</div>
					</div>
					<%}  %>
				</div>


				<div class="col-sm-4">
					<form method="post" action="updatetaskstatus">
						<div class="form-group form-row">
							<label class="col-sm-4 mt-1">Total Time Spent</label>
							<div class="col-sm-8">
							<input type="text" class="form-control" readonly value="<%= td.get("timespent")==null ? "0" : td.get("timespent") %> hours">
							</div> 
						</div>
						<div class="form-group form-row">
						<%
						String cls="btn-primary";
						if(td.get("status").equals("14")){
							cls="btn-success";
						}
						%>
							<label class="col-sm-4 mt-1">Task Status</label> 
							<div class="col-sm-8">
							<select class="form-control selectpicker"
								name="status" data-style="<%= cls %>">
								<%
								List<Map<String,String>> status=TMHelper.getMastersList("Task Status");
								for(Map<String,String> row : status) {
								%>
								<option value="<%= row.get("id") %>" 
								<%= row.get("id").equals(td.get("status")) ? "selected" :"" %>><%= row.get("mastername") %></option>									
							   <% } %>								
							</select>
							</div>
						</div>
						
						<input type="hidden" name="tid" value="<%= tid %>">
						<input type="hidden" name="pid" value="<%= pid %>">
						<div class="form-group form-row">
							<label class="col-sm-4 mt-1">Assignee</label> 
							<div class="col-sm-8">
							<select class="form-control selectpicker" data-style="btn-primary" name="uid">
								<% for(Map<String,String> user : users)  { %>
								<option value="<%= user.get("id") %>"
									<%= user.get("id").equals(td.get("uid")) ? "selected":"" %>><%= user.get("uname") %></option>
								<% } %>
							</select>
							</div>
						</div>

						<div class="form-group form-row">
							<label class="col-sm-4 mt-1">Priority</label> 
							<div class="col-sm-8">
							<select class="form-control selectpicker"
								name="priority" data-style="btn-primary">
								<%
								List<Map<String,String>> prs=TMHelper.getMastersList("Priority");
								for(Map<String,String> row : prs) {
								%>
								<option value="<%= row.get("id") %>" 
								<%= row.get("id").equals(td.get("priority")) ? "selected" :"" %>><%= row.get("mastername") %></option>									
							   <% } %>	
							</select>
							</div>
						</div>
						
						<div class="form-group form-row">
							<label class="col-sm-4 mt-1">Time Spent (hours)</label>
							<div class="col-sm-8">
							<input type="text" class="form-control" name="timespent">
							</div> 
						</div>


						<input type="submit" value="Update Status"
							class="btn btn-primary float-right">
					</form>
				</div>
			</div>

		</div>
	</div>
</div>
<script>
$(document).ready(function() {
    $('textarea').on('keyup keypress', function() {
        $(this).height(0);
        $(this).height(this.scrollHeight);
    });
});
</script>
<jsp:include page="footer.jsp"></jsp:include>