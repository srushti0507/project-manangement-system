<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Admin Login</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/all.css">
        <link rel="icon" href="images/logo.png" />
        <script src="js/jquery-3.4.1.js" type="text/javascript"></script>
        <style>
            body{
                background-image:url('images/bg6.jpg');        
                background-size:100% 100%;
            }
        </style>
    </head>
    <body style="height: 100vh;"> 
    <jsp:include page="msg.jsp"></jsp:include>     
        <div class="jumbotron p-3 mb-2 rounded-0 bg-transparent text-dark text-center" style="box-shadow: 0 0 5px 2px black">
            <h3 class="text-center text-white">Project Management System</h3>            
            <h6 class="text-center font-italic font-weight-normal text-white">(Task Management System)</h6>            
        </div>
        <div class="container p-2 mt-5" style="background-image: url('images/bg.jpg');background-size: 100% 100%">
            <div class="card shadow bg-transparent">
                <div class="card-body" style="min-height:550px;">
                    <div class="row">
                        <div class="col-sm-8">
                            <h4 class="text-center">Login to Portal</h4>
                            <h5 class="text-center font-italic font-weight-normal">
                                Login with your userid and password
                            </h5>
                        </div>
                        <div class="col-sm-4 text-center mt-5">
                        <div class="card shadow bg-transparent">
                        	<div class="card-body">
                        	<img src="images/logo3.png" style="width:220px;height:180px;" class="my-2 shadow"/>
                            <form method="post" autocomplete="off" action="validate">                                
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-success border-0 text-white">
                                                <i class="fas fa-user-tie"></i></span>
                                        </div>
                                        <input type="text" id="userid" placeholder="User Id" name="userid" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-success border-0 text-white">
                                                <i class="fas fa-key"></i>
                                            </span>
                                        </div>
                                        <input type="password" name="pwd" placeholder="Password here" class="form-control">
                                    </div>
                                </div>
                                
                                <input type="submit" value="Login Now" class="btn btn-success btn-block" />
                            </form>
                        	</div>
                        </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>