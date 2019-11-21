alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias deploy='git checkout master && git pull origin master && git push heroku master --no-verify'
alias sdeploy='git checkout release && git pull origin release && git push staging release:master --no-verify'

alias upall='git checkout master && git pull origin master; git checkout develop && git pull origin develop; git checkout release && git pull origin release; git checkout develop-prodops && git pull origin develop-prodops; git checkout develop-product && git pull origin develop-product; git checkout develop-bugs && git pull origin develop-bugs; git checkout develop-imp && git pull origin develop-imp'

alias pc="heroku run rails console --remote heroku"
alias sc="heroku run rails console --remote staging"

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

  # update develop-prodops with release and push it
  git checkout develop-prodops
  git pull origin develop-prodops
  git merge release --no-edit
  git push origin develop-prodops --no-verify

  # update release with develop-prodops
  git checkout release
  git merge develop-prodops --no-edit

  # update develop-product with release and push it
  git checkout develop-product
  git pull origin develop-product
  git merge release --no-edit
  git push origin develop-product --no-verify

  # update release with develop-product
  git checkout release
  git merge develop-product --no-edit

  # update develop-bugs with release and push it
  git checkout develop-bugs
  git pull origin develop-bugs
  git merge release --no-edit
  git push origin develop-bugs --no-verify

  # update release with develop-bugs
  git checkout release
  git merge develop-bugs --no-edit

  # update develop-imp with release and push it
  git checkout develop-imp
  git pull origin develop-imp
  git merge release --no-edit
  git push origin develop-imp --no-verify

  # update release with develop-imp
  git checkout release
  git merge develop-imp --no-edit

  # push release
  git push origin release --no-verify
}
