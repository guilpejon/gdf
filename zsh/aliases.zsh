gdf=$HOME/.gdf

# Get operating system
platform='unknown'
unamestr=$(uname)
if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'Darwin' ]]; then
  platform='darwin'
fi

alias deploy='git checkout master && git pull origin master && git push heroku master --no-verify'
alias sdeploy='git checkout release && git pull origin release && git push staging release:master --no-verify'

alias upall='git checkout master && git pull origin master; git checkout develop && git pull origin develop; git checkout release && git pull origin release; git checkout develop-prodops && git pull origin develop-prodops; git checkout develop-product && git pull origin develop-product; git checkout develop-bugs && git pull origin develop-bugs; git checkout develop-imp && git pull origin develop-imp'

alias pc="heroku run rails console --remote heroku"
alias sc="heroku run rails console --remote staging"

# ruby
alias rdm='rake db:migrate'
alias c='rails c' # Rails 3

alias ka9='killall -9'
alias k9='kill -9'

# Git Aliases
alias merge='merge --no-edit'
alias gs='git status'
alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gsh='git show'
alias gshw='git show'
alias gshow='git show'
alias gi='vim .gitignore'
alias gcm='git ci -m'
alias gcim='git ci -m'
alias gps='git push'
alias gpl='git pull'
alias gci='git ci'
alias gco='git co'
alias gcp='git cp'
alias ga='git add -A'
alias gap='git add -p'
alias guns='git unstage'
alias gunc='git uncommit'
alias gm='git merge'
alias gms='git merge --squash'
alias gam='git amend --reset-author'
alias grv='git remote -v'
alias grr='git remote rm'
alias grad='git remote add'
alias gr='git rebase'
alias gra='git rebase --abort'
alias ggrc='git rebase --continue'
alias gbi='git rebase --interactive'
alias gl='git l'
alias glg='git l'
alias glog='git l'
alias co='git co'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias gfa='git fetch --all'
alias gfap='git fetch --all --prune'
alias gfch='git fetch'
alias gd='git diff'
alias gb='git b'

alias heroku='/snap/bin/heroku'

# mimic vim functions
alias :q='exit'

alias la='ls -A'
alias l='ls -CF'
if [[ $platform == 'linux' ]]; then
  alias ll='ls -alh --color=auto'
  alias ls='ls --color=auto'
elif [[ $platform == 'darwin' ]]; then
  alias ll='ls -alGh'
  alias ls='ls -Gh'
fi

# change to target branch
# update target branch
# change to source branch
# merge target with source
# usage example: $ pullmerge master
upmerge(){
  actual_branch=$(git symbolic-ref --short HEAD)
  git checkout $1
  git pull origin $1
  git checkout $actual_branch
  git merge $1 --no-edit
}

# change to target branch
# update target branch
# change to source branch
# merge target with source
# push source
# usage example: $ pullmergepush master
upmergepush(){
  actual_branch=$(git symbolic-ref --short HEAD)
  git checkout $1
  git pull origin $1
  git checkout $actual_branch
  git merge $1 --no-edit
  git pull origin $actual_branch
  git push origin $actual_branch --no-verify
}

# update release with master, develop with release
# and push release and develop
upmergepushall(){
  # update release with master
  git checkout master
  git pull origin master
  git checkout release
  git pull origin release
  git merge master --no-edit

  # update develop with release and push it
  git checkout develop
  git pull origin develop
  git merge release --no-edit
  git push origin develop --no-verify

  # update release with develop
  git checkout release
  git merge develop --no-edit
  git push origin release --no-verify
}

# update release with master, develop-prodops with release
# also updates develop-product with release
# also pushes release, develop-prodops and develop-product
upmergepushallmon(){
  # update release with master
  git checkout master
  git pull origin master
  git checkout release
  git pull origin release
  git merge master --no-edit

  # update develop-product with release and push it
  git checkout develop-product
  git pull origin develop-product
  git merge release --no-edit
  git push origin develop-product --no-verify

  # update release with develop-product
  git checkout release
  git merge develop-product --no-edit

  # push release
  git push origin release --no-verify
}
