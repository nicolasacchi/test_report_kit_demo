# test_report_kit_demo

Demo Rails app showcasing [test_report_kit](https://github.com/nicolasacchi/test_report_kit) -- a unified RSpec coverage + profiling HTML dashboard that replaces Codecov.

## Live Reports

| Branch | Dashboard | Description |
|--------|-----------|-------------|
| `main` | [View Report](https://nicolasacchi.github.io/test_report_kit_demo/main/) | Full coverage report on main branch |
| `feature/add-services` | [View Report](https://nicolasacchi.github.io/test_report_kit_demo/feature-add-services/) | Feature branch with partial diff coverage |

## What the Dashboard Shows

- **Diff Coverage** -- line-by-line coverage of changed code with syntax-highlighted uncovered content
- **Coverage** -- per-file line and branch coverage with churn-based risk scores
- **Performance** -- slowest tests and RSpecDissect time distribution (hooks vs examples)
- **Factory Health** -- FactoryBot usage patterns, cascade ratios, and optimization suggestions
- **Insights** -- high-risk files, over-tested files, false security patterns, untested hot paths

## Running Locally

```bash
docker compose run --rm app bundle exec rake test_report:full
# Open tmp/test_report/index.html in your browser
```

## About the Demo

This app has deliberately varying test quality to showcase the dashboard:

| Component | Coverage | Why |
|-----------|----------|-----|
| Product | >90% | Well-tested model |
| Pharmacy | >90% | Well-tested model |
| Order | ~65% | cancel!/cod? methods deliberately untested |
| CartOptimizer | ~45% | Only happy path tested |
| PricingEngine | 0% | No specs at all (untested hot path) |
| PaymentService | ~55% | refund!/timeout not tested |
| ShippingCalculator | ~95% | Fully tested |
