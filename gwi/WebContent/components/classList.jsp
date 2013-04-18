<div data-bind="visible: classList()" style="width: 100%;">
<h2>Class Browser</h2>
<p>Choose a class, and either browse or search:</p> 
<table class="classes" style="width: 100%;" data-bind="uidatatable: {}" >
    <thead>
    	<tr>
    		<td>Class name</td>
    		<td>No. of objects</td>
    		<td>&nbsp;</td>
    		<td>&nbsp;</td>
    		<td>&nbsp;</td>
    		<td>Action</td>
    	</tr>
    </thead>
    <tbody data-bind="foreach: classList">
		<tr>
			<td style="width: 20em;" >
				<b data-bind="text: className().unCamelCase()"></b>
			</td>
			<td>
				<span data-bind="text: noObjects"></span>
			</td>
			<td>
				<a data-bind="uibutton: {}, visible: noObjects() > 0,attr: { href: '#object/' + className() + '/' + minId()}">Browse...</a>
			</td>
			<td>
				<a data-bind="uibutton: {}, visible: noObjects() > 0,attr: { href: '#class/' + className() }">Search...</a>
			</td>
			<td>
				<a href="" data-bind="uibutton: {}">View in model</a>
			</td>
			<td>
				<span data-bind="visible: classMethods().length > 0" style="white-space: nowrap;">
				<select style="width: 200px;" data-bind="uiselectmenu: {}, foreach: classMethods, attr: {id: 'select' + className()}" >
					<option data-bind="text: methodName.unCamelCase(), attr: { value: $parent.className() + '/' + methodName }"/>
				</select>&nbsp;
				<button onclick="callClassMethod(this);" data-bind="uibutton: {}, attr: {id: 'goButton' + className()}">Go</button></span>
			</td>
		</tr>
	</tbody>
</table>
<script type="text/javascript">

</script>
</div>
