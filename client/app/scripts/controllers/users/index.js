'use strict';

angular
  .module("mlabApp")
  .controller("UsersIndexController", function($rootScope, $scope, $stateParams, $state, $filter, $timeout, ipCookie, UserModel) {
    var self = this;

    self.selected = [];
    self.$table = null;

    self.selectAll = function() {
      $("input[type=checkbox]").trigger("click");
    }

    self.openModalDelete = function() {
      $("#modal_delete").modal();
    }

    self.deleteUsers = function() {
      UserModel.$batchDestroy(self.selected).error(function(data) {
        toastr.remove();
        toastr.error(data.errors.join(''));
      }).success(function(response) {
        toastr.remove();
        toastr.i18n_success("views.users.messages.success.batch_destroy");

        self.$table.api().ajax.reload();
      });

      self.selected = [];
    }

    self.init = function() {
      $(".modal-backdrop").remove();
      self.$table = $('#table_users').dataTable({
        "language": {
          "aria": {
              "sortAscending": $filter("translate")("datatable.sort_ascending"),
              "sortDescending": $filter("translate")("datatable.sort_descending")
          },
          "emptyTable": $filter("translate")("datatable.empty_table"),
          "info": $filter("translate")("datatable.info"),
          "infoEmpty": $filter("translate")("datatable.info_empty"),
          "infoFiltered": $filter("translate")("datatable.info_filtered"),
          "lengthMenu": $filter("translate")("datatable.length_menu"),
          "search": $filter("translate")("datatable.search"),
          "zeroRecords": $filter("translate")("datatable.zero_records"),
          "processing": $filter("translate")("datatable.processing")
        },

        buttons: [
            { extend: 'excel', className: 'btn yellow btn-outline ' },
            { extend: 'colvis', className: 'btn dark btn-outline', text: $filter("translate")('datatable.columns')}
        ],

        processing: true,
        serverSide: true,
        searchDelay: 800,
        columnDefs: [
          { "targets": 0, "data": 0, "orderable": false, "width": 5, "render": function(data, type, row) {
            if ($rootScope.user.id != row[1]) {
              return "<div class='md-checkbox-list'><div class='md-checkbox'><input type='checkbox' id='checkbox_" + row[1] + "' value='" + row[1] + "' class='md-check'><label for='checkbox_" + row[1] + "'><span></span><span class='check'></span> <span class='box'></span></label></div>";
            } else {
              return "";
            }

          }},
          { "targets": 1, "data": 1, "class": "text-center", "title": $filter("translate")("views.users.table.id"), "render": function(data, type, row) {
            return "<a href='#/users/" + row[1] + "/edit'>" + row[1] + "</a>";
          }},
          { "targets": 2, "data": 2, "title": $filter("translate")("views.users.table.name") },
          { "targets": 3, "data": 3, "title": $filter("translate")("views.users.table.email") }
        ],

        ajax: {
          url: "/api/users.json",
          headers: ipCookie("auth_headers")
        },

        "order": [
            [1, 'asc']
        ],
        
        "lengthMenu": [
            [5, 10, 15, 20, -1],
            [5, 10, 15, 20, $filter("translate")("views.common.all")] // change per page values here
        ],
        "pageLength": 10,

        "dom": "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"
      });
    }

    $(document).on("change", "input[type=checkbox]", function() {
      if ($(this).prop('checked')) {
        self.selected.push($(this).val());

        $(this).closest('tr').addClass("selected");
      } else {
        self.selected.splice(self.selected.indexOf($(this).val()), 1);

        $(this).closest('tr').removeClass("selected");
      }

      $timeout(function() {
        $scope.$digest();
      });
    });

    self.init();
  });