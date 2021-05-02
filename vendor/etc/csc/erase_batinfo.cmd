@echo off

adb shell setprop dbg.battery.changed 1

for /f %%i in ('adb shell getprop dbg.battery.changed') do (
  set str=%%i
)

if "%str%" EQU "1" (
    @echo 0
) else (
    @echo 1
)

cmd /k
