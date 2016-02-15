#!/usr/bin/env bash

environment=$1
theme="sage"

###
# Check that we have the correct working directory.
###
if [ ! -d "web" ]
then
  echo "Please run this script from the main htdocs directory."
  exit
fi

###
# Stop if there are uncommitted changes
###
if [[ -n $(git status -s) ]]
then
  echo "Please review and commit your changes before continuing."
  exit
fi

###
# Create "deploy" directory
# If necessary, remove existing directory
###
cd ".."
if [ -d "deploy" ]
then
  echo "Removing old deployment directory."
  rm -Rf "deploy"
fi

echo "Preparing files for deployment."
cp -a "htdocs" "deploy"
cd "deploy"


###
# Always deploy the master branch
###
git checkout master

###
# Create a temporary deploying-wpengine branch
###
exists=`git show-ref refs/heads/deploying-wpengine`
if [ -n "$exists" ]
then
  git branch -D deploying-wpengine
fi
git checkout -b deploying-wpengine

###
# Move files into the expected locations.
# Remove unwanted files.
###
mv web/app wp-content
rm -R web
rm "wp-content/themes/${theme}/.gitignore"
rm "wp-content/mu-plugins/bedrock-autoloader.php"
rm "wp-content/mu-plugins/disallow-indexing.php"
rm "wp-content/mu-plugins/register-theme-directory.php"
rm .gitignore
echo "/*\n!wp-content/\nwp-content/uploads" >> .gitignore
git ls-files | xargs git rm --cached

cd wp-content/
find . | grep .git | xargs rm -rf
cd ../

###
# Commit new structure into git, and push to remote.
###
git add .
git commit -am "WP Engine build from: $(git log -1 HEAD --pretty=format:%s)$(git rev-parse --short HEAD 2> /dev/null | sed "s/\(.*\)/@\1/")"

echo "Pushing to WP Engine..."
if [ "$environment" == "staging" ]
then
  git push staging deploying-wpengine:master --force
  git checkout develop
elif [ "$environment" == "production" ]
then
  git push production deploying-wpengine:master --force
  git checkout master
fi
git branch -D deploying-wpengine
echo "Successfully deployed."

###
# Remove deploy directory and move back to htdocs
###
echo "Cleaning up..."
cd "../htdocs"
rm -Rf "../deploy"
git fetch
echo "Done."