import Dependencies._

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.example",
      scalaVersion := "2.12.3",
      version      := "0.1.0-SNAPSHOT"
    )),
    name := "ParProg",
    libraryDependencies += scalaTest % Test,
    resolvers += "Sonatype OSS Snapshots" at
      "https://oss.sonatype.org/content/repositories/snapshots",

    libraryDependencies += "com.storm-enroute" %% "scalameter" % "0.8.2"
  )
