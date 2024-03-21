<!doctype html>
<html lang="en">

    <head>
    
        <meta charset="utf-8">
        <title>Login - Task Management System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/all.css">
        <link rel="icon" href="images/logo.png" />
        <script src="js/jquery-3.4.1.js" type="text/javascript"></script>
        <link href="css/app.css" id="app-style" rel="stylesheet" type="text/css">
    	<style>
    	.title{
    		position: absolute;
    		bottom:200px;
    		left:50%;    		
    		color:black;    		
    		text-shadow: 1px 1px 4px white;
    	}
    	.title h5{
    	font-size:35px!important;
    	}
    	</style>
    </head>

    <body>
        <!-- Begin page -->
        <div class="accountbg" style="background: url('images/pm2.jpg');background-size: cover;background-position: center;">
        	<div class="title shadow text-center">
        		<h5>Project Management System</h5>
        		<h5>Developed By: Srushti & Dhriti</h5>
        	</div>
        </div>

        <div class="wrapper-page account-page-full">

            <div class="card shadow-none">
                <div class="card-block">

                    <div class="account-box">

                        <div class="card-box shadow-none p-4">
                            <div class="p-2">
                                <div class="text-center mt-4">
                                    <a href="index.html"><img src="images/logo.png" height="30" alt="logo"></a>
                                </div>

                                <h4 class="font-size-18 mt-5 text-center">Welcome Back !</h4>
                                <h5 class="text-muted text-center">Sign in to Project Management.</h5>

                              <form class="mt-4"  method="post" autocomplete="off" action="validate">

                                <div class="mb-3">
                                    <label class="form-label" for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="userid" placeholder="Enter username">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label" for="userpassword">Password</label>
                                    <input type="password" class="form-control" name="pwd" id="userpassword" placeholder="Enter password">
                                </div>
    
                                <div class="mb-3 row">
                                    <div class="col-sm-6 offset-6">
                                        <button class="btn btn-primary float-right" type="submit">Log In</button>
                                    </div>
                                </div>
                            </form>

                            <div class="mt-5 pt-4 text-center position-relative">
                                <p><script>document.write(new Date().getFullYear())</script> �Project Management <i class="mdi mdi-heart text-danger"></i> by Srushti & Dhriti</p>
                            </div>

                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
