# frozen_string_literal: true

# rubocop:disable Rails/UniqueValidationWithoutIndex
class Employee < ApplicationRecord
  def self.csv_attributes
    %w[department_id office_id number last_name first_name account email date_of_joining ]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.find_each do |employee|
        csv << csv_attributes.map { |attr| employee.send(attr) }
      end
    end
  end

  belongs_to :office
  belongs_to :department
  has_many :profiles, dependent: :destroy
  has_many :articles, dependent: :destroy

  validates :number, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :account, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'に使える文字のみ入力してください' }

  scope :active, lambda {
    where(deleted_at: nil)
  }
end
# rubocop:enable Rails/UniqueValidationWithoutIndex
