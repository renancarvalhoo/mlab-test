class DependentService
  attr_reader :success, :errors, :record

  def initialize(parameters = {})
    @parameters = parameters
  end

  def create
    dependent = Dependent.new(@parameters)

    save_record(dependent)
  end

  def update(dependent_id)
    dependent = find_dependent(dependent_id)

    dependent.assign_attributes(@parameters)

    save_record(dependent)
  end

  def destroy(dependent_id)
    dependent = find_dependent(dependent_id)

    if dependent.destroy
      @success = true
      @record = dependent
    else
      @success = false
      @errors = dependent.errors.full_messages
    end
  end

  def batch_destroy(dependent_ids)
    begin
      @record = []

      ActiveRecord::Base.transaction do
        dependent_ids.each do |id|
          dependent = find_dependent(id)

          dependent.destroy!

          @record << dependent
        end
      end

      @success = true
    rescue => e
      @success = false
      @errors = [e.message]
    end
  end

  private
  def find_dependent(dependent_id)
    Dependent.find(dependent_id)
  end

  def save_record(dependent)
    if dependent.save
      @success = true
      @record = dependent.reload
    else
      @success = false
      @errors = dependent.errors.full_messages
    end
  end
end