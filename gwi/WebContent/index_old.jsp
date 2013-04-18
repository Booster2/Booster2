<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js" type="text/javascript"></script>


<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css" />
<title data-bind="text: modelName()"></title>
</head>
<body>

<h1 data-bind="text: modelName()"></h1>
<div class="left-column">
	<h3>Tools</h3>	
	<ul>
	<li><a>Search</a></li>
	<li><a>Browse</a></li>
	<li><a>Maintenance</a></li>
	<li><a>System Description</a></li>
	<li><a>Help</a></li>
	
	</ul>
	
	<h3>System Details</h3>
	<p><b>Signed in as:</b> James Welch</p>
	<p><b>Logged in since:</b> 16-Dec 2012 13:10</p>
	<p><b>Messages:</b> 1 New Message</p>
	<button onclick="connectionDetails()">More details...</button>
	
	

</div>
<div class="right-column">


</body>
</html>