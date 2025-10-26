plugins {
    kotlin("jvm") version "1.9.24"
    application
}

repositories { mavenCentral() }

dependencies {
    testImplementation(kotlin("test"))
}

kotlin {
    jvmToolchain(17)
}

application {
    mainClass.set("NoteAppKt")
}

tasks.named<JavaExec>("run") {
    standardInput = System.`in`
    jvmArgs("-Xmx512m")
}
