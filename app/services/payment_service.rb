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

  def refund!
    raise PaymentError, "Cannot refund pending order" if @order.status == "pending"
    { status: :refunded, amount: @order.total_cents }
  end

  def handle_timeout
    if @order.cod?
      @order.cancel!(reason: "payment_timeout")
    else
      retry_capture
    end
  end

  private

  def retry_capture
    5.times do |attempt|
      result = capture!
      return result if result[:status] == :captured
    rescue PaymentError
      next
    end
    @order.cancel!(reason: "capture_failed_after_retries")
  end
end
