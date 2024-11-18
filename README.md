# R_standard_project

Instructions come from https://happygitwithr.com

```
## install if needed (do this exactly once):
## install.packages("usethis")

library(usethis)
use_git_config(user.name = "ludwiglist", 
               user.email = "pilen_dragostea@simplelogin.com")

## set your default initial branch name to main
usethis::git_default_branch_configure()

## create github PAT (personal access token)
usethis::create_github_token()

## store PAT
gitcreds::gitcreds_set()

## create a local directory, linked to a remote GitHub repository
usethis::create_from_github(
  "https://github.com/progecon/myrepo.git", ## URL of the remote repo
  destdir = "C:/Users/listl/OneDrive - FES/R projects" ## path to where you want the local repo
)
```
