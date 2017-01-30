class UserDatatable < AjaxDatatablesRails::Base
  def sortable_columns
    @sortable_columns ||= %w(User.id User.name User.email )
  end

  def searchable_columns
    @searchable_columns ||= %w(User.id User.name User.email )
  end

  private

  def data
    records.map do |record|
      [
        "",
        record.id,
        record.name,
        record.email
      ]
    end
  end

  def get_raw_records
    User.all
  end
end