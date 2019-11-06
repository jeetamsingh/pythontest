#sudo rm  -r /mntfirm/war_backup/*
backupfile = `sudo mkdir /mntfirm/backup"$(date +"%d-%m-%Y")"`
sudo cp -a /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/* $backupfile
echo "1.dev1"
echo "2.dev2"
echo "3.master"
echo "4.f_taleo"
echo "5.f_reporting"
echo "6.develop"
echo "7.f_taleo_reporting_enhancement"
echo "f_taleo_reporting"
read branch


echo "Going to Delete data from buildhere"
sudo rm -r /mntfirm/buildhere/*

echo "Going to Delete data from temp folder"
sudo rm -r /mntfirm/jboss-as-7.1.1.Final/standalone/tmp/work/*
cd /mntfirm/db
#sudo rm -r *
echo "Checkout DELOITTESharedLibs"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTESharedLibs -b f_taleo /mntfirm/db/DELOITTESharedLibs 
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTEWordnetDictionary /mntfirm/db/DELOITTEWordnetDictionary



cd /mntfirm/buildhere/
rm -r *
echo "Checkout DELOITTEReppifyDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTEReppifyDatabaseJPAModel -b $branch /mntfirm/buildhere/DELOITTEReppifyDatabaseJPAModel
echo "Code downloaded from code commit"
cd /mntfirm/buildhere/DELOITTEReppifyDatabaseJPAModel/DELOITTEReppifyDatabaseJPAModel
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/OrientDbLibs/*.jar ./lib/.
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build DELOITTEReppifyDatabaseJPAModel Successful!!!"
else
        echo "Build DELOITTEReppifyDatabaseJPAModel failed. Bailing out..."
        exit -1
fi

echo "Checkout DELOITTEScrapper"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTEScrapperv2 -b $branch /mntfirm/buildhere/DELOITTEScrapperv2
echo "Code downloaded from code commit"
cd /mntfirm/buildhere/DELOITTEScrapperv2/DELOITTEScrapperv2
cp -v /mntfirm/buildhere/DELOITTEReppifyDatabaseJPAModel/DELOITTEReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/OrientDbLibs/*.jar ./lib/.
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build DELOITTEScrapperv2 Successful!!!"
else
        echo "Build DELOITTEScrapperv2 failed. Bailing out..."
        exit -1
fi



echo "Checkout DELOITTEUploadProcessManager"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTEUploadProcessManager -b $branch /mntfirm/buildhere/DELOITTEUploadProcessManager
cd /mntfirm/buildhere/DELOITTEUploadProcessManager/DELOITTEUploadProcessManager
cp -v /mntfirm/buildhere/DELOITTEReppifyDatabaseJPAModel/DELOITTEReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp -v /mntfirm/buildhere/DELOITTEScrapperv2/DELOITTEScrapperv2/build/jar/Scrapper.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/OrientDbLibs/*.jar ./lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SolrLibs/*.jar ./lib/.
echo "Code downloaded from code commit"
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build DELOITTEUploadProcessManager Successful!!!"
else
        echo "Build DELOITTEUploadProcessManager failed. Bailing out..."
        exit -1
fi



echo "Checkout DELOITTEreppifyb2c"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTEReppifyb2c -b $branch /mntfirm/buildhere/DELOITTEReppifyb2c
cd /mntfirm/buildhere/DELOITTEReppifyb2c/DELOITTEReppifyb2c
cp -v /mntfirm/buildhere/DELOITTEReppifyDatabaseJPAModel/DELOITTEReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/DELOITTEScrapperv2/DELOITTEScrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/DELOITTEUploadProcessManager/DELOITTEUploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/CommomLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SpringLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/OrientDbLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SolrLibs/*.jar ./WebContent/WEB-INF/lib/.

cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppifyb2c.war/profilePic/*.* ./WebContent/profilePic/.
cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppifyb2c.war/resumes/*.* ./WebContent/resumes/.
chmod -R 755 ./WebContent/profilePic/
chmod -R 755 ./WebContent/resumes/

echo "Code downloaded from code commit"
ant clean
ant buildJar
ant buildwar

if [ $? = 0 ] ; then
        echo "Build DELOITTEreppifyb2c Successful!!!"
else
        echo "Build DELOITTEreppifyb2c failed. Bailing out..."
        exit -1
fi

echo "Checkout DELOITTEreppifyb2b"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DELOITTEReppifyb2b -b $branch /mntfirm/buildhere/DELOITTEReppifyb2b
cd /mntfirm/buildhere/DELOITTEReppifyb2b/DELOITTEReppifyb2b
cp -v /mntfirm/buildhere/DELOITTEReppifyDatabaseJPAModel/DELOITTEReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/DELOITTEScrapperv2/DELOITTEScrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/DELOITTEUploadProcessManager/DELOITTEUploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/DELOITTEReppifyb2c/DELOITTEReppifyb2c/build/jar/reppifyb2c.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/CommomLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SpringLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/OrientDbLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/DELOITTESharedLibs/DELOITTESharedLibs/SolrLibs/*.jar ./WebContent/WEB-INF/lib/.

cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppify.war/resume/*.* ./WebContent/resume/.
cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppify.war/banner/*.* ./WebContent/banner/.
chmod -R 755 ./WebContent/resume/
chmod -R 755 ./WebContent/banner/

echo "Code downloaded from code commit"
ant clean
ant buildJar
ant buildwar

if [ $? = 0 ] ; then
        echo "Build DELOITTEreppifyb2b Successful!!!"
else
        echo "Build DELOITTEreppifyb2b failed. Bailing out..."
        exit -1
fi
echo "Start deployment for  DELOITTEreppify, DELOITTEreppifyb2c wars"
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/
echo "deleting directories.."
rm -r deloittereppify*

echo "now creating fresh directories.."
mkdir deloittereppify.war
mkdir deloittereppifyb2c.war
touch deloittereppify.war.dodeploy
touch deloittereppifyb2c.war.dodeploy
echo "Copying new wars.."
cp /mntfirm/buildhere/DELOITTEReppifyb2b/DELOITTEReppifyb2b/deloittereppify.war deloittereppify.war/.
cp /mntfirm/buildhere/DELOITTEReppifyb2c/DELOITTEReppifyb2c/deloittereppifyb2c.war deloittereppifyb2c.war/.
cd deloittereppify.war
jar -xvf deloittereppify.war
cp -r /home/ashutoshj/linkedInConnect /.
cd ..
cd deloittereppifyb2c.war
jar -xvf deloittereppifyb2c.war

if [ $? = 0 ] ; then
        echo "wars deployed successfully!!!"
else
        echo "failed to deploy. Bailing out..."
        exit -1
fi
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppifyb2c.war/assets/js/scripts/
yui-compressor -o 'js$:.js' *.js
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppifyb2c.war/assets/css/style/
yui-compressor -o 'css$:.css' *.css
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppify.war/assets/js/
yui-compressor -o 'js$:.js' *.js
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/deloittereppify.war/assets/css/
yui-compressor -o 'css$:.css' *.css


