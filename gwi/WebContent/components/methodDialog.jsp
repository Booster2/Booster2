
<div id="methodDialog" class="modal hide fade in" style="display: none; "
	data-bind="if: methodParams() && methodName()">
	<div class="modal-header">  
		<a class="close" data-dismiss="modal">×</a>  
		<h3 data-bind="text: methodName().unCamelCase()"></h3>
	</div>
	<div class="modal-body">  
		<form id="methodCallForm" name="methodCallForm" action="" class="form-horizontal">

<!-- ko foreach: methodParams() -->
<div class="control-group" data-bind="if: paramName() != 'this'">
	<label class="control-label" data-bind="attr: {for: paramName}, text: paramName().unCamelCase() + ':'"></label>
	<div class="controls">
		<input type="text" data-bind="attr: { id: paramName, placeholder: paramName().unCamelCase(), name: paramName}">
	</div>
</div>

<div class="control-group" data-bind="if: paramName() == 'this'" style="display: none">
	<label class="control-label" data-bind="attr: {for: paramName}, text: paramName().unCamelCase() + ':'"></label>
	<div class="controls">
		<input type="hidden" data-bind="attr: { name: paramName, value: $parent.methodThisOid()}"/>
	</div>
</div>

<!-- /ko -->
	</form>
	</div>
	<div class="modal-footer">  
		<button id="method-dialog-submit" class="btn btn-success">Submit</button>  
		<button id="method-dialog-reset" class="btn">Reset</button>  
		<button id="method-dialog-cancel" class="btn">Cancel</button>  
	</div>  
	

</div>
