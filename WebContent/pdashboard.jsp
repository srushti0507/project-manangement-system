<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<jsp:include page="pheader.jsp"></jsp:include>

<div class="container-fluid p-2">
	<div class="card shadow" style="min-height: 88vh">
		<div class="card-body">
			<h5 class="p-2" style="border-bottom: 2px solid green;">
				Welcome !
				<%= session.getAttribute("uname") %></h5>
			<div class="container-fluid">
				<!-- Main content -->
				<section class="content">
					<div class="container-fluid">
						<!-- Info boxes -->
						<div class="row">
							<div class="col-12 col-sm-6 col-md-3">
								<a href="employees.jsp" class="text-dark">
									<div class="info-box">
										<span class="info-box-icon bg-info elevation-1"><i
											class="fas fa-book-open"></i></span>

										<div class="info-box-content">
											<span class="info-box-text">Team Members</span> <span
												class="info-box-number"> 
											</span>
										</div>
										<!-- /.info-box-content -->
									</div>
								</a>
								<!-- /.info-box -->
							</div>

							<!-- /.col -->
							<div class="col-12 col-sm-6 col-md-3">
								<a href="preports.jsp" class="text-dark">
									<div class="info-box mb-3">
										<span class="info-box-icon bg-success elevation-1"><i
											class="fas fa-money-bill"></i></span>

										<div class="info-box-content">
											<span class="info-box-text">Project Report</span> <span
												class="info-box-number"> </span>
										</div>
										<!-- /.info-box-content -->
									</div> <!-- /.info-box -->
								</a>
							</div>
							<!-- /.col -->
						</div>
						<!-- /.row -->
						
		<h5 class="p-2" style="border-bottom: 2px solid green;">Projects Assigned </h5>
		<div class="row">
		<%
		List<Map<String,String>> rows=DbHelper.executeDQL("select ifnull(count(t.id),0) as total,p.id,p.title as ptitle,p.status,p.mgrid from tasks t right join projects p on p.id=t.pid WHERE p.mgrid=? group by p.id", session.getAttribute("id").toString());
		for(Map<String,String> row : rows){
		int total=Integer.parseInt(row.get("total"));
		int completed=Integer.parseInt(TMHelper.getCompletedTask(row.get("id")));
		int progress=0;
		if(completed>0)
			progress=(completed*100)/total;
		%>
		<div class="col-sm-4">
		<div class="card">
			<div class="card-header text-center">
				<h5><%= row.get("ptitle") %></h5>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-sm-6">
						<h5>
						Total Tasks :
						<%= total %></h5>
					<h5>
						Completed :
						<%= completed %></h5>
					</div>					
					<div class="col-sm-6">
					<%
					if(session.getAttribute("pid")==null || !session.getAttribute("pid").toString().equals(row.get("id"))){
					%>
					<a href="LoadProject?pid=<%= row.get("id") %>" class="btn btn-primary float-right mt-3">Load Project</a>
					<% } else {  %>
						<h5 class="card shadow text-center p-2 mt-2">Loaded</h5>
					<% } %>
					</div>
				</div>
				
			</div>
			<a href="ptasks.jsp" style="width:100%;">
			<div class="card-footer text-center">
				<div class="progress">
					<div class="progress-bar progress-bar-striped"
						role="progressbar" style="width: <%= progress %>%"
						aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
				</div> <small><%= progress %>% completed</small>
			</div>
			</a>
		</div>
		</div>
		<%} %>
		</div>
		
						
					</div>
				</section>

			</div>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
