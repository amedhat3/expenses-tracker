expensesApp = angular.module("Expenses", ['ngResource', 'ngRoute', 'ui.bootstrap'])

expensesApp.factory "Expense", ["$resource", ($resource) ->
	$resource("/expenses/:id", {id: "@id"}, {update: {method: "PUT"}})
]

expensesApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/', templateUrl: '../assets/index.html', controller: 'ExpensesCtrl'
  $routeProvider.when '/new', templateUrl: '../assets/new.html', controller: 'ExpensesNewCtrl'
  $routeProvider.when '/print', templateUrl: '../assets/print.html', controller: 'ExpensesPrintCtrl'
  $routeProvider.when '/:expense_id/edit', templateUrl: '/edit.html', controller: 'ExpensesEditCtrl'
  $routeProvider.otherwise redirectTo: "/"
]


jQuery ->
	$('#addNewButton').click ->
  		$('#newExpensesForm').show()
  		$('#expensesList').hide()
  		return

	$('#cancleAddExpense').click ->
		$('#newExpensesForm').hide()
		$('#expensesList').show()
		return


@ExpensesCtrl = ["$scope", "Expense", ($scope, Expense) ->
	$scope.expenses = Expense.query()
	$scope.totalAmount = 0

	$scope.print = ->
		print ($('#newExpensesForm').find(".btn").remove()).html();

	$scope.getExpensesTotalAmount = ->
		$scope.totalAmount = 0
		for expense in $scope.expenses
			$scope.totalAmount += Number(expense.amount)

		return $scope.totalAmount

	$scope.getAverageDayExpenses = ->
		maxDate = 0
		if $scope.expenses[0]?
			minDate = Date.parse($scope.expenses[0].datetime)
		else
			return 0
		
		DAY = 1000 * 60 * 60  * 24

		for expense in $scope.expenses
			date = Date.parse(expense.datetime)
			if date > maxDate
				maxDate = date
			if date < minDate
				minDate = date

		days_passed = Math.round((maxDate - minDate) / DAY)

		return $scope.totalAmount/days_passed

	$scope.addExpense = -> 
		$scope.expense.datetime = $('#expenseDatetime').val()
		expense = Expense.save($scope.expense)
		$scope.expenses.push(expense)
		$scope.expense = {}
		$('#expenseDatetime').val("")

		$('#newExpensesForm').hide()
		$('#expensesList').show()
	
	$scope.updateExpense = ->
		expense = Expense.save($scope.expense)
		expense.$update()

	$scope.destroyExpense = (index) ->
		expense = $scope.expenses[index];
		expense.$delete() 
		$scope.expenses.splice(index, 1);

	$scope.filterExpense = ->
		$scope.expenses = Expense.query()
]


@ExpensesNewCtrl = ["$scope", "Expense", ($scope, Expense) ->
	$scope.expenses = Expense.query()
	
	$scope.addExpense = ->
		$scope.expense.datetime = $('#expenseDatetime').val()
		expense = Expense.save($scope.expense)
		$scope.expenses.push(expense)
		$scope.expense = {}
]

# Makes AngularJS work with turbolinks.
$(document).on 'page:load', ->
	$('[ng-app]').each ->
		module = $(this).attr('ng-app')
		angular.bootstrap(this, [module])
        