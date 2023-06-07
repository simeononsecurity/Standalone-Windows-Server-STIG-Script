FROM mcr.microsoft.com/windows/server:ltsc2022-amd64

LABEL org.opencontainers.image.source="https://github.com/simeononsecurity/standalone-windows-server-stig"
LABEL org.opencontainers.image.description="Test Image for SimeonOnSecurity"
LABEL org.opencontainers.image.authors="simeononsecurity"
LABEL BaseImage="windows/server:ltsc2022-amd64"
LABEL RunnerVersion=${RUNNER_VERSION}

ARG RUNNER_VERSION
ENV container docker
ENV chocolateyUseWindowsCompression false
SHELL ["powershell.exe"]
RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); choco feature disable --name showDownloadProgress; choco feature enable -n allowGlobalConfirmation



RUN Import-Module $env:ChocolateyInstall\\helpers\\chocolateyProfile.psm1
#RUN Write-Host "Install Latest Windows Updates" ; choco install pswindowsupdate; Set-Executionpolicy -ExecutionPolicy RemoteSigned -Force ; Import-Module PSWindowsUpdate -Force ; 
#RUN refreshenv
#RUN Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false ; Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install ; Get-WuInstall -AcceptAll -IgnoreReboot -IgnoreUserInput -nottitle 'preview' ; Get-WindowsUpdate –Install    

RUN iex ((New-Object System.Net.WebClient).DownloadString('https://simeononsecurity.ch/scripts/standalonewindowsserver.ps1'))

ENTRYPOINT ENTRYPOINT [ "powershell.exe" ]
