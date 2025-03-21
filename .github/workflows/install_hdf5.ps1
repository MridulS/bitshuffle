param(
    [Parameter(Mandatory=$true)]
    [string]$HDF5_DISTRIBUTION
)

# Extract the patch number
$HDF5_VERSION = $HDF5_DISTRIBUTION.Split('-')[0]
$HDF5_VERSION_MAJOR_MINOR = $HDF5_VERSION.Substring(0, $HDF5_VERSION.LastIndexOf('.'))

# Download HDF5 from source
$url = "https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_VERSION_MAJOR_MINOR/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_DISTRIBUTION.zip"
$outputFile = "hdf5-$HDF5_DISTRIBUTION.zip"
Write-Host "Downloading HDF5 from $url"
Invoke-WebRequest -Uri $url -OutFile $outputFile

# Extract the archive
Write-Host "Extracting HDF5 archive..."
Expand-Archive -Path $outputFile -DestinationPath .

# Build and install with CMake
cd "hdf5-$HDF5_DISTRIBUTION"
mkdir build
cd build

# Configure with CMake
Write-Host "Configuring HDF5 with CMake..."
cmake -G "Visual Studio 17 2022" -A x64 -DCMAKE_INSTALL_PREFIX="C:/hdf5" ..

# Build
Write-Host "Building HDF5..."
cmake --build . --config Release

# Install
Write-Host "Installing HDF5..."
cmake --install . --config Release

# Return to the original directory
cd ../..
Write-Host "HDF5 installation complete" 