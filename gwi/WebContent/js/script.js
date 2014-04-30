//script.js

// create the module and name it boosterApp
// also include ngRoute for all our routing needs
	

var boosterApp = angular.module('boosterApp', ['ngRoute', 'ngTable','ui.bootstrap'], function($httpProvider) {
	  // Use x-www-form-urlencoded Content-Type
	//Taken from:
	// http://victorblog.com/2012/12/20/make-angularjs-http-service-behave-like-jquery-ajax/
	  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
	  /**
	   * The workhorse; converts an object to x-www-form-urlencoded serialization.
	   * @param {Object} obj
	   * @return {String}
	   */
	  var param = function(obj) {
	    var query = '', name, value, fullSubName, subName, subValue, innerObj, i;
	      
	    for(name in obj) {
	      value = obj[name];
	        
	      if(value instanceof Array) {
	        for(i=0; i<value.length; ++i) {
	          subValue = value[i];
	          fullSubName = name + '[' + i + ']';
	          innerObj = {};
	          innerObj[fullSubName] = subValue;
	          query += param(innerObj) + '&';
	        }
	      }
	      else if(value instanceof Object) {
	        for(subName in value) {
	          subValue = value[subName];
	          fullSubName = name + '[' + subName + ']';
	          innerObj = {};
	          innerObj[fullSubName] = subValue;
	          query += param(innerObj) + '&';
	        }
	      }
	      else if(value !== undefined && value !== null)
	        query += encodeURIComponent(name) + '=' + encodeURIComponent(value) + '&';
	    }
	      
	    return query.length ? query.substr(0, query.length - 1) : query;
	  };
	 
	  // Override $http service's default transformRequest
	  $httpProvider.defaults.transformRequest = [function(data) {
	    return angular.isObject(data) && String(data) !== '[object File]' ? param(data) : data;
	  }];
});

// configure our routes
boosterApp.config(function($routeProvider) {
	$routeProvider

	.when('/', {
		templateUrl : 'pages/classList.html',
		controller  : 'classListController',
		service: 'classListService'
	})

	.when('/object/:className/:objectID', {
		templateUrl : 'pages/objectView.html',
		controller  : 'objectViewController',
		service : ['objectViewService', 'methodViewService']
	})

	.when('/class/:className', {
		templateUrl : 'pages/classSearch.html',
		controller  : 'classSearchController',
		service : 'classSearchService'
	})

	.when('/queries', {
		templateUrl : 'pages/queries.html',
		controller  : 'queriesController'
	})

	.when('/utilities', {
		templateUrl : 'pages/utilities.html',
		controller  : 'utilitiesController'
	})/*
			.otherwise({
				redirectTo: '/'
			}) */; 
});

// create the controller and inject Angular's $scope
boosterApp.controller('classListController', ['$scope', 'classListService', 'methodDialogService', function($scope, classListService, methodDialogService) {
	// create a message to display in our view
	$scope.loading = true;
	$scope.open = methodDialogService.open;
	classListService.getClassList().then(function(classes) {
		$scope.classes = classes;
		$scope.loading = false;
	});
}]);

boosterApp.controller('objectViewController', ['$scope', '$routeParams', '$modal', 'objectViewService', 'methodViewService', 'methodDialogService', function($scope, $routeParams, $modal, objectViewService, methodViewService, methodDialogService) {
	$scope.loading = true;
	$scope.open = methodDialogService.open;
		
	objectViewService.getObjectView($routeParams.className, $routeParams.objectID).then(function(object) {
		$scope.object = object;
		$scope.object.className = $routeParams.className;
		$scope.object.objectID = $routeParams.objectID;
		$scope.loading = false;
	});
}]);

boosterApp.controller('classSearchController', ['$location', '$scope', '$routeParams', 'classSearchService', 'ngTableParams', function($location, $scope, $routeParams, classSearchService, ngTableParams) {
	$scope.loading = true;
	$scope.page = 1;
	$scope.$watch("filter.$", function (newFilter, oldFilter) {
		if(newFilter !== oldFilter){
			$scope.tableParams.reload();
		}

	});
	//$scope.data = data;
	$scope.tableParams = new ngTableParams({
		page: 1,            // show first page
		count: 10           // count per page
	},{
		total: 0,
		counts: [],
		getData: function($defer, params){
			if($scope.filter)
			{
				params.filter = $scope.filter.$;
			}
			else{
				params.filter = '';	
			}
			//params.page($scope.page);
			classSearchService.getClassSearch($routeParams.className, params).then(function(data) {
				$scope.data = data; 
				params.total(data.total);
			});
		}});
	$scope.className = $routeParams.className;
	$scope.loading = false;
	$scope.gotoEntry = function(classname, oid){
		$location.path('/object/' + classname + '/' + oid);
	};
	$scope.pageChanged = function(page) {
		$scope.tableParams.page(page);

	};
}]);

boosterApp.controller('queriesController', function($scope) {

});

boosterApp.controller('utilitiesController', function($scope) {

});

boosterApp.controller('methodDialogController', ['$log','$scope','methodPreconditionService', function($log, $scope, methodPreconditionService) {
	$scope.precondition = false;
	$scope.changeinputs = function(classname, methodname, oid) {
		$log.info('Hoorah!');
		var data = {};
    	$.each($('#methodCallForm').serializeArray(), function(i, field) {
    	    data[field.name] = field.value;
    	});
    	data["_methodName"] = methodname;
    	data["_className"] = classname;
    	methodPreconditionService.getPrecondition(data).then(function(result){
    		console.log(result);
    		$scope.precondition = result._precondition;
    	});
	};
		
}]);


boosterApp.controller('headerController', function($scope, $location) { 
	$scope.isActive = function (viewLocation) { 
		return viewLocation === $location.path();
	};
});


boosterApp.factory('classListService', function($http) {
	return {
		getClassList: function() {
			//return the promise directly.
			return $http.get('/gwi/ClassList')
			.then(function(result) {
				//resolve the promise as the data
				return result.data;
			});
		}
	};
});

boosterApp.factory('objectViewService', function($http) {
	return {
		getObjectView: function(className, objectID) {
			//return the promise directly.
			return $http.get('/gwi/ObjectView', 
					{	params: {className : className,
						objectID: objectID}})
						.then(function(result) {
							//resolve the promise as the data
							return result.data;
						});
		}
	};
});

boosterApp.factory('methodViewService', function($http) {
	return {
		getMethodView: function(className, methodName) {
			//return the promise directly.
			return $http.get('/gwi/MethodView', 
					{	params: {className : className,
						methodName: methodName}})
						.then(function(result) {
							//resolve the promise as the data
							return result.data;
						});
		}
	};
});

boosterApp.factory('methodSubmitService', function($http, $route) {
	return {
		submitMethod: function(params) {
			//return the promise directly.
			return $http.post('/gwi/callMethod', 
					params)
						.then(function(result) {
							//resolve the promise as the data
							if(result.data._success){
								if(result.data.outputParameterValues.length == 0 && params["this"])
								{
									$route.reload();
									//objectViewService.getObjectView(params._className, params["this"]);
									//$location.path('/object/' + params._className + '/' + params["this"]);
								}
							}
							return result.data;
						});
		}
	
	};
});

boosterApp.factory('methodPreconditionService', function($http, $route) {
	return {
		getPrecondition: function(params) {
			//return the promise directly.
			return $http.post('/gwi/methodPrecondition', 
					params)
						.then(function(result) {
							//resolve the promise as the data
							if(result.data._success){
								console.log("success");
							}
							else{
								console.log("no success");
							}
							return result.data;
						});
		}
	
	};
});


boosterApp.factory('classSearchService', function($http) {
	return {
		getClassSearch: function(className, searchParams) {
			//return the promise directly.
			var searchOrderBy = Object.keys(searchParams.$params.sorting)[0];
			if(!searchOrderBy)
				searchOrderBy = '';
			var searchDirection = searchParams.$params.sorting[searchOrderBy];
			if(!searchDirection)
				searchDirection = '';



			return $http.get('/gwi/ClassSearch', 
					{	params: {className : className,
						searchOrderBy: searchOrderBy,
						searchDirection: searchDirection,
						searchStart: (searchParams.$params.page - 1) * searchParams.$params.count,
						searchLimit: searchParams.$params.count,
						searchTerm: searchParams.filter}})
						.then(function(result) {
							//resolve the promise as the data
							return result.data;
						});
		}
	};
});



var ModalInstanceCtrl = function ($scope, $modalInstance, methodViewService, classname, methodname, oid) {

	
	methodViewService.getMethodView(classname, methodname).then(function(object) {
		$scope.methodObject = object;
		$scope.classname = classname;
		$scope.methodname = methodname;
		$scope.oid = oid;
	});

	$scope.ok = function () {
		$modalInstance.close($scope.classname);
	};

	$scope.cancel = function () {
		$modalInstance.dismiss('cancel');
	};
};


boosterApp.factory('methodDialogService', function($log, $http, $modal, methodViewService, methodSubmitService) {
	return {
		open : function (classname, methodname, oid) {
			var modalInstance = $modal.open({
				templateUrl: 'myModalContent.html',
				controller: ModalInstanceCtrl,
				service: methodViewService,
				resolve: {
					classname: function() { return classname; },
					methodname : function() { return methodname; },
					oid: function() { return oid; }
				}
			});

			modalInstance.result.then(function () {
				var data = {};
	        	$.each($('#methodCallForm').serializeArray(), function(i, field) {
	        	    data[field.name] = field.value;
	        	});
	        	data["_methodName"] = methodname;
	        	data["_className"] = classname;
				methodSubmitService.submitMethod(data);
				//$scope.selected = selectedItem;
			}, function () {
				//$log.info('Modal dismissed at: ' + new Date());
			});
		}
	};
});
	
	String.prototype.unCamelCase = function(){
	return this
	// insert a space between lower & upper
	.replace(/([a-z])([A-Z])/g, '$1 $2')
	// space before last upper in a sequence followed by lower
	.replace(/\b([A-Z]+)([A-Z])([a-z])/, '$1 $2$3')
	// uppercase the first character
	.replace(/^./, function(str){ return str.toUpperCase(); });
};

// This code ensures that for <select> items, the 'onchange' routines are called when the input is changed via the keyboard
// see: http://stackoverflow.com/questions/22630744/ng-options-model-not-updated-when-use-arrow-keyboard-instead-of-mouse 

if (navigator.userAgent.indexOf("Firefox")!==-1) {
	boosterApp.directive("select", function() {
	    return {
	      restrict: "E",
	      require: "?ngModel",
	      scope: false,
	      link: function (scope, element, attrs, ngModel) {
	        if (!ngModel) {
	          return;
	        }
	        element.bind("keyup", function() {
	          element.trigger("change");
	        });
	      }
	    };
	  });
	}


