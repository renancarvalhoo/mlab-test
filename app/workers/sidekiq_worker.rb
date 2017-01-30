class SideKiqWorker
  include Sidekiq::Worker

  def perform(h, count)
    user = h
    UserMailer.contact_email(user.name, user.email, user.message).deliver
  end
end