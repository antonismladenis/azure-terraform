// Placeholder will need to write some tests in the future

package test

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestKeyvaultModule(t *testing.T) {

	// terraform options struct
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./",
	}

	// CleanUp everything
	defer terraform.Destroy(t, terraformOptions)

	// Runs terraform init with the given options and returns stdout/stderr from the plan command
	fmt.Println("##### Terraform Init #####")
	terraform.Init(t, terraformOptions)

	// Runs terraform validate
	fmt.Println("##### Terraform Validate #####")
	terraform.Validate(t, terraformOptionsValidate)

	// Runs terraform plan with the given options and returns stdout/stderr from the plan command
	fmt.Println("##### Terraform Plan #####")
	terraform.Plan(t, terraformOptions)

	// Runs terraform apply
	fmt.Println("##### Terraform Apply #####")
	terraform.Apply(t, terraformOptions)
}
