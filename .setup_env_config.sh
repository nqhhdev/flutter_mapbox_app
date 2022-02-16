echo "========================Setup Env Config $1======================="
flavor="Development"
prefix=$1

#Check prefix and set flavor config
if [ "$prefix" = "staging" ]; then
  flavor="Staging"
elif [ "$prefix" = "production" ]; then
  flavor="Production"
fi

echo Flavor "$flavor"
echo Branch name "$CI_BUILD_REF_NAME"
echo Commit title "$CI_COMMIT_TITLE"
echo User name "$GITLAB_USER_NAME"
{
echo BRANCH_NAME="$CI_BUILD_REF_NAME"
echo COMMIT_TITLE="$CI_COMMIT_TITLE"
echo USER_PERFORM="$GITLAB_USER_NAME"
} >>fastlane/.env."$prefix"
echo "========================Setup Env Finish======================="
