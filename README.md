# csc-err-139-repro

The repo is a minimal reproducible example of an error during `dotnet build` of a pretty much empty dotnet project which gives the following error:
```
/usr/share/dotnet/sdk/7.0.302/Roslyn/Microsoft.CSharp.Core.targets(80,5): error MSB6006: "csc.dll" exited with code 139. [/TestMini/TestMini.csproj]
```

# Steps to repro

## Build docker with specific dotnet SDK on Ubuntu 23.04
Execute `docker build .` and build a container. Provided Dockerfile will copy the sample project into container, install dotnet dependencies (listed in the official documentation and curl) and then it will install dotnet 7.0.302 using dotnet-install.sh script.

## Run built container and exec bash into it
Execute `docker run IMAGE_ID` and then `docker exec -it CONTAINER_ID bash`

## Try building provided sample project
Execute `dotnet build .` from container, it gives the following output:
```
wayne@wayne-B11:~/t/TestMini$ docker ps
CONTAINER ID   IMAGE          COMMAND               CREATED         STATUS         PORTS     NAMES
c0ca95498796   009f34774294   "tail -f /dev/null"   6 seconds ago   Up 5 seconds             peaceful_goldwasser
wayne@wayne-B11:~/t/TestMini$ docker exec -it c0ca95498796 bash
root@c0ca95498796:/# dotnet build .

Welcome to .NET 7.0!
---------------------
SDK Version: 7.0.302

Telemetry
---------
The .NET tools collect usage data in order to help us improve your experience. It is collected by Microsoft and shared with the community. You can opt-out of telemetry by setting the DOTNET_CLI_TELEMETRY_OPTOUT environment variable to '1' or 'true' using your favorite shell.

Read more about .NET CLI Tools telemetry: https://aka.ms/dotnet-cli-telemetry

----------------
Installed an ASP.NET Core HTTPS development certificate.
To trust the certificate run 'dotnet dev-certs https --trust' (Windows and macOS only).
Learn about HTTPS: https://aka.ms/dotnet-https
----------------
Write your first app: https://aka.ms/dotnet-hello-world
Find out what's new: https://aka.ms/dotnet-whats-new
Explore documentation: https://aka.ms/dotnet-docs
Report issues and find source on GitHub: https://github.com/dotnet/core
Use 'dotnet --help' to see available commands or visit: https://aka.ms/dotnet-cli
--------------------------------------------------------------------------------------
MSBuild version 17.6.1+8ffc3fe3d for .NET
  Determining projects to restore...
  Restored /TestMini/TestMini.csproj (in 56 ms).
/usr/share/dotnet/sdk/7.0.302/Roslyn/Microsoft.CSharp.Core.targets(80,5): error MSB6006: "csc.dll" exited with code 139. [/TestMini/TestMini.csproj]

Build FAILED.

/usr/share/dotnet/sdk/7.0.302/Roslyn/Microsoft.CSharp.Core.targets(80,5): error MSB6006: "csc.dll" exited with code 139. [/TestMini/TestMini.csproj]
    0 Warning(s)
    1 Error(s)

Time Elapsed 00:00:02.71
root@c0ca95498796:/# exit
exit
```

Just in case, my docker version: `Docker version 20.10.17, build 100c701`
