<#
    .SYNOPSIS
        Downloads Images.'data-src' from the images element of a webpage to the Downloads folder
        of the account running the script.

    .DESCRIPTION
        This was used to download 70+ images of wiring schematics from an automotive forum.
        The code may or may not work for you depending on what you're trying to do.
        Either way, hopefully it can provide some ideas.

    .PARAMETER Uri
        Specifies the uri to download the images from.
#>
[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true)]
    [uri]
    $Uri
)

$downloadFolder = Join-Path -Path $HOME -ChildPath 'DownLoads'

$webRequest = Invoke-WebRequest -Uri $uri

$imageUrls = $webRequest.Images.'data-src'

foreach ($imageUrl in $imageUrls)
{
    if (![string]::IsNullOrWhiteSpace($imageUrl))
    {
        $uri = [uri]$imageUrl
        $outputPath = Join-Path -Path $downloadFolder -ChildPath $uri.Segments[-1]
        Invoke-WebRequest -Uri $uri.AbsoluteUri -OutFile $outputPath
    }
}
