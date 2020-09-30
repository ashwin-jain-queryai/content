BeforeAll {
	. $PSScriptRoot\MicrosoftECM.ps1
}


Describe 'ParseDateTimeObjectToIso' {
	It 'Check date is parsed to ISO format correctly' {
		ParseDateTimeObjectToIso (Get-Date -year 2020 -month 12 -day 12 -hour 15 -minute 00 -second 00) | "2020-12-12T13:00:00Z"
	}
}

Describe 'AssertNoMoreThenExpectedParametersGiven' {
	It "Assert no error is raised on valid output"{
		AssertNoMoreThenExpectedParametersGiven "error message" 1 "First"
	}
	It "Assert exception is raised with non valid output" {
		AssertNoMoreThenExpectedParametersGiven "error message" 1 "First" "Second" | Should -Be "error message"
	}
}

Describe "ValidateGetCollectionListParams" {
	It "Validating with both collectionId and collectionName throws an exception" {
		ValidateGetCollectionListParams "collection_id" "collection_name" | Should -Be "Please select only one of: collection_id, collection_name."
	}
	It "Validating with collectionId only" {
		ValidateGetCollectionListParams "collection_id" $null | Should -Be "collection_id"
	}
	It "Validating with collectionName only" {
		ValidateGetCollectionListParams $null "collection_name" | Should -Be "collection_name"
	}
	It "Validating with no parameters" {
		ValidateGetCollectionListParams $null $null | Should -Be ""
	}
}
Describe "ValidateGetDeviceListParams" {
	It "Validating Collection ID only" {
		ValidateGetDeviceListParams "collection_id" $null $null $null | Should -Be "collection_id"
	}
	It "Validating with collection name only" {
		ValidateGetDeviceListParams $null "collection_name" $null $null | Should -Be "collection_name"
	}
	It "Validating with device name only"{
		ValidateGetDeviceListParams $null $null "device name" $null | Should -Be "device_name"
	}
	It "Validating with resource ID only"{
		ValidateGetDeviceListParams $null $null $null "resource_id" | Should -Be "resource_id"
	}
	It "Validating collection ID and Collection name throws exception" {
		ValidateGetDeviceListParams "collection_id" "collection_name" $null $null | Should -Be "collection_id parameter can be resolved only with device_name"
	}
	It "Validating devica name and resource ID throws exception" {
		ValidateGetDeviceListParams $null $null "device name" "resource_id" | Should -Be "device_name parameter can be resolved only with collection_name or collection_id"
	}
}
Describe "ValidateCreateScriptParams" {
	It "Validate with both script_file_entry_id and script_text throws exception" {
		ValidateCreateScriptParams "script_file_entry_id" "script_text" | Should -Be "script_file_entry_id cannot be resolved with script_text"
	}
	It "Validate with script_file_entry_id only" {
		ValidateCreateScriptParams "script_file_entry_id" $null | Should -Be "script_path"
	}
	It "Validate with script_text only" {
		ValidateCreateScriptParams $null "script_text" | Should -Be "script_text"
	}
	It "Validate no parameters throws exception" {
		ValidateCreateScriptParams $null $null | Should -Be "Please supply either script_file_entry_id or script_text"
	}
}
#Describe "ValidateIncludeOrExcludeDeviceCollectionParameters"{
#
#}
#
#Describe "ParseCollectionObject" {
#
#}
#
#Describe "ParseScriptInvocationResults" {
#
#}
#
#Describe "ParseScriptObject" {
#
#}
