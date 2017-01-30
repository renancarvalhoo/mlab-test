'use strict';

angular
  .module("mlabApp")
  .controller("SidebarController", function($scope) {
    $scope.$on('$includeContentLoaded', function() {
      Layout.init();
    });
  });