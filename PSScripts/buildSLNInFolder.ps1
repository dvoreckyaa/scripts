param([string]$folderName = "C:\_projects\ERP\Current\Extensibility\CSF"
    #[string]$outputFolderName = "C:\_projects\ERP\Current\Deployment\Server\Assemblies"
)

function buildVS {
    param
    (
        [parameter(Mandatory = $true)]
        [String] $path,

        [parameter(Mandatory = $false)]
        [bool] $nuget = $true,
        
        [parameter(Mandatory = $false)]
        [bool] $clean = $true
    )
    process {
        #$msBuildExe = 'C:\Program Files (x86)\MSBuild\15.0\Bin\msbuild.exe'

        if ($nuget) {
            Write-Host "Restoring NuGet packages" -foregroundcolor green
            nuget restore "$($path)"
        }

        if ($clean) {
            Write-Host "Cleaning $($path)" -foregroundcolor green
            #& "$($msBuildExe)" "$($path)" /t:Clean /m
            dotnet clean "$path"
        }

        Write-Host "Building $($path)" -foregroundcolor green
        #& "$($msBuildExe)" "$($path)" /t:Build /m
        dotnet publish "$path"  --configuration Release --no-dependencies #--output $outputFolderName
    }
}


$slnFiles = get-childitem -Path $folderName -include "*.sln" -recurse
$index = 1  
$slnFiles | 
    Foreach-Object {
        $percentDone = (($index / $slnFiles.Count) * 100)
        Write-Progress -activity "Building,.." -status "$($_.Name)"  -percentComplete $percentDone
        buildVS $_.FullName $false $true
    }

