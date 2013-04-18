<!-- Object View -->
<div data-bind="visible: showingClassName() && showingObjectID()">
		<h3 data-bind="text: showingClassName() + ': ' + objectDescription()"></h3>
		<ul class="methods" data-bind="foreach: objectMethods">
			<li>
				<a class="method-button" data-bind="text: methodName().unCamelCase(), attr: { href: '#objectmethod/' + $parent.showingClassName() + '/' + $parent.showingObjectID() + '/' + methodName() }"></a>
			</li>
		</ul>
	    <dl data-bind="foreach: objectAttributes">
					<dt class="even" data-bind="text: attName().unCamelCase()"></dt>
					<dd data-bind="visible: attPrimType() == 'String'">
						<!-- ko foreach: stringValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="visible: attTypeMult()=='Set' " class="noValues">
							(No. of values: <span data-bind="text: stringValues().length"></span>)
						</span>
					</dd>
					<dd data-bind="visible: attPrimType() == 'Integer'">
						<!-- ko foreach: intValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="visible: attTypeMult()=='Set'" class="noValues">
							(No. of values: <span data-bind="text: intValues().length"></span>)
						</span>
					</dd>
					<dd data-bind="visible: attPrimType() == 'SetValue'">
						<!-- ko foreach: setValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="visible: attTypeMult()=='Set'" class="noValues">
							(No. of values: <span data-bind="text: setValues().length"></span>)
						</span>
					</dd>
					<dd data-bind="visible: attPrimType() == 'ClassRef'">
						<!-- ko foreach: oidValues() -->
							<a data-bind="attr: { href: '#object/' + $parent.attClassName() + '/' + $data}">
								<span data-bind="text: $parent.objDescs()[$parent.oidValues().indexOf($data)]"></span>
							</a><br/>
					    <!-- /ko -->
					<span data-bind="visible: attTypeMult()=='Set'" class="noValues">
						(No. of values: <span data-bind="text: oidValues().length"></span>)
					</span>
					</dd>
		</dl>
</div> 
