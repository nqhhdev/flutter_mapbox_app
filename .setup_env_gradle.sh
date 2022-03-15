echo "========================Setup Env Gradle ======================="
wget https://services.gradle.org/distributions/gradle-6.7.1-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-*.zip
export GRADLE_HOME="/opt/gradle/gradle-6.7.1/bin"
export PATH=${PATH}:$GRADLE_HOME
gradle -v
cd android && gradle wrapper --gradle-version 6.7.1 && cd..
echo "========================Setup Env Gradle Finish======================="
