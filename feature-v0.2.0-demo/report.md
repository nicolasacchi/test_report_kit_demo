# Test Report: test_report_kit_demo

Generated: 2026-03-27T13:22:40+00:00  
Branch: `feature/v0.2.0-demo` | SHA: `6cee9020a0e1df7eab488ed6baa38002d318df4c`

---

## Summary

| Metric | Value |
|--------|-------|
| Line Coverage | 77.0% (137/178) |
| Branch Coverage | 43.4% |
| Duration | 0s |
| Examples | 40 (0 failures, 0 pending) |
| Factory Creates | 67 |

---

## Files Below 80% Coverage

| File | Coverage | Missed | Churn | Risk |
|------|----------|--------|-------|------|
| `app/services/pricing_engine.rb` | 29.2% | 17 | 11 | 779 |
| `app/services/payment_service.rb` | 60.0% | 10 | 6 | 240 |
| `app/services/cart_optimizer.rb` | 71.4% | 8 | 6 | 172 |
| `app/models/order.rb` | 78.6% | 6 | 6 | 128 |

---

## Action Items

- [ ] **High-risk** `app/services/pricing_engine.rb`: 29.2% coverage, 11 commits
- [ ] **High-risk** `app/services/payment_service.rb`: 60.0% coverage, 6 commits
- [ ] **Untested hot path** `app/services/pricing_engine.rb`: 11 commits, 0% coverage