resource "aws_s3_bucket" "ingested_bucket"{
    bucket = "ingested-data-lambda-legends-24"
    force_destroy = true
tags = {
  Name = "ingested-data-lambda-legends-24"
  Eviroment = "Dev"
  Project = "Lambda Legends Data Processor"

}
}

resource "aws_s3_bucket" "lambda_code_bucket" {

  bucket_prefix = "lambda-extract-code-bucket-"
  force_destroy = true 

tags = {
  Name = "lambda-extract-code-bucket-"
  Eviroment = "Dev"
  Project = "Lambda Legends Data Processor"

}
}


resource "aws_s3_object" "lambda_code" {
bucket =  aws_s3_bucket.lambda_code_bucket.bucket
key    =  "ingestion_lambda/extract_data.zip"
source =  "${path.module}/../extract_data.zip"
}

resource "aws_s3_object" "layer_code" {
bucket =  aws_s3_bucket.lambda_code_bucket.bucket
key    =  "layer/layer.zip"
source =  data.archive_file.layer.output_path
depends_on = [ data.archive_file.layer]
}
