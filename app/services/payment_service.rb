class PaymentService
  class PaymentError < StandardError; end

  def initialize(order)
    @order = order
  end

  def authorize!
    raise PaymentError, "Order already paid" if @order.status == "confirmed"
    raise PaymentError, "Invalid order" unless @order.total_cents&.positive?
    { status: :authorized, amount: @order.total_cents }
  end

  def capture!
    raise PaymentError, "Must authorize first" unless @order.status == "confirmed"
    { status: :captured, amount: @order.total_cents }
  end
end
