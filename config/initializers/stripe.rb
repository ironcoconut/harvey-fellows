require "stripe"

Stripe.api_key = ENV.fetch("STRIPE_API_KEY", "")

module Stripe
  def self.public_key
    @public_key ||= ENV.fetch("STRIPE_PUBLIC_KEY", "")
  end
end
