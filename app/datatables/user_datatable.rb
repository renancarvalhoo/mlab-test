class UserDatatable < AjaxDatatablesRails::Base
  def_delegator :@view, :current_user

  def sortable_columns
    @sortable_columns ||= %w(User.id User.name User.email User.username)
  end

  def searchable_columns
    @searchable_columns ||= %w(User.id User.name User.email User.username)
  end

  private

  def data
    records.map do |record|
      [
        '',
        record.id,
        record.name,
        record.email,
        record.username
      ]
    end
  end

  def get_raw_records
    User.all
  end
end
~                                                                                                                      
~         
