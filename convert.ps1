# Ask the user for the input POV file path
$inputFile = Read-Host "Enter the path to the input POV file"

try {
    # Read the input file
    $povInput = Get-Content $inputFile -Raw

    # Remove comments from the input
    $povInput = $povInput -replace "//.*"

    # Define a regex pattern to match triangle blocks
    $pattern = "(triangle\s*{[^}]+})"

    # Extract the triangle blocks from the input
    $triangleBlocks = [regex]::Matches($povInput, $pattern) | ForEach-Object { $_.Value }

    # Process the triangle blocks to extract the coordinates
    $coordinates = @()
    foreach ($block in $triangleBlocks) {
        $matches = $block | Select-String -Pattern "<(.*?)>" -AllMatches
        $points = $matches.Matches.Value -replace "[<>]"
        $coordinates += $points
    }

    # Process the vertex vectors block to extract the vertex coordinates
    $vertexVectors = $povInput | Select-String -Pattern "vertex_vectors\s*{[^}]+}" | Select-Object -First 1 -ExpandProperty Line
    $matches = $vertexVectors | Select-String -Pattern "<(.*?)>" -AllMatches
    $vertexCoordinates = $matches.Matches.Value -replace "[<>]"

    # Construct the X3D output
    $coordIndex = 2..($triangleBlocks.Count * 3 + 1) | ForEach-Object {
        if ($_ % 3 -eq 0) {
            "$($_ - 2) $($_ - 3) $($_ - 1)"
        }
    }
    $coordIndex = $coordIndex -join "`n"

    $output = @"
<X3D version="3.3" xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" profile="Interchange">
  <Scene>
    <Shape>
      <geometry>
        <IndexedTriangleSet>
          <coord>
            <Coordinate point="
              {
              $($coordinates -join "`n")
              $($vertexCoordinates -join "`n")
              $($coordinates[0..8] -join "`n")  
            "/>
          </coord>
# the coordIndex is not showing all the coordinates for some reasons
          <coordIndex>
          
            $coordIndex
          </coordIndex>
        </IndexedTriangleSet>
      </geometry>
    </Shape>
  </Scene>
</X3D>
"@

    # Print the final output
    Write-Output $output
}
catch {
    Write-Host "Error: $_"
}
