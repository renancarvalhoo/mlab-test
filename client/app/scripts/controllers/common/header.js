'use strict';

angular
  .module("mlabApp")
  .controller("HeaderController", function($scope, $auth, $state) {
    var self = this;

    self.logout = function() {
      $auth.signOut()
        .then(function(resp) {
          $state.go("login");
        })
        .catch(function(resp) {
          alert("Erro ao efetuar o logout");
        });
    }
  });