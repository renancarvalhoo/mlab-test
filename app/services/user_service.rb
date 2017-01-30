class UserService
  attr_reader :success, :errors, :record

  def initialize(parameters = {})
    @parameters = parameters
  end

  def create
    user = User.new(@parameters)

    save_record(user)
  end

  def update(user_id)
    user = find_user(user_id)

    user.assign_attributes(@parameters)

    save_record(user)
  end

  def destroy(user_id)
    user = find_user(user_id)

    if user.destroy
      @success = true
      @record = user
    else
      @success = false
      @errors = user.errors.full_messages
    end
  end

  def batch_destroy(user_ids)
    begin
      @record = []

      ActiveRecord::Base.transaction do
        user_ids.each do |id|
          user = find_user(id)

          user.destroy!

          @record << user
        end
      end

      @success = true
    rescue => e
      @success = false
      @errors = [e.message]
    end
  end

  private
  def find_user(user_id)
    User.find(user_id)
  end

  def save_record(user)
    if user.save
      @success = true
      @record = user.reload
    else
      @success = false
      @errors = user.errors.full_messages
    end
  end
end