echo "feature/GooglePlus"
echo "feature/GooglePlus/BackLog"
read branch
echo "call shutdown.sh"
sh /mnt/apache-tomcat-6.0.37/bin/shutdown.sh
echo "server down succesfully"

cd /mnt/buildhere
echo "Checkout sharedLibs"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_SharedLibsCRP /mnt/buildhere/SharedLibs
echo "Code downloaded from git"

echo "Checkout ReppifyDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_ReppifyDatabaseJPAModel -b $branch /mnt/buildhere/ReppifyDatabaseJPAModel
echo "Code downloaded from git"
cd /mnt/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build ReppifyDatabaseJPAModel Successful!!!"
else
        echo "Build ReppifyDatabaseJPAModel failed. Bailing out..."
        exit -1
fi

echo "Checkout AccentureDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_AccentureDatabaseJPAModel -b $branch /mnt/buildhere/AccentureDatabaseJPAModel 
echo "Code downloaded from git"
cd /mnt/buildhere/AccentureDatabaseJPAModel/AccentureDatabaseJPAModel
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build AccentureDatabaseJPAModel Successful!!!"
else
        echo "Build AccentureDatabaseJPAModel failed. Bailing out..."
        exit -1
fi

echo "Checkout Scrapper"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_Scrapperv2 -b $branch /mnt/buildhere/Scrapper 
echo "Code downloaded from git"
cd /mnt/buildhere/Scrapper/Scrapperv2
cp -v /mnt/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./lib/.
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build Scrapper Successful!!!"
else
        echo "Build Scrapper failed. Bailing out..."
        exit -1
fi



echo "Checkout UploadProcessManager"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_UploadProcessManager -b $branch /mnt/buildhere/UploadProcessManager
cd /mnt/buildhere/UploadProcessManager/UploadProcessManager
cp -v /mnt/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp -v /mnt/buildhere/Scrapper/Scrapperv2/build/jar/Scrapper.jar ./lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./lib/.
echo "Code downloaded from git"
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build UploadProcessManager Successful!!!"
else
        echo "Build UploadProcessManager failed. Bailing out..."
        exit -1
fi



echo "Checkout Reppify Accenture"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_AccentureBatch -b $branch /mnt/buildhere/AccentureBatch
cd /mnt/buildhere/AccentureBatch/AccentureBatch
cp -v /mnt/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mnt/buildhere/AccentureDatabaseJPAModel/AccentureDatabaseJPAModel/build/jar/accentureDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mnt/buildhere/Scrapper/Scrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mnt/buildhere/UploadProcessManager/UploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mnt/buildhere/SharedLibs/SharedLibsCRP/SolrLibs/*.jar  ./WebContent/WEB-INF/lib/.
echo "Code downloaded from SVN"
ant clean
ant buildwar
if [ $? = 0 ] ; then
        echo "Build AccentureBatch Successful!!!"
else
        echo "Build AccentureBatch failed. Bailing out..."
        exit -1
fi
echo "Start deployment for accenturebatch wars"
cd /mnt/apache-tomcat-6.0.37/webapps/
echo "deleting directories.."
rm -r *
echo "now creating fresh directories.."
mkdir accenturebatch
echo "Copying new wars.."
cd accenturebatch
jar -xvf /mnt/buildhere/AccentureBatch/AccentureBatch/accenturebatch.war
if [ $? = 0 ] ; then
        echo "wars deployed successfully!!!"
else
        echo "failed to deploy. Bailing out..."
        exit -1
fi
echo "updating server id"
bash -c 'echo -e "\nserver.id='$1'" >> /mnt/apache-tomcat-6.0.37/webapps/accenturebatch/WEB-INF/classes/configuration.properties'
echo "server id updated successfully"

sudo rm -r /mnt/apache-tomcat-6.0.37/logs/*
sudo rm -r /tmp/*

#sudo cp -r /mnt/default-conf/configuration.properties   /mnt/apache-tomcat-6.0.37/webapps/accenturebatch/WEB-INF/classes/
echo "call startup.sh"
sh /mnt/apache-tomcat-6.0.37/bin/startup.sh
echo "server up succesfully"
