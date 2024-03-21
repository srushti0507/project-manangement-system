<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>

<div class="container-fluid p-2">
	<div class="card shadow" style="min-height: 90vh">
		<div class="card-body">
			<jsp:include page="msg.jsp"></jsp:include>
			<a href="" class="btn btn-success btn-sm float-right"
				data-target="#addpro" data-toggle="modal"><i class="fa fa-plus"></i>
				Add New Project</a>
			<h4 class="p-2" style="border-bottom: 2px solid green;">Projects</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Project Title</th>
						<th>Abbreviation</th>
						<th>Start Date</th>
						<th>Due Date</th>
						<th>Status</th>
						<th>Manager</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
						String sql = "select p.id,title,abbr,startdt,enddt,status,description,u.uname as mgr from projects p inner join users u on p.mgrid=u.id WHERE p.mgrid=?";
					List<Map<String, String>> data = DbHelper.executeDQL(sql, session.getAttribute("id").toString());
					for (Map<String, String> row : data) {
					%>
					<tr>
						<td><%=row.get("id")%></td>
						<td><%=row.get("title")%></td>
						<td><%=row.get("abbr")%></td>
						<td><%=row.get("startdt")%></td>
						<td><%=row.get("enddt")%></td>
						<td><%= TMHelper.getMasterName(row.get("status")) %></td>
						<td><%=row.get("mgr")%></td>
						<td>
							<button class="btn btn-primary btn-sm" data-toggle="modal"
								data-target="#r<%=row.get("id")%>">Edit</button>
							<div class="modal fade" id="r<%=row.get("id")%>">
								<div class="modal-dialog">
									<form class="modal-content" method="post"
										action="updateproject">
										<input type="hidden" value="<%= row.get("id") %>" name="pid">										
										<div class="modal-header">
											<h5>Edit Project</h5>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>Project Title</label> <input type="text" name="title"
													value="<%=row.get("title")%>"
													class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Abbreviation</label> <input type="text" name="abbr"
													value="<%=row.get("abbr")%>" maxlength="5"
													class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Description</label>
												<textarea name="descr" rows="4"
													class="form-control form-control-sm"><%=row.get("description")%></textarea>
											</div>
											<div class="form-group">
												<label>Start Date</label> <input type="date" readonly
													value="<%=row.get("startdt")%>" name="startdt"
													class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Due Date</label> <input type="date"
													value="<%=row.get("enddt")%>" readonly name="enddt"
													class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Status</label> <select name="status"
													class="form-control form-control-sm">
													<%
													for(Map<String,String> sts:TMHelper.getMastersList("Project Status")) {
													%>
													<option <%= sts.get("id").equals(row.get("status")) ?"selected":"" %> value="<%= sts.get("id") %>"><%= sts.get("mastername") %></option>
													<% } %>
												</select>
											</div>
										</div>
										<div class="modal-footer">
											<input type="submit" value="Save Project"
												class="btn btn-primary btn-sm">
										</div>
									</form>
								</div>
							</div>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="modal fade" id="addpro">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="addproject">
			<div class="modal-header">
				<h5>Add Project</h5>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Project Title</label> <input type="text" name="title"
						class="form-control form-control-sm">
				</div>
				<div class="form-group">
					<label>Abbreviation</label> <input type="text" name="abbr"
						maxlength="5" class="form-control form-control-sm">
				</div>
				<div class="form-group">
					<label>Description</label>
					<textarea name="descr" rows="4"
						class="form-control form-control-sm"></textarea>
				</div>
				<div class="form-group">
					<label>Start Date</label> <input type="date" name="startdt"
						class="form-control form-control-sm">
				</div>
				<div class="form-group">
					<label>Due Date</label> <input type="date" name="enddt"
						class="form-control form-control-sm">
				</div>
				<div class="form-group">
					<label>Manager</label> <select name="mgrid" required
						class="form-control form-control-sm">
						<option value="">Select Manager</option>
						<%
							List<Map<String, String>> mgrs = DbHelper.executeDQL("SELECT id,uname FROM users WHERE role=?", "M");
						for (Map<String, String> map : mgrs) {
						%>
						<option value="<%= map.get("id") %>"><%= map.get("uname") %></option>
						<% } %>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Project"
					class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>