'use strict';

angular
  .module("mlabApp")
  .controller("LoginController", function($scope, $stateParams, $state, $auth) {
    var self = this;

    self.user = {};

    self.init = function() {

    }

    $scope.$on('auth:login-success', function(ev, user) {
      $state.go("dashboard");
    });

    $scope.$on('auth:login-error', function(ev, reason) {
      self.errors = reason.errors;
    });

    self.login = function() {
      $auth.submitLogin(self.user);
    }    

    self.init();
  });