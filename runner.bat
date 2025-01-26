@echo off
GOTO:MAIN

:cleanup
    rmdir  /s /q build
    rmdir  /s /q dist
    rmdir  /s /q keywords
    rmdir  /s /q src\robotframework_BehaviorTreeLibrary.egg-info
EXIT /b 0

:dependency
    call python -m pip install --upgrade pip setuptools wheel
    call pip install -r requirements-dev.txt
EXIT /B %ERRORLEVEL%

:build
    call:cleanup
    call:dependency
    call python setup.py sdist bdist_wheel
    call python libdoc.py
EXIT /B %ERRORLEVEL%

:install
    call:build
    call pip install .
EXIT /B %ERRORLEVEL%

:test_unit
    call cd atests
    call python Treenator_unit_test.py
    call cd ..
EXIT /B %ERRORLEVEL%

:test_robot
    call cd atests
    call robot --outputdir ../result/ .
    call cd ..
EXIT /B %ERRORLEVEL%

:test
    call:install
    call:test_unit
    set /A result = %ERRORLEVEL%
    mkdir result
    call:test_robot
    if %result%==0 set /A result = %ERRORLEVEL%
    call rebot --name ATests --outputdir result -x rebot_xunit.xml result/output.xml
    call:cleanup
EXIT /B %result%

:MAIN
IF NOT "%~1" == "" call:%1
