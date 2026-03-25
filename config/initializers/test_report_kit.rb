if Rails.env.test?
  TestReportKit.configure do |config|
    config.project_name = "test_report_kit_demo"
    config.output_dir = Rails.root.join("tmp/test_report").to_s
    config.diff_base_branch = "main"
    config.coverage_threshold = 80
    config.diff_coverage_threshold = 90
    config.churn_days = 90
    config.slow_test_threshold = 5.0
  end
end
