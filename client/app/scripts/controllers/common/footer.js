'use strict';

angular
  .module("mlabApp")
  .controller("FooterController", function($scope) {
    $scope.$on('$includeContentLoaded', function() {
      //Layout.initFooter(); // init footer
    });
  });