class User < ActiveRecord::Base
  validates :phone, presence: true
  validate :phone_format_ok
  after_validation :standardize_phone

  has_and_belongs_to_many :locations

  def standardize_phone
    self.phone = Phony.normalize(self.phone)
  end

  def phone_format_ok
    unless self.phone.present?
      errors.add :phone, "Please enter a phone number."
      return false
    end
    phone = Phony.format(self.phone)
    phone = Phony.format("1#{self.phone}") if !Phony.plausible?(self.phone)
    unless Phony.plausible?(phone)
      errors.add :phone, "Invalid phone number - please try again."
      return false
    end
    self.phone = phone
  end
end
