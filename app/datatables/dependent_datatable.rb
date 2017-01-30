class DependentDatatable < AjaxDatatablesRails::Base
  def sortable_columns
    @sortable_columns ||= %w(Dependent.id Dependent.name Dependent.parent )
  end

  def searchable_columns
    @searchable_columns ||= %w(Dependent.id Dependent.name Dependent.parent )
  end

  private

  def data
    records.map do |record|
      [
        "",
        record.id,
        record.name,
        record.parent
      ]
    end
  end

  def get_raw_records
    Dependent.all
  end
end