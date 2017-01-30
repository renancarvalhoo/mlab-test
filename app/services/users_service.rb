class UserService
  attr_reader :success, :errors, :record

  def initialize(parameters = {})
    @parameters       = parameters
  end

  def create
    
    User.new(@parameters)
        
    if user.blank?
      @success = false
      @errors = [I18n.t('activemodel.errors.models.user.user_doesnt_exist')]
    else
      save_record(user)
    end
  end

  def update(user_id)
    user = find_user(user_id)

    unless user.present?
      @success = false
      @errors = [I18n.t('activemodel.errors.models.user.user_doesnt_exist')]
      return
    end
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
      begin
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

    def save_record(user)
      if user.save
        @success = true
        @record  = User.find(user.id)
      else
        @success = false
        @errors  = user.errors.full_messages
      end
    end
