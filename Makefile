lint:  ## Lint the code using terraform fmt
	terraform fmt -recursive

check: ## Check and validate the terraform code
	terraform fmt -recursive -diff -check -list=true
	terraform validate

plan:  ## Plan a terraform run
	terraform plan