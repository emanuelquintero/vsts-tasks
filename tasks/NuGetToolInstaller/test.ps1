
# use:
# ./test.ps1 <versionSpec> <StableOnly> <RemoveDirs>

#
# Set things the agent would usually set that the tool lib needs
#
param([string]$1, [boolean]$2, [boolean]$3)

$env:AGENT_VERSION="2.115.0"
$env:AGENT_TOOLSDIRECTORY="/Users/jahquin/Testing/AGENTTOOLS"
$env:AGENT_TEMPDIRECTORY="/Users/jahquin/Testing/AGENTTEMP"

if($3)
{
    Remove-Item -Recurse -Force $env:AGENT_TOOLSDIRECTORY
    Remove-Item -Recurse -Force $env:AGENT_TEMPDIRECTORY
}

New-Item -ItemType Directory -Force $env:AGENT_TOOLSDIRECTORY
New-Item -ItemType Directory -Force $env:AGENT_TEMPDIRECTORY

#
# Set task inputs from args
#
$env:INPUT_VERSIONSPEC=$1
$env:INPUT_STABLEONLY=$2

#
# Run the task
#
# pushd /Users/jahquin/Projects/vsts-tasks/_build/Tasks/NodeTool
node nugetToolInstaller.js
# popd

# ensure it downloaded and extracted
Get-ChildItem -r -Path $env:AGENT_TOOLSDIRECTORY
