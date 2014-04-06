
<div id="methodDialog" class="modal hide fade in" style="display: none; "
	data-bind="if: methodParams() && methodName()">
	<div class="modal-header">  
		<a class="close" data-dismiss="modal">×</a>  
		<h3 data-bind="text: methodName().unCamelCase()"></h3>
	</div>
	<div class="modal-body">  
		<form id="methodCallForm" name="methodCallForm" action="" class="form-horizontal">

<!-- ko foreach: methodParams() -->
	<!-- ko if: paramName() != 'this' && (paramType() == 'Integer' || paramType() == 'String') -->
	<div class="control-group">
		<label class="control-label" data-bind="attr: {for: paramName}, text: paramName().unCamelCase() + ':'"></label>
		<div class="controls">
			<input type="text" data-bind="attr: { id: paramName, placeholder: paramName().unCamelCase(), name: paramName}">
		</div>
	</div>
	<!-- /ko -->
	<!-- ko if: paramName() != 'this' && paramType() == 'SetValue' -->
	<div class="control-group">
		<label class="control-label" data-bind="attr: {for: paramName}, text: paramName().unCamelCase() + ':'"></label>
		<div class="controls">
			<select data-bind="foreach: values(), attr: { id: paramName, placeholder: paramName().unCamelCase(), name: paramName}" >
				<!-- ko if : $data != 'unassigned' -->
				<option data-bind="value: $data, text: $data.unCamelCase()"></option>
				<!-- /ko -->
				
			</select>
			<!-- <input type="text" data-bind="attr: { id: paramName, placeholder: paramName().unCamelCase(), name: paramName}"> -->
		</div>
	</div>
	<!-- /ko -->
	<!-- ko if: paramName() != 'this' && paramType() == 'ClassRef' -->
	<div class="control-group">
		<label class="control-label" data-bind="attr: {for: paramName}, text: paramName().unCamelCase() + ':'"></label>
		<div class="controls">
			<select data-bind="foreach: values(), attr: { id: paramName, placeholder: paramName().unCamelCase(), name: paramName}" >
				<!-- ko if : $data != 'unassigned' -->
				<option data-bind="value: $data.id, text: $data.desc"></option>
				<!-- /ko -->
				
			</select>
			<!-- <input type="text" data-bind="attr: { id: paramName, placeholder: paramName().unCamelCase(), name: paramName}"> -->
		</div>
	</div>
	<!-- /ko -->
	<!-- ko if: paramName() == 'this' -->
	<div class="control-group" style="display: none">
		<label class="control-label" data-bind="attr: {for: paramName}, text: paramName().unCamelCase() + ':'"></label>
		<div class="controls">
			<input type="hidden" data-bind="attr: { name: paramName, value: $parent.methodThisOid()}"/>
		</div>
	</div>
	<!-- /ko -->

<!-- /ko -->
	</form>
	</div>
	<div class="modal-footer">  
		<button id="method-dialog-submit" class="btn btn-success">Submit</button>  
		<button id="method-dialog-reset" class="btn">Reset</button>  
		<button id="method-dialog-cancel" class="btn">Cancel</button>  
	</div>  
	

</div>
