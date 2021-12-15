# Welcome to Ben's Stock Prediction Dashboard

The goal of this project is to make use of Github Actions for Continuous integration (CI) to update the output prediction of stock prices every time changes to the code are made and pushed them to the repo. 

You may see the output chart at the Github pages link: [https://benchiatc.github.io/devops3/](https://benchiatc.github.io/devops3/)

# Overview
Machine Learning and Artificial Intelligence are touted to be the pinnacle of predictive analytics. As higher computing power are becoming more readily available to the masses due to improve in silicon technology, so did the prevalence for the application of AI. Neural network and its variations are undoubtedly one of the most popular choices for building artificial intelligence for predictive analytics.

However, a robust and sophisticated Neural Network model requires large amount of data and time to train which could sometimes be really painful especially when having to constantly checkback on its progress. With a CI process, one can commit and push the code and let the YML handle the rest of the process while you go for a cup of coffee - with a peace of mind that the code would be deployed reliability. 

CI/CD pipeline implemented using GitHub Actions:
- Set up self-host runner. Refer to this [link](https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners) for more details  
-   Connect to self-host runner using  the follow command in the action-runner folder (found in root folder by default)
```
$./run.cmd
```

-   Run MATLAB Command to trigger MATLAB Script
-   Save output chart from script as an artifact (can be used for troubleshooting or passed to another script as an argument)
- Pushes output chart to Github Repo which is connected to the [Github Pages](https://benchiatc.github.io/devops3/), but skip CI. This is to prevent and infinite CI loops

This pipeline is illustrated as a flow chart below.  

### CI/CD Flow diagram
[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVERcbkEoQ29tbWl0ICYgUHVzaCkgLS0gR2l0aHViIEFjdGlvbiB0cmlnZ2VycyAgWU1MIHdvcmtmbG93LS0-IEIoU2V0IHVwIGpvYiB0byBydW4gTUFUTEFCIG9uIHNlbGYtaG9zdGVkIHJ1bm5lcilcbkIgLS0-IEMoUnVuIGNvbW1hbmQgb24gTUFUTEFCKVxuQyAtLT4gRHtSdW4gc3VjY2Vzcz99IFxuRCAtLSBObyAtLT4gRShTdG9wIFdvcmtmbG93KVxuRCAtLSBZZXMgLS0-IEYoU2F2ZSBvdXRwdXQgY2hhcnQgZnJvbSBzY3JpcHQgYXMgYXJ0aWZhY3QpXG5GIC0tPiBHKFB1c2ggb3V0cHV0IGNoYXJ0IHRvIHJlcG9zaXRvcnkgYnV0IHNraXAgQ0kpXG5HIC0tPiBIKEdpdGh1YiBQYWdlcyB1cGRhdGVzIGFjY29yZGluZyB0byBuZXcgYXNzZXRzKSIsIm1lcm1haWQiOnsidGhlbWUiOiJkZWZhdWx0In0sInVwZGF0ZUVkaXRvciI6ZmFsc2UsImF1dG9TeW5jIjp0cnVlLCJ1cGRhdGVEaWFncmFtIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/edit#eyJjb2RlIjoiZ3JhcGggVERcbkEoQ29tbWl0ICYgUHVzaCkgLS0gR2l0aHViIEFjdGlvbiB0cmlnZ2VycyAgWU1MIHdvcmtmbG93LS0-IEIoU2V0IHVwIGpvYiB0byBydW4gTUFUTEFCIG9uIHNlbGYtaG9zdGVkIHJ1bm5lcilcbkIgLS0-IEMoUnVuIGNvbW1hbmQgb24gTUFUTEFCKVxuQyAtLT4gRHtSdW4gc3VjY2Vzcz99IFxuRCAtLSBObyAtLT4gRShTdG9wIFdvcmtmbG93KVxuRCAtLSBZZXMgLS0-IEYoU2F2ZSBvdXRwdXQgY2hhcnQgZnJvbSBzY3JpcHQgYXMgYXJ0aWZhY3QpXG5GIC0tPiBHKFB1c2ggb3V0cHV0IGNoYXJ0IHRvIHJlcG9zaXRvcnkgYnV0IHNraXAgQ0kpXG5HIC0tPiBIKEdpdGh1YiBQYWdlcyB1cGRhdGVzIGFjY29yZGluZyB0byBuZXcgYXNzZXRzKSIsIm1lcm1haWQiOiJ7XG4gIFwidGhlbWVcIjogXCJkZWZhdWx0XCJcbn0iLCJ1cGRhdGVFZGl0b3IiOmZhbHNlLCJhdXRvU3luYyI6dHJ1ZSwidXBkYXRlRGlhZ3JhbSI6ZmFsc2V9)

## Step by Step visualization
### 0. Start the self-hosted runner
Runner starts listening to for jobs.

![image](https://github.com/benchiatc/devops3/blob/main/assets/img/01.PNG?raw=true)

Github Pages shows old chart based on old asset

![image](https://github.com/benchiatc/devops3/blob/main/assets/img/6.PNG?raw=true)
### 1. A commit is made and pushed
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/1.PNG?raw=true)
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/2.PNG?raw=true)
### 2.Github Action triggers, self-hosted runner runs the MATLAB command
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/0.PNG?raw=true)
### 3. MATLAB starts up on local self-hosted machine and trains the Neural Network Model
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/3.PNG?raw=true)
### 4. Upon run success, MATLAB closes and stores the output chart as an artifact, and also in the assets of the local repository
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/7.PNG?raw=true)
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/8.PNG?raw=true)
### 5. Git push the output chart in the local repository to GitHub repo, but skip CI
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/9.PNG?raw=true)
### 6. Github Pages updates image with news assets based on the new computed chart
![image](https://github.com/benchiatc/devops3/blob/main/assets/img/5.PNG?raw=true)
Chart now shows the latest and improved prediction chart
