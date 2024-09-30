variable "GITHUB_USERNAME" {
  description = "Username to retrieve images"
  type        = string
  default = ""
}

variable "GITHUB_TOKEN" {
  description = "Token to retrieve images"
  type        = string
  default = ""
}

variable "common_tags" {
  description = "Common tags for created resources"
  default = {
    Application = "WFPREV"
  }
}

variable "target_env" {
  description = "AWS workload account env (e.g. dev, test, prod, sandbox, unclass)"
  type        = string
}

variable "client_cpu_units" {
  description = "client instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
}

variable "client_memory" {
  description = "client instance memory to provision (in MiB)"
  type        = number
}

variable "server_cpu_units" {
  description = "server CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
}

variable "server_memory" {
  description = "server memory to provision (in MiB)"
  type        = number
}

variable "client_container_name" {
  description = "Container name"
  default     = "wfprev-client-app"
}

variable "server_container_name" {
  description = "Server container name"
  default     = "wfprev-server-app"
}

variable "CLIENT_IMAGE" {
  description = "Docker image to run in the ECS cluster. _Note_: there is a blank default value, which will cause service and task resource creation to be supressed unless an image is specified."
  type        = string
  default     = ""
}
variable "server_image" {
  description = "Docker image to run in the ECS cluster. _Note_: there is a blank default value, which will cause service and task resource creation to be supressed unless an image is specified."
  type        = string
  default     = ""
}

variable "client_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8081
}

variable "server_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 443
}

variable "logging_level" {
  type        = string
  description = "Logging level for components"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "ca-central-1"
}

variable "WEBADE_OAUTH2_REST_CLIENT_ID" {
  type    = string
  default = ""
}

variable "WEBADE-OAUTH2_TOKEN_CLIENT_URL" {
  type    = string
  default = ""
}

variable "WEBADE-OAUTH2_TOKEN_URL" {
  type    = string
  default = ""
}

variable "DEFAULT_APPLICATION_ENVIRONMENT" {
  type    = string
  default = ""
}

variable "WFPREV_USERNAME" {
  type    = string
  default = ""
}

variable "db_pass" {
  description = "db password, passed in as env variable at runtime"
  type        = string
}

variable "api_key" {
  description = "value for api key"
  type        = string
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "wfprev-server-app"
}

variable "server_count" {
  description = "Number of docker containers to run"
  default     = 2
}

//load balancers
variable "ALB_NAME" {
  description = "Name of the internal alb"
  default     = "default"
  type        = string
}

variable "TARGET_ENV" {
  description = "AWS workload account env (e.g. dev, test, prod, sandbox, unclass)"
  type        = string
  default = ""
}

variable "WFPREV_API_PORT" {
  description = "Port exposed by the docker image to redirect traffic to"
  type = number
  default     = 443
}

variable "WFPREV_UI_PORT" {
  type = number
  default = 8080
}

variable "WEBADE_OAUTH2_WFPREV_UI_CLIENT_SECRET" {
  type    = string
  default = ""
}

variable "WEBADE-OAUTH2_CHECK_TOKEN_URL" {
  type    = string
  default = ""
}

variable "client_name" {
  description = "Name of the client"
  type        = string
  default     = "wfprev-client-app"
}

variable "gov_client_url" {
  description = "domain name if using *.nrs.gov.bc.ca url"
  default     = ""
  type        = string
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "wfprevEcsTaskExecutionRole"
}

variable "gov_api_url" {
  description = "domain name if using *-api.nrs.gov.bc.ca url"
  default     = ""
  type        = string
}