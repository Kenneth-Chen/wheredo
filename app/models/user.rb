class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone, presence: true
  validate :phone_format_ok
  after_validation :standardize_phone

  has_and_belongs_to_many :locations

  enum subscription_state: {
    active: 0,
    paused: 10,
    inactive: 20
  }

  def active!
    self.paused_until = nil
    super
  end

  def inactive!
    self.paused_until = nil
    super
  end

  def pause_for!(days)
    self.paused_until = days.days.from_now
    paused!
  end

  private

  def standardize_phone
    self.phone = Phony.normalize(self.phone) if self.phone.present?
  rescue Phony::NormalizationError => e
    return false
  end

  def phone_format_ok
    unless self.phone.present?
      errors.add :phone, "Please enter a phone number."
      return false
    end
    phone = Phony.format(Phony.normalize(self.phone))
    phone = Phony.format(Phony.normalize("1#{self.phone}")) if !Phony.plausible?(phone)
    unless Phony.plausible?(phone)
      errors.add :phone, "Invalid phone number - please try again."
      return false
    end
    self.phone = phone
  rescue Phony::NormalizationError => e
    errors.add :phone, "Invalid phone number - please try again."
    return false
  end
end
