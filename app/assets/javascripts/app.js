var app = angular.module("turing-dungeon", [  ]);

app.controller("UserController", function($scope) {
  $scope.searchName = "";
  $scope.cohorts =[
  {
    "name":"1409",
    "students": [
      "danny",
      "chandra",
      "alex",
      "trevor"
    ],
    "color":"red",
    "graduated":true
  },
  {
    "name":"1412",
    "students": [
      "trey",
      "austin",
      "dj",
      "kyra"
    ],
    "color":"purple",
    "graduated":false
  }
  ];
});
