cd /mnt/db
rm -r SharedLibs
mkdir SharedLibs
echo "Checkout SharedLibs"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/TalentsharedLibs  /mntfirm/db/SharedLibs



rm -r WordnetDictionary
mkdir WordnetDictionary
echo "Checkout WordnetDictionary"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Talent_SharedLibs /mntfirm/db/WordnetDictionary


cd /mntfirm/buildhere
rm -r *
cd /mntfirm/buildhere

echo "Checkout ReppifyDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Talent_ReppifyDatabaseJPAModel /mntfirm/buildhere/ReppifyDatabaseJPAModel
echo "Code downloaded from git"
cd /mntfirm/buildhere/ReppifyDatabaseJPAModel
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build ReppifyDatabaseJPAModel Successful!!!"
else
        echo "Build ReppifyDatabaseJPAModel failed. Bailing out..."
        exit -1
fi

echo "Checkout Scrapper"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Talent_Scrapper
echo "Code downloaded from git"
cd /mntfirm/buildhere/Scrapper
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp /mntfirm/db/SharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/SharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/SharedLibs/OrientDbLibs/*.jar ./lib/.
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build Scrapper Successful!!!"
else
        echo "Build Scrapper failed. Bailing out..."
        exit -1
fi



echo "Checkout UploadProcessManager"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Talent_UploadProcessManager /mntfirm/buildhere/UploadProcessManager
cd /mntfirm/buildhere/UploadProcessManager
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp -v /mntfirm/buildhere/Scrapper/build/jar/Scrapper.jar ./lib/.
cp /mntfirm/db/SharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/SharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/SharedLibs/OrientDbLibs/*.jar ./lib/.
cp /mntfirm/db/SharedLibs/SolrLibs/*.jar ./lib/.
echo "Code downloaded from git"
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build UploadProcessManager Successful!!!"
else
        echo "Build UploadProcessManager failed. Bailing out..."
        exit -1
fi

echo "Checkout reppifybatch"
https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Talent_reppifybatch /mntfirm/buildhere/reppifybatch
cd /mntfirm/buildhere/reppifybatch
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/Scrapper/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/UploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp /mnt/db/SharedLibs/CommomLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mnt/db/SharedLibs/SpringLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mnt/db/SharedLibs/OrientDbLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mnt/db/SharedLibs/SolrLibs/*.jar ./WebContent/WEB-INF/lib/.

#cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/reppify.war/resume/*.* ./WebContent/resume/.
#cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/reppify.war/banner/*.* ./WebContent/banner/.
#chmod -R 755 ./WebContent/resume/
#chmod -R 755 ./WebContent/banner/

echo "Code downloaded from git"

ant clean
ant buildwar
if [ $? = 0 ] ; then
        echo "Build reppifybatch Successful!!!"
else
        echo "Build reppifybatch failed. Bailing out..."
        exit -1
fi
echo "Start deployment for reppifybatch wars"
cd /mntfirm/apache-tomcat-8.0.32/webapps/
echo "deleting directories.."
rm -r *
echo "now creating fresh directories.."
mkdir reppifybatch
echo "Copying new wars.."
cd reppifybatch
jar -xvf /mntfirm/buildhere/reppifybatch/reppifybatch.war
if [ $? = 0 ] ; then
        echo "wars deployed successfully!!!"
else
        echo "failed to deploy. Bailing out..."
        exit -1
fi
echo "updating server id"
bash -c 'echo -e "\nserver.id='$1'" >> /mntfirm/apache-tomcat-8.0.32/webapps/reppifybatch/WEB-INF/classes/configuration.properties'
echo "server id updated successfully"

sudo rm -r /mntfirm/apache-tomcat-8.0.32/logs/*
sudo rm -r /tmp/*

#sudo cp -r /mnt/default-conf/configuration.properties   /mntfirm/apache-tomcat-8.0.32/webapps/reppifybatch/WEB-INF/classes/

#sudo cp -r /mntfirm/backup/* /mntfirm/apache-tomcat-8.0.32/webapps/reppifybatch/WEB-INF/classes/

echo "call startup.sh"
#sh /mnt/apache-tomcat-8.0.32/bin/startup.sh
echo "server up succesfully"
