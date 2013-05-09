<!-- Class Search View -->
<div data-bind="if: viewType() == 'classview'">
    <h2><span data-bind="text: showingClassName()"></span> Search:</h2>
<!-- 	<p><span data-bind="text: searchOrderBy()"></span><br/>
	<span data-bind="text: searchStart()"></span><br/>
	<span data-bind="text: searchLimit()"></span><br/>
	<span data-bind="text: searchDirection()"></span><br/>
	<span data-bind="text: searchTable()"></span></p> -->
	<div class="form-search" style="float: right; margin-bottom: 0.5em;">
		<input type="text" class="span2 search-query" placeholder="Search"
			data-bind="value: searchTerm, valueUpdate: 'afterkeyup'">
	</div>
	
	<div style="float: left; margin-bottom: 0.5em;"> 
	<span class="btn-group">
	   <button type="button" class="btn" data-bind="css: { active: searchLimit() == 10}, click: function() {searchLimit(10);}">10</button>
	   <button type="button" class="btn" data-bind="css: { active: searchLimit() == 20}, click: function() {searchLimit(20);}">20</button>
	   <button type="button" class="btn" data-bind="css: { active: searchLimit() == 50}, click: function() {searchLimit(50);}">50</button>
    </span> results per page
	</div>
	
	<table class="table table-striped table-bordered table-condensed">
		<thead>
	 		<tr data-bind="foreach: searchTable().columns">
				<th style="cursor: pointer;" style="vertical-align: middle;" data-bind="attr: {width: 100 / $root.searchTable().columns.length + '%'}, click: function() { if($root.searchOrderBy() != $data) { $root.searchOrderBy($data); } else { if($root.searchDirection() == 'ASC') $root.searchDirection('DESC'); else $root.searchDirection('ASC');}}">
					<span data-bind="text: $data.unCamelCase()" style="float: left;"></span>
					<span style="float: right;" 
						data-bind="css: { 'icon-sort': $root.searchOrderBy() != $data,
										  'icon-sort-up': $root.searchOrderBy() == $data && $root.searchDirection() == 'DESC',
										  'icon-sort-down': $root.searchOrderBy() == $data && $root.searchDirection() == 'ASC'}"
						class="icon-large"></span>
				</th>
			</tr>
		</thead>
		<tbody data-bind="foreach: searchTable().rows">
			<tr data-bind="foreach: $data, click: function(){ window.location.hash = '#object/' + $root.showingClassName() + '/' + $data[0];}" style="cursor: pointer;" >
				<td data-bind="visible: $index() != 0">
					<span data-bind="text: $data"></span>
				</td>			
			</tr>
		</tbody>
	</table>
	<span style="float: left;">Showing <span data-bind="text: searchStart() + 1"></span> to <span data-bind="text: (searchStart() + searchLimit()) < searchNoResults()? (searchStart() + searchLimit()) : searchNoResults()"></span> of <span data-bind="text: searchNoResults()"></span> entries</span>
	<span style="float: right;">
		<button class="btn" data-bind="disable: searchStart() == 0, click: function() {searchStart(0);}">First</button>
		<button class="btn" data-bind="disable: searchStart() == 0, click: function() {searchStart(searchStart() - searchLimit());}">Prev</button>

		<button class="btn" data-bind="disable: searchStart() + searchLimit() > searchNoResults(), click: function() {searchStart(searchStart() + searchLimit());}">Next</button>
		<button class="btn" data-bind="disable: searchStart() + searchLimit() > searchNoResults(), click: function() {searchStart( searchNoResults() - (searchNoResults % searchLimit()));}">Last</button>
		
	</span> 
</div> 
