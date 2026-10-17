#!/usr/bin/env sh

APP_HOME=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if [ -z "$JAVA_HOME" ] && command -v java >/dev/null 2>&1; then
  JAVA_HOME=$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")
fi

if [ -z "$JAVA_HOME" ]; then
  echo "JAVA_HOME is not set and no java command could be found in PATH." >&2
  exit 1
fi

JAVACMD="$JAVA_HOME/bin/java"
if [ ! -x "$JAVACMD" ]; then
  echo "Unable to find java executable in JAVA_HOME: $JAVA_HOME" >&2
  exit 1
fi

CLASSPATH="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
if [ ! -f "$CLASSPATH" ]; then
  echo "Missing Gradle wrapper JAR: $CLASSPATH" >&2
  echo "Generate it by running: gradle wrapper" >&2
  exit 1
fi

exec "$JAVACMD" -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
