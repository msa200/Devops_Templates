resource "aws_ecr_repository" "s3_backup" {
  name                 = "s3_backup"
}

resource "aws_ecr_lifecycle_policy" "s3_backup" {
  repository = "${aws_ecr_repository.s3_backup.name}"
 
  policy = <<EOF
  {
   "rules" : [{
     "rulePriority" : 1,
     "description"  : "keep last 10 images",
     "action"       : {
       "type" : "expire"
     },
     "selection"     : {
       "tagStatus"   : "any",
       "countType"   : "imageCountMoreThan",
       "countNumber" : 10
     }
   }]}
   EOF
  
}
