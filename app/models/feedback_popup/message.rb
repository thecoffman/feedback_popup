class FeedbackPopup::Message
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :body
  attr_accessor :request
  attr_accessor :name
  attr_accessor :email

  validates :body, :presence => true
  validates :request, :presence => true

  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def deliver
    if self.valid?
      FeedbackPopup::Mailer.feedback(self).deliver
      return true
    end
    return false
  end

  def persisted?
    false
  end

end

