<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Booster</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    
    
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800,300' rel='stylesheet' type='text/css'>

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }

      @media (max-width: 980px) {
        /* Enable use of floated navbar text */
        .navbar-text.pull-right {
          float: none;
          padding-left: 5px;
          padding-right: 5px;
        }
      }
    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">
	
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="../assets/ico/favicon.png">


  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#">Booster</a>
          <div class="nav-collapse collapse">
            <p class="navbar-text pull-right">
              Logged in as <a href="#" class="navbar-link">Username</a>
            </p>
            <ul class="nav">
              <li class="active"><a href="#classList">Class List</a></li>
              <li><a href="#about">Queries</a></li>
              <li><a href="#contact">Utilities</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
	<div class="container">
		<jsp:include page="components/classList.jsp" />
		<jsp:include page="components/classSearch.jsp" />
		<jsp:include page="components/objectView.jsp" />
		<jsp:include page="components/connectionDetails.jsp" />
		<jsp:include page="components/methodDialog.jsp" />
      

      
<!--       <hr>
      <footer>
      	<span data-bind="text: methodReturnUrl()"></span>
        <p>&copy; Company 2013</p>
      </footer>  -->

    </div><!--/.fluid-container-->
 
 
	<!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/vendor/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <script src="js/vendor/knockout-2.2.0.js" type="text/javascript"></script>
    <script src="js/vendor/sammy.js" type="text/javascript"></script>
	<script src="js/vendor/jquery-ui.js"></script>
	<script src="js/vendor/jquery.dataTables.min.js"></script>
	<script src="js/vendor/jquery.ui.selectmenu.js"></script>
	<script src="js/main.js" type="text/javascript"></script>
	<script src="js/vendor/paging.js" type="text/javascript"></script>
	<script src="js/interface.js" type="text/javascript"></script>

	
    <!-- <script src="js/vendor/jquery.dataTables.plugins.js"></script> -->
	<!-- <script src="js/vendor/knockout-datatables.js"></script> -->
	<!-- <script src="js/vendor/jquery.tablesorter.min.js" type="text/javascript"></script> -->
		
<!-- 
    <script src="../assets/js/bootstrap-alert.js"></script>
    <script src="../assets/js/bootstrap-modal.js"></script>
    <script src="../assets/js/bootstrap-dropdown.js"></script>
    <script src="../assets/js/bootstrap-scrollspy.js"></script>
    <script src="../assets/js/bootstrap-tab.js"></script>
    <script src="../assets/js/bootstrap-tooltip.js"></script>
    <script src="../assets/js/bootstrap-popover.js"></script>
    <script src="../assets/js/bootstrap-button.js"></script>
    <script src="../assets/js/bootstrap-collapse.js"></script>
    <script src="../assets/js/bootstrap-carousel.js"></script>
    <script src="../assets/js/bootstrap-typeahead.js"></script>
 -->

  </body>
</html>
