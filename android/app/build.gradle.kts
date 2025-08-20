plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter plugin must come last
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flashlight_app"
    compileSdk = 34

    // Force NDK version to match plugins
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.flashlight_app"
        minSdk = 23
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
