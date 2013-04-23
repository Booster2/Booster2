<!-- Object View -->


<div data-bind="if: showingClassName() != null && showingObjectID() != null">
		<h3 style="float: left; " data-bind="text: objectDescription()"></h3>
		<h3 style="float: right; color: #999999" data-bind="text: showingClassName().unCamelCase()"></h3>


		<ul class="methods" data-bind="foreach: objectMethods">
			<li>
				<a class="method-button" data-bind="text: methodName().unCamelCase(), attr: { href: '#objectmethod/' + $parent.showingClassName() + '/' + $parent.showingObjectID() + '/' + methodName() }"></a>
			</li>
		</ul>
		<table id="classListTable" class="table table-striped table-bordered">
		<tbody data-bind="foreach: objectAttributes"  >
			<tr>
				<td class="attribute-name-td">
					<span class="attribute-name" data-bind="text: attName().unCamelCase()"></span>
				</td>
				<td>
					<span data-bind="if: attPrimType() == 'String'">
						<!-- ko foreach: stringValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="if: attTypeMult()=='Set' " class="noValues">
							(No. of values: <span data-bind="text: stringValues().length"></span>)
						</span>
					</span>
					<span data-bind="if: attPrimType() == 'Integer'">
						<!-- ko foreach: intValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="if: attTypeMult()=='Set'" class="noValues">
							(No. of values: <span data-bind="text: intValues().length"></span>)
						</span>
					</span>
					<span data-bind="if: attPrimType() == 'SetValue'">
						<!-- ko foreach: setValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="if: attTypeMult()=='Set'" class="noValues">
							(No. of values: <span data-bind="text: setValues().length"></span>)
						</span>
					</span>
					<span data-bind="if: attPrimType() == 'ClassRef'">
						<!-- ko foreach: oidValues() -->
							<a data-bind="attr: { href: '#object/' + $parent.attClassName() + '/' + $data}">
								<span data-bind="text: $parent.objDescs()[$parent.oidValues().indexOf($data)]"></span>
							</a><br/>
					    <!-- /ko -->
					<span data-bind="if: attTypeMult()=='Set'" class="noValues">
						(No. of values: <span data-bind="text: oidValues().length"></span>)
					</span>
				</span>
			</td>
		</tr>
	</tbody>
</table>
</div> 
