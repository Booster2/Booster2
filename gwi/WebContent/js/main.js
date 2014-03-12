var lastUrl;
var thisUrl;


// Class to represent a class
function Class(classItem) {
    var self = this;
    self.className = ko.observable(classItem.className);
    self.noObjects = ko.observable(classItem.noObjects);
    self.classMethods = ko.observableArray(classItem.classMethods);
    self.minId = ko.observable(classItem.minId);
    
}

//Class to represent an attribute
function Attribute(objectItem) {
    var self = this;
    self.attName = ko.observable(objectItem.attName);
    self.attClassName = ko.observable(objectItem.attClassName);
    self.attPrimType = ko.observable(objectItem.attPrimType);
    self.attTypeMult = ko.observable(objectItem.attTypeMult);
    self.stringValues = ko.observableArray(objectItem.stringValues);
    self.intValues = ko.observableArray(objectItem.intValues);
    self.dateTimeValues = ko.observableArray(objectItem.dateTimeValues);
    self.setValues = ko.observableArray(objectItem.setValues);
    self.oidValues = ko.observableArray(objectItem.oidValues);
    self.objDescs = ko.observableArray(objectItem.objDescs);
}

//Class to represent a method
function Method(objectItem) {
    var self = this;
    self.className = ko.observable(objectItem.className);
    self.methodName = ko.observable(objectItem.methodName);
    self.methodThisOid = ko.observable(objectItem.methodThisOid);
    self.methodParams = ko.observableArray(objectItem.parameters);
    self.methodAvailability = ko.observable(objectItem.methodAvailability);
    self.objectItem = objectItem;
    
}

//Class to represent an attribute
function MethodParam(objectItem) {
    var self = this;
    self.paramName = ko.observable(objectItem.paramName);
    self.paramType = ko.observable(objectItem.paramType);
    self.values = ko.observable(objectItem.values);
}


function BoosterViewModel() {
    // Data
	var self = this;
	
	self.viewType = ko.observable();
  
	self.classList = ko.observableArray();
	self.showingClassName = ko.observable();
	self.showingObjectID = ko.observable();
	self.objectAttributes = ko.observableArray();
	self.objectDescription = ko.observable();
	self.objectMethods = ko.observableArray();
	self.objectPrev = ko.observable();
	self.objectNext = ko.observable();
	self.objectLast = ko.observable();
	self.objectFirst = ko.observable();
	self.methodName = ko.observable();
	self.className = ko.observable();
	self.methodParams = ko.observableArray();
  	self.methodThisType = ko.observable();
  	self.methodThisOid = ko.observable();
  	self.methodReturnUrl = ko.observable();
    self.searchOrderBy = ko.observable();
    self.searchDirection = ko.observable();
    self.searchStart = ko.observable();
    self.searchLimit = ko.observable();
    self.searchTerm = ko.observable();
	self.searchNoResults = ko.observable();

	self.searchTable = ko.computed(function(){
		//console.log("calculating searchtable");
		var dataRet = null;
		if(self.showingClassName() != null && self.showingObjectID() == null
			&& self.searchDirection() != null && self.searchStart() != null
			&& self.searchLimit != null)
		{
			$.ajax({
				dataType: "json",
				async: false,
				url: 'ClassSearch',
				data: {
	                className : self.showingClassName(),
	                searchOrderBy : self.searchOrderBy(),
	                searchDirection : self.searchDirection(),
	                searchStart : self.searchStart(),
	                searchLimit : self.searchLimit(),
	                searchTerm : self.searchTerm()
	            },
				success: function(data) {
	            		dataRet = data;
	            		self.searchNoResults(dataRet.total);
	            	}
				});
		}
		//console.log("calculated searchtable");
		return dataRet;
	});

	resetObservables(self, '');
    
    $.sammy(function() {
    	this.get('#object/:className/:objectID', function() {
    		self.viewType('loading');
    		
    		resetObservables(self, 'objectview');
            $.getJSON("ObjectView", 
            {
                className : this.params.className,
                objectID: this.params.objectID
            },
		    function(allData) {
                var mappedAttributes = $.map(allData.attributes, function(item) { return new Attribute(item); });
                var mappedMethods = $.map(allData.methods, function(item) { return new Method(item); });
                self.objectAttributes(mappedAttributes);
                self.objectDescription(allData.description);
                self.objectMethods(mappedMethods);
                self.objectPrev(allData.prev);
                self.objectNext(allData.next);
                self.objectLast(allData.last);
                self.objectFirst(allData.first);
            });
            self.showingClassName(this.params.className);
            self.showingObjectID(this.params.objectID);
            self.viewType('objectview'); 
        });
this.get('#class/:className', function() {
			self.viewType('loading');		
    		resetObservables(self, 'classview');
    		
            self.showingClassName(this.params.className);
            self.searchOrderBy("");
            self.searchStart(0);
            self.searchLimit(10);
            self.searchDirection("ASC");
            self.searchTerm("");
            //self.showingObjectID(this.params.objectID);
            
            self.viewType('classview');
        });
    	this.get('#objectmethod/:className/:objectID/:methodName', function() {
    		//resetObservables(self, 'methodview');
    		self.viewType('loading');
    		self.methodName(this.params.methodName);
    		self.className(this.params.className);
    		self.methodThisType(this.params.className);
    		self.methodThisOid(this.params.objectID);
    		//self.methodReturnUrl('#object/' + this.params.className + '/' + this.params.objectID);
            
    		$.getJSON('MethodView', 
	            {
	                className : this.params.className,
	                methodName: this.params.methodName
	            },
	            function(data) {
	            	var mappedMethodParams = $.map(data.parameters, function(item) { return new MethodParam(item); });
	          	  	self.methodParams(mappedMethodParams);
	          	  	
	            }
	        );
            prepareMethod(self);
            self.viewType('methodview');
    	});
    	this.get('#classmethod/:className/:methodName', function() {
    		//resetObservables(self, 'methodview');
    		self.viewType('loading');
    		self.methodName(this.params.methodName);
    		self.className(this.params.className);
    		//self.methodReturnUrl('#' + this.params.className + '/' + this.params.objectID);
    		            
    		$.getJSON('MethodView', 
	            {
	                className : this.params.className,
	                methodName: this.params.methodName
	            },
	            function(data) {
	            	var mappedMethodParams = $.map(data.parameters, function(item) { return new MethodParam(item); });
	          	  	self.methodParams(mappedMethodParams);
	          	  	
	          	  
	            }
	        );
            prepareMethod(self);
            self.viewType('methodview');
    	});
        this.get('#classList', function() {
        	self.methodReturnUrl('#classList');
        	self.viewType('loading');
        	resetObservables(self, 'classlist');
            $.getJSON("ClassList", function(allData) {
                var mappedClasses = $.map(allData, function(item) { return new Class(item); });
                self.classList(mappedClasses);
            });
            self.viewType('classlist');
        });
    }).run('#classList');  
    

};

$(function(){

	ko.applyBindings(new BoosterViewModel());
	
});

function browse(self, move){
	var oid = 0;
	if(move=='first'){
		oid = self.objectFirst();    		 
	}
	else if(move=='prev'){
		oid = self.objectPrev();    		 
	}
	else if(move=='next'){
		oid = self.objectNext();    		 
	}
	else if(move=='last'){
		oid = self.objectLast();    		 
	}
	var url = '#object/' + self.showingClassName() + '/' + oid;
	window.location.hash = url;
}


function prepareMethod(self)
{
	
	var d = $('#methodDialog');
	d.modal();
	$('#method-dialog-submit').on('click', 
				function() {
			        	var data = {};
			        	$.each($('#methodCallForm').serializeArray(), function(i, field) {
			        	    data[field.name] = field.value;
			        	});
			        	data["_methodName"] = self.methodName;
			        	data["_className"] = self.className;
			        	//console.log(data);
			        	$.ajax({  
			        		  type: "POST",
			        		  async: false,
			        		  url: "callMethod",  
			        		  data: data,
			        		  dataType: "json",
			        		  success: function(resultData, textStatus, jqXHR) {
			        			  if(resultData._success)
			        			  {
			        				  if(resultData.outputParameterValues.length == 1)
			        				  {
			        					  self.methodReturnUrl('#object/' + resultData.outputParameterValues[0].paramClassName + '/' + resultData.outputParameterValues[0].value);
			        				  }
			        			  }
			        		  }  
			        		});  
			        	$('#methodDialog').modal('hide');
			        	//$( this ).dialog( "close" );		  
			        	//unprepareMethod(self);
	});
	$('#method-dialog-reset').on('click',	
			        function() {
						$('#methodCallForm').each(function(){
							this.reset();
						});
			        });
	$('#method-dialog-cancel').on('click',
			        function() {
						$('#methodDialog').modal('hide');
			            //$( this ).dialog( "close" );
			            //unprepareMethod(self);
			        });
	
    $('#methodDialog').on('hidden', function () {
    		unprepareMethod(self);
        });

}

function unprepareMethod(self)
{
	//console.log(self);
	//console.log('method return url: ' + self.methodReturnUrl());
	window.location.hash = self.methodReturnUrl();
}

function resetObservables(self, type)
{
	self.modelName = ko.observable("TypeTest");
	self.dbName = ko.observable("MySQL");
	self.userName = ko.observable("cuthbert@localhost");
	
	if(type != 'classlist')
	{
		self.classList([]);
		
	}
	
	if(type != 'objectview')
	{
		self.showingClassName(null);
		self.showingObjectID(null);
		self.objectAttributes(null);
		self.objectDescription(null);
		self.objectMethods(null);
		self.objectPrev(null);
		self.objectNext(null);
		self.objectLast(null);
		self.objectFirst(null);
		
	}
	
	if(type != 'methodview')
	{
		self.methodName(null);
		self.className(null);
		self.methodParams([]);
  	  	self.methodThisType(null);
  	  	self.methodThisOid(null);
  	  	//self.methodReturnUrl(null);

	}
	
}


String.prototype.unCamelCase = function(){
	return this
	// insert a space between lower & upper
	.replace(/([a-z])([A-Z])/g, '$1 $2')
	// space before last upper in a sequence followed by lower
	.replace(/\b([A-Z]+)([A-Z])([a-z])/, '$1 $2$3')
	// uppercase the first character
	.replace(/^./, function(str){ return str.toUpperCase(); });
};


function callClassMethod(button){
	var methodName = $(button).parent().children('select').val();
	window.location.hash = 'classmethod/' + methodName;
}


