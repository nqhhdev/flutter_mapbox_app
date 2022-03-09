echo "========================Setup Env Config $BUILD_FLAVOR_KEY======================="
flavor="Development"

#Check prefix and set flavor config
if [ "$BUILD_FLAVOR_KEY" = "staging" ]; then
  flavor="Staging"
elif [ "$BUILD_FLAVOR_KEY" = "production" ]; then
  flavor="Production"
fi
export BRANCH_NAME=$CI_BUILD_REF_NAME
export COMMIT_TITLE=$CI_COMMIT_TITLE
export USER_PERFORM=$GITLAB_USER_NAME

echo Flavor "$flavor"
echo Branch name "$BRANCH_NAME"
echo Commit title "$COMMIT_TITLE"
echo User name "$USER_PERFORM"
{
echo BRANCH_NAME="$BRANCH_NAME"
echo COMMIT_TITLE="$COMMIT_TITLE"
echo USER_PERFORM="$USER_PERFORM"
} >>fastlane/.env."$BUILD_FLAVOR_KEY"

echo "========================Env $BUILD_FLAVOR_KEY File======================="
cat fastlane/.env."$BUILD_FLAVOR_KEY"
echo "========================Setup Env Finish======================="
