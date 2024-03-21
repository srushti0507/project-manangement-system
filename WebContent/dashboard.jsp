<%@page import="config.DbHelper"%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <h5 class="p-2" style="border-bottom: 2px solid green;">Welcome Administrator</h5>
    <div class="container-fluid">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- Info boxes -->
        <div class="row">
          <div class="col-12 col-sm-6 col-md-3">
              <a href="projects.jsp" class="text-dark">
            <div class="info-box">
              <span class="info-box-icon bg-info elevation-1"><i class="fas fa-book-open"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Running Project</span>
                <span class="info-box-number">
                  <%= DbHelper.singleValue("SELECT count(*) FROM projects WHERE active=?", "1") %>
                </span>
              </div>
              <!-- /.info-box-content -->
            </div>
              </a>
            <!-- /.info-box -->
          </div>
          <!-- /.col -->
          <div class="col-12 col-sm-6 col-md-3">
              <a href="users.jsp" class="text-dark">
            <div class="info-box mb-3">
              <span class="info-box-icon bg-danger elevation-1"><i class="fas fa-users"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Managers</span>
                <span class="info-box-number">
                    <%= DbHelper.singleValue("SELECT count(*) from users WHERE role=?", "M") %>
                </span>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            </a>
          </div>
          <!-- /.col -->
          
          <!-- /.col -->
          <div class="col-12 col-sm-6 col-md-3">
              <a href="reports.jsp" class="text-dark">
            <div class="info-box mb-3">
              <span class="info-box-icon bg-success elevation-1"><i class="fas fa-money-bill"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Project Report</span>
                <span class="info-box-number">
                    
                </span>
              </div>
              <!-- /.info-box-content -->
            </div>
            <!-- /.info-box -->
            </a>
          </div>
          <!-- /.col -->          
        </div>
        <!-- /.row -->
            </div>
        </section>
               
    </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
