var app = angular.module("turing-dungeon", [  ]);

app.controller("UserController", function($scope) {
  $scope.todoList = [];
  $scope.currentTodo = "";

  $scope.add = function() {
    var todoObject = {
      name:$scope.currentTodo,
      complete:false
    };
    if ($scope.currentTodo !== "") {
      $scope.todoList.push(todoObject);
    }
    $scope.currentTodo = "";
  };

  $scope.delete = function(index) {
    $scope.todoList.splice(index, 1);
  };

  $scope.finished = function(index) {
    $scope.todoList[index].complete = !$scope.todoList[index].complete;
  };
});
