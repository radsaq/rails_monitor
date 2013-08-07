class ExampleMonitoringController < ActionController::Base
  include RailsMonitor::Monitoring

  status_tab :tab_one, [
    :test_status_one,
    :test_status_two
  ]

  status_tab :tab_two, [
    :test_status_three,
    :test_status_four
  ]

  status_tab :tab_three, [
    :test_warn_numeric,
    :test_error_numeric,
    :test_error_boolean
  ]

  numeric_status :test_status_one do
    10
  end

  numeric_status :test_status_two do
    20
  end

  boolean_status :test_status_three do
    true
  end

  boolean_status :test_status_four do
    false
  end

  numeric_status :test_warn_numeric, 10, 20 do
    15
  end

  numeric_status :test_error_numeric, 10, 20 do
    25
  end

  boolean_status :test_error_boolean do
    false
  end
end
