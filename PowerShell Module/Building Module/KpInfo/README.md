# The KpInfo PowerShell Module

The module allows to quickly access the information I find important like info about cats.

## Folder structure

- All building files must in Source folders:
  - In the root, place the module manifest
    - In Public, place functions accessible by users
    - In Private, place functions that inaccessible by users, e.g. helper functions
    - Place one function per file, and file name must match the name of the function
- In the root of the repository we have:
  - Install-Requirements.ps1, this script installs all required modules for this module to be built
  - Start-ModuleBuild.ps1, builds the module with files from Source folder and puts thm into Output folder

## About ModuleBuilder

You can find source of ModuleBuilder [here](https://github.com/PoshCode/ModuleBuilder)
