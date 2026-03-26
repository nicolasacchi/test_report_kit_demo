# Test Report: test_report_kit_demo

Generated: 2026-03-26T12:14:24+00:00  
Branch: `feature/add-services` | SHA: `6d3cbbcbc63381e7f89435e711a9533bbf7e0e84`

---

## Summary

| Metric | Value |
|--------|-------|
| Line Coverage | 77.0% (137/178) |
| Branch Coverage | 43.4% |
| Duration | 0s |
| Examples | 40 (0 failures, 0 pending) |
| Diff Coverage | 70.1% (96/137 changed lines) |
| Diff Threshold | 90% — FAIL |
| Factory Creates | 67 |

---

## Diff Coverage Details

### `app/services/pricing_engine.rb` — 29.2%

Uncovered lines: `3, 4, 8, 9, 10, 11, 12, 18, 19, 23, 24, 28, 29, 30, 31, 32, 34`

```ruby
  2:   def initialize(product, pharmacy = nil)
- 3:     @product = product
- 4:     @pharmacy = pharmacy
  5:   end
  7:   def calculate
- 8:     base = @product.price_cents
- 9:     base = apply_pharmacy_markup(base) if @pharmacy
- 10:     base = apply_volume_discount(base)
- 11:     base = apply_seasonal_adjustment(base)
- 12:     { final_price: base, currency: "EUR" }
  13:   end
  17:   def apply_pharmacy_markup(price)
- 18:     markup = @pharmacy.auto_accept_orders? ? 1.05 : 1.08
- 19:     (price * markup).round
  20:   end
  22:   def apply_volume_discount(price)
- 23:     return price if @product.stock.to_i < 100
- 24:     (price * 0.96).round
  25:   end
  27:   def apply_seasonal_adjustment(price)
- 28:     month = Time.current.month
- 29:     if [11, 12, 1].include?(month)
- 30:       (price * 1.08).round # winter markup
- 31:     elsif [6, 7, 8].include?(month)
- 32:       (price * 0.95).round # summer discount
  33:     else
- 34:       price
  35:     end
```
### `app/services/payment_service.rb` — 60.0%

Uncovered lines: `20, 21, 25, 26, 28, 35, 36, 37, 39, 41`

```ruby
  19:   def refund!
- 20:     raise PaymentError, "Cannot refund pending order" if @order.status == "pending"
- 21:     { status: :refunded, amount: @order.total_cents }
  22:   end
  24:   def handle_timeout
- 25:     if @order.cod?
- 26:       @order.cancel!(reason: "payment_timeout")
  27:     else
- 28:       retry_capture
  29:     end
  34:   def retry_capture
- 35:     3.times do |attempt|
- 36:       result = capture!
- 37:       return result if result[:status] == :captured
  38:     rescue PaymentError
- 39:       next
  40:     end
- 41:     @order.cancel!(reason: "capture_failed_after_retries")
  42:   end
```
### `app/models/order.rb` — 70.0%

Uncovered lines: `25, 29, 37, 41, 42, 43`

```ruby
  24:   def cancel!(reason: nil)
- 25:     update!(status: "cancelled", notes: reason)
  26:   end
  28:   def cod?
- 29:     payment_method == "cod"
  30:   end
  36:   def awaiting_cod_confirmation?
- 37:     cod? && status == "pending"
  38:   end
  40:   def handle_cod_timeout
- 41:     return unless payment_method == "cod"
- 42:     cancel!(reason: "cod_timeout") if awaiting_cod_confirmation?
- 43:     notify_cs_team(:cod_timeout_alert)
  44:   end
```
### `app/services/cart_optimizer.rb` — 71.4%

Uncovered lines: `30, 31, 35, 39, 40, 41, 43, 49`

```ruby
  29:   def calculate_absorption(pharmacy, product)
- 30:     ratio = pharmacy.id.to_f / (product.price_cents + 1)
- 31:     ratio > max_absorption ? max_absorption : ratio
  32:   end
  34:   def max_absorption
- 35:     0.15
  36:   end
  38:   def apply_discounts(items)
- 39:     items.map do |item|
- 40:       if item[:price] > 4000
- 41:         item.merge(discount: (item[:price] * 0.05).round)
  42:       else
- 43:         item
  44:       end
  48:   def validate_availability(pharmacy, products)
- 49:     products.all? { |p| p.in_stock? }
  50:   end
```
### `app/jobs/inventory_sync_job.rb` — 100.0%

### `app/models/order_item.rb` — 100.0%

### `app/services/shipping_calculator.rb` — 100.0%


---

## Files Below 80% Coverage

| File | Coverage | Missed | Churn | Risk |
|------|----------|--------|-------|------|
| `app/services/pricing_engine.rb` | 29.2% | 17 | 1 | 71 |
| `app/models/order.rb` | 78.6% | 6 | 2 | 43 |
| `app/services/payment_service.rb` | 60.0% | 10 | 1 | 40 |
| `app/services/cart_optimizer.rb` | 71.4% | 8 | 1 | 29 |

---

## Action Items

- [ ] **Diff coverage below threshold** (70.1% < 90%)
  - `app/services/pricing_engine.rb`: 17 uncovered lines
  - `app/services/payment_service.rb`: 10 uncovered lines
  - `app/models/order.rb`: 6 uncovered lines
  - `app/services/cart_optimizer.rb`: 8 uncovered lines