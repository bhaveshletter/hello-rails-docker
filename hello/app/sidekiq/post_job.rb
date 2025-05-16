class PostJob
  include Sidekiq::Job

  def perform(*args)
    Rails.log(args)
    1+1
  end
end
