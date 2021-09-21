#!/bin/bash

cd $path_cwd
dir_name=lambda_pkg_tb/
mkdir $dir_name

# Deactivate virtual environment...
deactivate

# Create deployment package...
echo "Creating deployment package..."
cd env_$function_name/lib/$runtime/site-packages/
cp -r . $path_cwd/$dir_name
cp -r $path_cwd/lambda_function/ $path_cwd/$dir_name

# Removing virtual environment folder...
echo "Removing virtual environment folder..."
rm -rf $path_cwd/env_$function_name

echo "Finished script execution!"