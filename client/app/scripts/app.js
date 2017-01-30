'use strict';

angular
  .module('mlabApp', [
    'ngResource',
    'ui.router',
    'ui.bootstrap',
    'ngSanitize',
    'restmod',
    'angular.filter',
    'ng-token-auth',
    'pascalprecht.translate',
    'ipCookie',
    'ngValidate'
  ])
  .config(function ($translateProvider) {
    $translateProvider
      .translations('en', TRANSLATE_TABLE_EN)
      .translations('pt-br', TRANSLATE_TABLE_PT_BR)
      .preferredLanguage('pt-br')
      .useSanitizeValueStrategy('escape');
  })
  .config(function ($validatorProvider) {
    $validatorProvider.setDefaults({
      errorElement: 'span',
      errorClass: 'help-block text-danger',
      highlight: function(element) {
        $(element).closest("div.form-group").addClass("has-error");
      },
      unhighlight: function(element) {
        $(element).closest("div.form-group").removeClass("has-error");
      }
    });
  })
  .config(function ($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state("login", {
        url: "/",
        views: {
          "layout@": {
            templateUrl: "views/layouts/login.html",
          },
          "content@login": {
            templateUrl: "views/login/form.html"
          }
        }
      })
      .state("dashboard", {
        url: "/dashboard",
        views: {
          "layout@": {
            templateUrl: "views/layouts/main.html",
          },
          "content@dashboard": {
            templateUrl: "views/dashboard/index.html"
          }
        },
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      })
      .state("users_index", {
        url: "/users",
        views: {
          "layout@": {
            templateUrl: "views/layouts/main.html",
          },
          "content@users_index": {
            templateUrl: "views/users/index.html"
          }
        },
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      })
      .state("users_new", {
        url: "/users/new",
        views: {
          "layout@": {
            templateUrl: "views/layouts/main.html",
          },
          "content@users_new": {
            templateUrl: "views/users/new.html"
          }
        },
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      })
      .state("users_edit", {
        url: "/users/:id/edit",
        views: {
          "layout@": {
            templateUrl: "views/layouts/main.html",
          },
          "content@users_edit": {
            templateUrl: "views/users/edit.html"
          }
        },
        resolve: {
          auth: function($auth) {
            return $auth.validateUser();
          }
        }
      });

      $urlRouterProvider.otherwise('/dashboard');
  })
  .config(function($authProvider) {
    $authProvider.configure({
      apiUrl: 'api'
    });
  })
  .config(function(restmodProvider) {
    restmodProvider.rebase('AMSApi');
  })
  .config(function(restmodProvider) {
    restmodProvider.rebase({
        $extend: {
            Model: {
              encodeName: function(_name) { return _name; }, // or null to disable renaming.
              decodeName: function(_name) { return _name; } // or null to disable renaming.
            }
        }
    });
  })

  .run(function($rootScope, $state, $auth, $filter) {
    toastr.options = {
      "closeButton": true,
      "positionClass": "toast-top-center",
      "preventDuplicates": true
    };

    toastr.i18n_success = function(message) {
      toastr.success($filter("translate")(message));
    };

    toastr.i18n_error = function(message) {
      toastr.error($filter("translate")(message));
    };

    toastr.i18n_info = function(message) {
      toastr.info($filter("translate")(message));
    };

    toastr.i18n_warning = function(message) {
      toastr.warning($filter("translate")(message));
    };

    $auth.initialize();

    $rootScope.$state = $state; // state to be accessed from view
  });
