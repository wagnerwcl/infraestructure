resource "aws_budgets_budget" "this" {
  name         = "Don't make me poor" 
  budget_type  = "COST"
  limit_amount = "15"
  limit_unit   = "USD"
  time_unit    = "MONTHLY" 

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 14
    threshold_type             = "ABSOLUTE_VALUE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["wagner.william.cl@gmail.com"]
  }
}

