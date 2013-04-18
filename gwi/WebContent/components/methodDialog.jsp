<div id="methodDialog" data-bind="visible: methodParams() && methodName()">
	<h3 data-bind="text: methodName()"></h3>
	<p>This is my method call</p>
	<form id="methodCallForm" name="methodCallForm" action="">
		<table class="methods">
		    <thead>
		    </thead>
		    <tbody data-bind="foreach: methodParams()">
				<tr data-bind="if: paramName() != 'this'">
					<td style="width: 20em;" >
						<span data-bind="text: paramName().unCamelCase() + ':'"></span>
					</td>
					<td style="width: 20em;" >
						<input type="text" data-bind="attr: { name: paramName}"/>
					</td>
				</tr>
				<tr data-bind="if: paramName() == 'this'" style="display: none;">
					<td style="width: 20em;" >
						<span data-bind="text: paramName"></span>
					</td>
					<td style="width: 20em;" >
						<input type="hidden" name="this" data-bind="attr: { value: $parent.methodThisOid() }"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	
	
</div>
