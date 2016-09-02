class History < ApplicationRecord
  belongs_to :lender
  belongs_to :borrower
  belongs_to :historyable, polymorphic: true
end
