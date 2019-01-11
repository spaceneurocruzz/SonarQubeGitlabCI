# SonarQube with GitLab-CI Setup-StepByStep: DotNetCore version

This article is for analyzing the quality of your codes with SonarQube, using GitLab-CI runner to check it every time you commit your codes on GitLab. There are few tutorials online for .NET Core, not much information, therefore, I would like to share how I successfully did this after studying over the resources I could find and struggling over a bunch of problems, to save your time:)

[Environment] <br /> 
(Please check *Ref.1 to see if your environment meets the requirements. Very important!!! or you will encounter errors while running.)
1. ubuntu VM <br /> 
 ● docker for SonarQube v7.1 <br /> 
 ● sonar-gitlab-plugin for SonarQube server v3.0.0
 
2. windows7 machine <br /> 
 ● gitlab-runner v10 <br /> 
 ● SonarQube Scanner for MSBuild v4.3.1 <br /> 
 ● .NET Core SDK v2.1.4 <br /> 
 ● JVM v8

Part1. [SonarQube with GitLab]

Part2. [Sonar Scanner]

Part3. [GitLab-CI Runner]

Further Reading: SonarQube with GitLab-CI Setup-Problems solving(to be continued…)





[Setup Steps] <br /> 
[SonarQube with GitLab]
1. Run SonarQube using docker(*Ref.2).
    You need to set up SonarQube on your server. The most easiest way is to run by docker and then you can access the website through localhost.

2. Install GitLab-plugin for SonarQube.

    Login to the SonarQube server website(default username:admin, password: admin), go to Adminstration-> MarketPlace, and search for “GitLab”, and click install, after intallation, restart SonarQube.

3. Set up GitLab-plugin for SonarQube: get user token from GitLab.

    Go to GitLab, get user access token: user-> User Settings-Access Tokens, create a token and copy it.

4. Set up GitLab-plugin for SonarQube: paste url and user token from GitLab.

    Go to SonarQube: Administration-> Configuration-> GitLab, 
     ● in GitLab url: add your GitLab url
     ● in GitLab User Token: paste the token created in Step.3.
 
 5. Then the setup is done.


[Sonar Scanner] <br /> 
You need a sonar scanner for scanning your codes. According to official doc, SonarQube Scanner is recommended as the default launcher to analyze a project with SonarQube.

1. Download Sonar Scanner for MSBuild.(*Ref.3)

2. Edit the SonarQube.Analysis.xml if you need to set any configs for host url, login and password.

3. If encounter “GC overhead limit exceeded” when running, edit sonar-scanner.bat and set “SONAR_SCANNER_OPTS”.


[GitLab-CI Runner] <br /> 
You need GitLab-CI Runner to help you run your jobs and send the results back to GitLab.

1. Create a folder somewhere in your system, ex.: C:\GitLab-Runner. (*Ref.4)

2. Download the binary for x86 or amd64 and put it into the folder you created. Rename the binary to gitlab-runner.exe.

3. Run an Administrator command prompt.

4. Register the Runner by cmd: “gitlab-runner.exe register”, enter the information it asks step by step. (*Ref.5)
    4–1. GitLab Url
    4–2. Token: which you obtained in CI/CD setting page.
    4–3. Description: description for the Runner
    4–4. Tags: tags associated with the Runner, you can change this later in GitLab’s UI.
    4–5. Runner executor: eg.shell, docker…etc.

5. Install the Runner as a service and start it. (Run the service using the Built-in System or user Account)
    5–1. cmd: gitlab-runner install
    5–2. cmd: gitlab-runner start

6. Write .gitlab-ci.yml and put it under your root directory on GitLab, and it will run your script when the repository has any changes.

**Note: If sonar.analysis.mode = “publish”, you can see the report both on SonarQube and GitLab website; if it’s “preview”, it just shows the results on GitLab.


When you see it’s running and jobs are passed, and SonarQube website has the results, then it is a success.

Congratulations! All Done!

[References]<br />
https://docs.sonarqube.org/display/SONAR/Requirements<br />
https://docs.docker.com/samples/library/sonarqube/<br />
https//docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+MSBuild<br />
https://docs.gitlab.com/runner/install/windows.html<br />
https://docs.gitlab.com/runner/register/index.html<br />
