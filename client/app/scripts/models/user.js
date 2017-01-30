'use strict';

angular
  .module("mlabApp")
  .factory("UserModel", function(restmod, RMUtils, $http) {
    return restmod.model('/api/users').mix({
      $extend: {
        Model: {
          $batchDestroy: function(user_ids) {
            return $http.delete(RMUtils.joinUrl(this.$url(), "batch_destroy"), {
              params: {"ids[]": user_ids}
            });
          }
        }
      },
      $hooks: {
        'after-request-error': function(response) {
          switch(response.status) {
            case 422: {
              toastr.error(response.data.errors.join(", "));
            } break;
            case 404: {
              toastr.i18n_error("views.common.errors.not_found");
            } break;
            default: {
              toastr.i18n_error("views.common.errors.unknown");
            }
          }
        }
      }
    });
  });