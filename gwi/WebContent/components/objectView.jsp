<!-- Object View -->


<div data-bind="if: showingClassName() != null && showingObjectID() != null">

    <div class="navbar">
    	<div class="navbar-inner">
   			<table style="width: 100%;">
   				<tr>
   					<td style="width: 12em; text-align: left;">
   						<button type="button" class="btn" data-bind="disable: objectFirst() == 0 || objectFirst() == showingObjectID(), click : function() { browse($root, 'first'); } "><i class="icon-fast-backward"></i></button>
						&nbsp;
						<button type="button" class="btn" data-bind="disable: objectPrev() == 0, click : function() { browse($root, 'prev'); } "><i class="icon-play icon-rotate180"></i></button>
   					</td>
   					<td style="text-align: center;">
   						<h5 style="color: #999999">Browse : <span data-bind="text: showingClassName().unCamelCase()"></span></h5>
						<h4 data-bind="text: objectDescription()"></h4>
   					</td>
   					<td style="width: 12em; text-align: right;">
   						<button type="button" class="btn" data-bind="disable: objectNext() == 0, click : function() { browse($root, 'next'); } "><i class="icon-play"></i></button>
						&nbsp;
						<button type="button" class="btn" data-bind="disable: objectLast() == 0 || objectLast() == showingObjectID(), click : function() {browse($root, 'last');} "><i class="icon-fast-forward"></i></button>
   					</td>
 				</tr>
   			</table>
     	</div>
    </div>

<!-- 	<h4 style="float: left; "></h4>
	<h4 style="float: right; " ></h4> -->
		
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
					<span data-bind="if: attPrimType() == 'DateTime'">
						<!-- ko foreach: dateTimeValues() -->
							<span data-bind="text: $data"></span><br/>
					    <!-- /ko -->
						<span data-bind="if: attTypeMult()=='Set'" class="noValues">
							(No. of values: <span data-bind="text: dateTimeValues().length"></span>)
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
