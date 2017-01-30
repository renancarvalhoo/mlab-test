'use strict';

angular
  .module("mlabApp")
  .controller("UsersFormCtrl", function($scope, $stateParams, $state, $filter, UserModel) {
    var self = this;

    self.validationOptions = {
      rules: {
        name: "required",
        username: "required",
        email: {
          required: true,
          email: true
        },
        password: {
          required: true,
          minlength: 6
        },
        password_confirmation: {
          required: true,
          minlength: 6,
          equalTo: "#password"
        }
      },
      messages: {
        name: $filter("translate")("views.common.validation.required"),
        username: $filter("translate")("views.common.validation.required"),
        email: {
          required: $filter("translate")("views.common.validation.required"),
          email: $filter("translate")("views.common.validation.email_format")
        },
        password: {
          required: $filter("translate")("views.common.validation.required"),
          minlength: $filter("translate")("views.common.validation.minlength")
        },
        password_confirmation: {
          required: $filter("translate")("views.common.validation.required"),
          minlength: $filter("translate")("views.common.validation.minlength"),
          equalTo: $filter("translate")("views.common.validation.equal_to_password")
        }
      }
    }

    UserModel.mix({
      $hooks: {
        'after-create': function(response) {
          if (response.status == 201) {
            toastr.remove();
            toastr.i18n_success("views.users.messages.success.create");
            $scope.userForm.$setPristine();
            self.model = new UserModel();
          }
        },
        'after-update': function(response) {
          if (response.status == 200) {
            toastr.remove();
            toastr.i18n_success("views.users.messages.success.update");
            $state.go("users_index");
          }
        },
        'after-destroy': function(response) {
          if (response.status == 204) {
            toastr.remove();
            toastr.i18n_success("views.users.messages.success.destroy");
            $state.go("users_index");
          }
        }
      }
    });

    self.id = $stateParams.id;

    if (self.id === undefined) {
      self.model = new UserModel();
    } else {
      self.model = UserModel.$find(self.id);
    }

    self.init = function() {
    }

    self.saveUser = function() {
      if($scope.userForm.validate()) {
        self.model.$save();
      }
    }

    self.deleteUser = function() {
      self.model.$destroy();
    }

    self.init();
  });