<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
		<script src="js/vendor/jquery-1.8.3.min.js"></script>
		<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js" type="text/javascript"></script>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title data-bind="text: modelName()"></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
		<script src="js/vendor/knockout-2.2.0.js" type="text/javascript"></script>

		<link rel="stylesheet" href="http://view.jqueryui.com/selectmenu/themes/base/jquery.ui.all.css">
        <link rel="stylesheet" href="css/normalize.min.css">
        <link rel="stylesheet" href="css/main.css">
		<!-- <link rel="stylesheet" href="css/jquery.dataTables_themeroller.css">-->
		<link rel="stylesheet" href="css/jquery.dataTables.css">
		<!-- <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" /> -->
		<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/themes/cupertino/jquery-ui.css" type="text/css" media="all" />
		<script src="js/vendor/sammy.js" type="text/javascript"></script>
		<script src="js/vendor/jquery.ui.core.js"></script>
		<script src="js/vendor/jquery.ui.widget.js"></script>
		<script src="js/vendor/jquery.ui.position.js"></script>
		<script src="js/vendor/jquery.ui.menu.js"></script>
		<script src="js/vendor/jquery.ui.selectmenu.js"></script>
		<script src="js/vendor/jquery.dataTables.min.js"></script>
		<script src="js/main.js" type="text/javascript"></script>
		<script src="js/interface.js" type="text/javascript"></script>
        <script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>		
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->
		<div class="full-container">
        <div class="header-container">
            <header class="wrapper clearfix">
                <h1 class="title" data-bind="text: modelName()"></h1>
                <nav>
                    <ul>
                        <li><a href="#classList">Search</a></li>
                        <li><a href="#classList">Browse</a></li>
                        <li><a href="#help">Help</a></li>
                    </ul>
                </nav>
            </header>
        </div>

        <div class="main-container">
            <div class="main wrapper clearfix">

				<jsp:include page="components/classList.jsp" />
				<jsp:include page="components/classSearch.jsp" />
				<jsp:include page="components/objectView.jsp" />
				<jsp:include page="components/connectionDetails.jsp" />
				<jsp:include page="components/methodDialog.jsp" />









            </div> <!-- #main -->
        </div> <!-- #main-container -->
        </div> <!-- .full-container -->
        <div class="footer-container">
            <footer class="wrapper">
                <h3>A Booster 2.0 System</h3>
            </footer>
        </div>
        <!-- <script>
            var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
        </script> -->
    </body>
</html>
