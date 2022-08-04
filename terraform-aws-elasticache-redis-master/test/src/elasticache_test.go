package test

import (
	"math/rand"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	rand.Seed(time.Now().UnixNano())

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "C:/Users/suhas/OneDrive/Desktop/elasticcache",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"terraform.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	nodetype := terraform.Output(t, terraformOptions, "node_type")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "cache.m4.small", nodetype)

	// Run `terraform output` to get the value of an output variable
	clusterId := terraform.Output(t, terraformOptions, "id")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "redis", clusterId)

	terraformOptions.Vars = map[string]interface{}{}

	terraformOptions.Parallelism = 1

	//needed only incase u are testing with new security group
	terraform.Apply(t, terraformOptions)

	// Restore parallelism for destroy operation
	terraformOptions.Parallelism = 10
}
