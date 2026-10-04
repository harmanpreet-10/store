module Notifiable
  extend ActiveSupport::Concern

  included do
    after_update_commit :notify_subscribers_when_back_in_stock
  end

  private

  def notify_subscribers_when_back_in_stock
    return unless saved_change_to_inventory_count?
    return unless inventory_count.to_i > 0
    return unless inventory_count_before_last_save.to_i == 0

    subscribers.find_each do |subscriber|
      ProductMailer.with(
        product: self,
        subscriber: subscriber
      ).back_in_stock.deliver_later
    end
  end
end