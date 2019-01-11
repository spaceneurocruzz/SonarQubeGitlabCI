@ECHO off

CALL :build
GOTO:eof

:build
FOR  /r  %%L IN (*.sln) DO (
echo Doing  %%L ...........
call %SONARSCANNER% begin /k:"%%~nL" /v:"1.0" /d:sonar.analysis.mode=publish /d:sonar.gitlab.commit_sha=%CI_COMMIT_SHA% /d:sonar.gitlab.project_id=%CI_PROJECT_ID% /d:sonar.gitlab.ref_name=%CI_COMMIT_REF_NAME% /d:sonar.cs.opencover.reportsPaths="%%~pL%%~nLTest\projectCoverageReport.xml"
dotnet build %%L
call %SONARSCANNER% end
)

EXIT /B ```