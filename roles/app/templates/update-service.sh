#!/bin/sh
# Script to download deployment unit from a Maven artifact repository.

releaseRepo={{maven_releases_repository}}
snapshotRepo={{maven_snapshot_repository}}
groupId={{group_id}}
artifactId={{app_name}}
V={{version}}


if [[ $V == *SNAPSHOT* ]]; then
   echo Note: If the artifact version contains "SNAPSHOT", the latest snapshot version is downloaded, ignoring the version before SNAPSHOT.
   path="$snapshotRepo/$groupId/$artifactId"
   version=`curl -s "$path/maven-metadata.xml" | grep "<version>"  | grep "$V" | sed "s/.*<version>\([^<]*\)<\/version>.*/\1/" | tail -n 1`
   #echo "version=$version, path=$path"
   build=`curl -s "$path/$version/maven-metadata.xml" | grep '<value>' | head -1 | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/"`
   JARFILE="$artifactId-$build.jar"
   url="$path/$version/$JARFILE"
else #A specific Release version
   path="$releaseRepo/$groupId/$artifactId"
   url=$path/$V/$artifactId-$V.jar
   JARFILE=$artifactId-$V.jar
fi

# Download artifact
echo Downloading $url
wget -O $JARFILE -q -N $url


# Create symlink or replace existing sym link
if [ -h $artifactId.jar ]; then
   unlink $artifactId.jar
fi
ln -s $JARFILE $artifactId.jar

# Delete old jar files
jar=$artifactId*.jar
nrOfJarFilesToDelete=`ls $jar -A1t | tail -n +6 | wc -l`
if [[ $nrOfJarFilesToDelete > 0 ]]; then
    echo Deleting $nrOfJarFilesToDelete old jar files. Keep the 4 newest + the symlink.
    ls $jar -A1t | tail -n +6 | xargs rm
fi
