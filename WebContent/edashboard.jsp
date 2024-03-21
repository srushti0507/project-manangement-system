<%@page import="config.TMHelper"%>
<jsp:include page="eheader.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 88vh">
        <div class="card-body">
            <h5 class="p-2" style="border-bottom: 2px solid green;">Welcome ! <%= session.getAttribute("uname") %></h5>
    <div class="container-fluid">
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- Info boxes -->
        <div class="row">
          <div class="col-12 col-sm-6 col-md-3">
              <a href="etasks.jsp" class="text-dark">
            <div class="info-box">
              <span class="info-box-icon bg-info elevation-1"><i class="fas fa-book-open"></i></span>

              <div class="info-box-content">
                <span class="info-box-text">Assigned Task</span>
                <span class="info-box-number">
                  <%= TMHelper.getEmployeeTaskCount(session.getAttribute("id").toString()) %>
                </span>
              </div>
              <!-- /.info-box-content -->
            </div>
              </a>
            <!-- /.info-box -->
          </div>          
          
                    
        </div>
        <!-- /.row -->
            </div>
        </section>
               
    </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
