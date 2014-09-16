//= require expenses
expensesApp = angular.module("Expenses")

expensesApp.config ["$httpProvider", ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
]