FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /opt/android

#Dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    openjdk-17-jdk \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

#Android SDK
ENV ANDROID_HOME=/opt/android
ENV PATH=$ANDROIDHOME/cmdline-tools/latest/bin:$ANDROIDHOME/platform-tools:$PATH

RUN curl -o commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip \
    && mkdir -p $ANDROID_HOME/cmdline-tools \
    && unzip commandlinetools.zip -d $ANDROID_HOME/cmdline-tools \
    && rm commandlinetools.zip \
    && mv $ANDROIDHOME/cmdline-tools/cmdline-tools $ANDROIDHOME/cmdline-tools/latest

RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" \
    && sdkmanager "platforms;android-35" \
    && sdkmanager "build-tools;35.0.0"

WORKDIR /repo
COPY . /repo
RUN dos2unix gradlew && chmod +x gradlew
