<div data-bind="if: viewType() == 'classlist'">
<h2>Class Browser</h2>
<p style="float: left;">Choose a class, and either browse or search:</p>

<p style="float: right; font-size: 0.8em;">No. of classes: <span data-bind="text: classList().length"></span></p>



 <table id="classListTable" class="table table-striped table-bordered">
    <thead>
        <tr>
    		<th>Class name</th>
    		<th>No. of objects</th>
    		<th>&nbsp;</th>
    		<th>&nbsp;</th>
    		<!-- <th>&nbsp;</th> -->
    		<th>Action</th>
        </tr>
    </thead>
                    
    <tbody data-bind="foreach: classList">
    	<tr class="form-horizontal">
           	<td style="width: 20em; padding-top: 14px;">
				<span data-bind="text: className().unCamelCase()"></span>
			</td>
			<td style="padding-top: 14px;">
				<span data-bind="text: noObjects"></span>
			</td>
			<td style="padding-top: 14px;">
				<a data-bind="if: noObjects() > 0,attr: { href: '#object/' + className() + '/' + minId()}">Browse...</a>
			</td>
			<td style="padding-top: 14px;">
				<a data-bind="if: noObjects() > 0,attr: { href: '#class/' + className() }">Search...</a>
			</td>
<!-- 			<td>
				<a href="" data-bind="">View in model</a>
			</td> -->
			<td>
				<div data-bind="if: classMethods().length > 0">
					<select style="width: 200px;" data-bind="foreach: classMethods, attr: {id: 'select' + className()}" >
						<option data-bind="text: methodName.unCamelCase(), attr: { value: $parent.className() + '/' + methodName }"/>
					</select>&nbsp;
					<button onclick="callClassMethod(this);" data-bind="attr: {id: 'goButton' + className()}">Go</button>
				</div>
			</td>
		</tr>
    </tbody>
</table>
                  
 </div>
