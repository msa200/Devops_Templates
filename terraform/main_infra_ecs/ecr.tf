resource "aws_ecr_repository" "company" {
  name                 = "company-registry"
  image_tag_mutability = "MUTABLE"
  
}



resource "aws_ecr_lifecycle_policy" "company" {
  repository = "${aws_ecr_repository.company.name}"
 
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
resource "aws_ecr_repository" "front" {
  name                 = "front-registry"
  image_tag_mutability = "MUTABLE"
  
}



resource "aws_ecr_lifecycle_policy" "front" {
  repository = "${aws_ecr_repository.front.name}"
 
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



