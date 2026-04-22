resource "aws_sns_topic" "alert_topic" {
  name = "muhs-alert-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = "madmoohs@gmail.com"
}

resource "aws_cloudwatch_metric_alarm" "info_count_alarm" {
  alarm_name          = "muhs-info-count-breach"
  alarm_description   = "Triggers when INFO log count exceed 10 in 1 minute"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 10
  period              = 60

  namespace   = "/moviedb-api/muhs"
  metric_name = "info-count"
  statistic   = "Sum"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alert_topic.arn
  ]

  ok_actions = [
    aws_sns_topic.alert_topic.arn
  ]
}