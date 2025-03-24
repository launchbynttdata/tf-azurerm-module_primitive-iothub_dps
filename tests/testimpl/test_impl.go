package common

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"

	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/deviceprovisioningservices/armdeviceprovisioningservices"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestIothubDps(t *testing.T, ctx types.TestContext) {

	subscriptionID := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionID) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID is not set in the environment variables ")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	clientFactory, err := armdeviceprovisioningservices.NewClientFactory(subscriptionID, credential, &options)

	if err != nil {
		t.Fatalf("Error creating device provisioning services client: %v", err)
	}

	t.Run("CheckDeviceProvisioningServiceId", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		dpsName := terraform.Output(t, ctx.TerratestTerraformOptions(), "name")
		dpsId := terraform.Output(t, ctx.TerratestTerraformOptions(), "id")

		res, err := clientFactory.NewIotDpsResourceClient().Get(context.Background(), dpsName, resourceGroupName, nil)
		if err != nil {
			t.Fatalf("Error getting device provisioning service name: %v", err)
		}

		assert.Equal(t, dpsId, *res.ID, "Device Provisioning Service Id's do not match.")
	})
}
