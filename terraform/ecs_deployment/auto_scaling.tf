resource "aws_appautoscaling_target" "ECS_AUTOSCALLING_TARGET" {
    max_capacity       = "7"
    min_capacity       = "1"
    resource_id        = "service/company/${aws_ecs_service.webapp.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
}
resource "aws_appautoscaling_policy" "ECS_SERVICE_SCALLING_POLICY" {
    name = "ECS service auto scalling policy"
    resource_id = "${aws_appautoscaling_target.ECS_AUTOSCALLING_TARGET.resource_id}"
    scalable_dimension = "${aws_appautoscaling_target.ECS_AUTOSCALLING_TARGET.scalable_dimension}"
    service_namespace = "${aws_appautoscaling_target.ECS_AUTOSCALLING_TARGET.service_namespace}"
    policy_type = "TargetTrackingScaling"
    target_tracking_scaling_policy_configuration {
        target_value = "50"
        predefined_metric_specification {
            predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }
    }
}
