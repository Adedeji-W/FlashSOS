plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle plugin must come last
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flashlight_app"
    compileSdk = 34

    // Force NDK version
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
        minSdk = 23       // ✅ FIXED (was minSdkVersion flutter.minSdkVersion)
        targetSdk = 34
        versionCode = 1   // ✅ set manually (GitHub Actions will still package APK)
        versionName = "1.0.0"
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
