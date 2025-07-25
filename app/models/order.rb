class Order < ApplicationRecord
  before_validation :set_default_status, on: :create

  DAYS_TO_DUE = 7

  attribute :address
  attribute :card_hash
  attribute :document

  has_many :line_items
  belongs_to :user
  belongs_to :coupon, optional: true

  validates :status, presence: true, on: :update
  validates :subtotal, presence: true, numericality: { greater_than: 0 }
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_type, presence: true
  validates :installments, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :document, presence: true, cpf_cnpj: true, on: :create

  enum status: { processing_order: 1, processing_error: 2, waiting_payment: 3,
                 payment_accepted: 4, payment_denied: 5, finished: 6 }

  enum payment_type: { credit_card: 1, billet: 2 }

  with_options if: ->{ credit_card? }, on: :create do
    validates :card_hash, presence: true
    validates :address, presence: true
    validates_associated :address
  end

  def due_date
    self.created_at + DAYS_TO_DUE.days
  end

  private

  def set_default_status
    self.status = :processing_order
  end
end
