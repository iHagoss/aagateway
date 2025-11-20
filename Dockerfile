android {
    compileSdk 35

    defaultConfig {
        applicationId "uk.co.borconi.emil.aagateway"
        minSdk 22
        targetSdk 35
        versionCode 2
        versionName "2.0"
    }

    // Compile for Java 11 bytecode
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_11
        targetCompatibility JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
        freeCompilerArgs += ["-Xjdk-release=11"]
    }

    // Run Gradle/AGP with JDK 17 toolchain
    java {
        toolchain {
            languageVersion = JavaLanguageVersion.of(17)
        }
    }
}
