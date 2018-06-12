lazy val root = (project in file(".")).
  settings(
    name := "TwitterOpinionMining-spark2.1",
    version := "1.0",
    scalaVersion := "2.11.8",
    mainClass in Compile := Some("TwitterOpinionMining")        
  )

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % "2.1.1" % "provided",
  "org.apache.spark" %% "spark-sql" % "2.1.1" % "provided",
  "org.apache.spark" %% "spark-hive" % "2.1.1" % "provided",
  "org.apache.spark" %% "spark-mllib" % "2.1.1" % "provided",
  "org.apache.spark" %% "spark-streaming" % "2.1.1" % "provided",
  "org.apache.spark" % "spark-streaming-kafka_2.11" % "2.1.1",
  "org.apache.kafka" % "kafka_2.11" % "0.8.2",
  "au.com.bytecode" % "opencsv" % "2.4", 
  "com.databricks" % "spark-csv_2.11" % "1.5.0",
  "com.typesafe" % "config" % "1.3.0"
)

// META-INF discarding
mergeStrategy in assembly <<= (mergeStrategy in assembly) { (old) =>
   {
    case PathList("META-INF", xs @ _*) => MergeStrategy.discard
    case x => MergeStrategy.first
   }
}

assemblyJarName in assembly := "twitter_opinion_mining-spark2.1.jar"
