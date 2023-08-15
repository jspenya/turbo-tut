class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # This is a shorter way to write the broadcast callbacks (create, update, destroy)
  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend

  # Broadcast updates to quotes/show also
  after_update_commit -> { broadcast_replace_later_to "quote", partial: "quotes/show_quote",
    locals: { quote: self }, target: "quote_#{self.id}" }

  # after_create_commit -> { broadcast_prepend_later_to "quotes", partial: "quotes/quote",
  #   locals: { quote: self }, target: "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes", partial: "quotes/quote",
  #   locals: { quote: self }, target: "quote_#{self.id}" }
  # after_destroy_commit -> { broadcast_remove_to "quotes", target: "quote_#{self.id}" }
end
