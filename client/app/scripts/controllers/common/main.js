'use strict';

angular
  .module("mlabApp")
  .controller("AppController", function($scope) {
    $scope.$on('$viewContentLoaded', function() {
      //Metronic.initComponents(); // init core components
      //Layout.init(); //  Init entire layout(header, footer, sidebar, etc) on page load if the partials included in server side instead of loading with ng-include directive 
    });
  });