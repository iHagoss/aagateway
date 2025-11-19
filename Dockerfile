FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /opt/android

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    openjdk-17-jdk \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV ANDROID_HOME=/opt/android
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

# Download Android SDK command line tools and fix layout
RUN curl -o commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
    && mkdir -p $ANDROID_HOME/cmdline-tools \
    && unzip commandlinetools.zip -d $ANDROID_HOME/cmdline-tools \
    && rm commandlinetools.zip \
    && mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest

# Accept licenses and install SDK 36 + build-tools
RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" \
    && sdkmanager "platforms;android-36" \
    && sdkmanager "build-tools;36.0.0"

# Switch to project workspace
WORKDIR /repo
COPY . /repo

# Fix Gradle wrapper permissions only (no build here)
RUN dos2unix gradlew && chmod +x gradlew