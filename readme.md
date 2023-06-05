# POV to X3D Converter

----------------------------------

## Description
The POV to X3D Converter is a PowerShell script that converts a POV-Ray mesh representation into the X3D format. It takes a POV-Ray script file as input, extracts the triangle coordinates and vertex vectors, and generates an X3D file with the corresponding geometry.

## Prerequisites

PowerShell 5.1 or later

## Usage
Open a PowerShell console or terminal.
Navigate to the directory where the script is located.
Run the script using the following command:
Copy code

``` .\convert.ps1 ```
The script will prompt you to enter the path to the input POV-Ray script file. Provide the full path or relative path to the file and press Enter.
The script will process the file, convert the mesh representation into x3d representation
## Notes
The script ignores any comments present in the input POV-Ray script file.
If any errors occur during the conversion process, an error message will be displayed.
The script assumes the input POV-Ray script follows the specified format. Incorrectly formatted input may result in unexpected behavior.

## GitHub Repo

https://github.com/Njoura7/PowershellScript