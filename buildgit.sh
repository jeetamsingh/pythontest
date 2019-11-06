echo "1.f_merging"
echo "2.master"
echo "3.f_superuserfunctionality"
echo "4.f_ibmreppify_4.1"
read branch


echo "Going to Delete data from buildhere"
sudo rm -r /mntfirm/buildhere/*

echo "Going to Delete data from temp folder"
sudo rm -r /mntfirm/jboss-as-7.1.1.Final/standalone/tmp/work/*
#cd /mntfirm/db
#sudo rm -r *
#echo "Checkout IBMSharedLibs"
#sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMSharedLibs -b $branch /mntfirm/db/IBMSharedLibs 
#sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMWordnetDictionary /mntfirm/db/IBMWordnetDictionary



cd /mntfirm/buildhere/
rm -r *
echo "Checkout IBMReppifyDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMReppifyDatabaseJPAModelV3.2 -b $branch /mntfirm/buildhere/IBMReppifyDatabaseJPAModel
echo "Code downloaded from code commit"
cd /mntfirm/buildhere/IBMReppifyDatabaseJPAModel/IBMReppifyDatabaseJPAModel
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/OrientDbLibs/*.jar ./lib/.
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build IBMReppifyDatabaseJPAModel Successful!!!"
else
        echo "Build IBMReppifyDatabaseJPAModel failed. Bailing out..."
        exit -1
fi

echo "Checkout IBMScrapper"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMScrapperv2V3.2 -b $branch /mntfirm/buildhere/IBMScrapperv2
echo "Code downloaded from code commit"
cd /mntfirm/buildhere/IBMScrapperv2/IBMScrapperv2
cp -v /mntfirm/buildhere/IBMReppifyDatabaseJPAModel/IBMReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/OrientDbLibs/*.jar ./lib/.
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build IBMScrapperv2 Successful!!!"
else
        echo "Build IBMScrapperv2 failed. Bailing out..."
        exit -1
fi



echo "Checkout IBMUploadProcessManager"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMUploadProcessManagerV3.2 -b $branch /mntfirm/buildhere/IBMUploadProcessManager
cd /mntfirm/buildhere/IBMUploadProcessManager/IBMUploadProcessManager
cp -v /mntfirm/buildhere/IBMReppifyDatabaseJPAModel/IBMReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp -v /mntfirm/buildhere/IBMScrapperv2/IBMScrapperv2/build/jar/Scrapper.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/CommomLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SpringLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/OrientDbLibs/*.jar ./lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SolrLibs/*.jar ./lib/.
echo "Code downloaded from code commit"
ant clean
ant jar
if [ $? = 0 ] ; then
        echo "Build IBMUploadProcessManager Successful!!!"
else
        echo "Build IBMUploadProcessManager failed. Bailing out..."
        exit -1
fi



echo "Checkout IBMreppifyb2c"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMReppifyb2cV3.2 -b $branch /mntfirm/buildhere/IBMReppifyb2c
cd /mntfirm/buildhere/IBMReppifyb2c/IBMReppifyb2c
cp -v /mntfirm/buildhere/IBMReppifyDatabaseJPAModel/IBMReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/IBMScrapperv2/IBMScrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/IBMUploadProcessManager/IBMUploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/CommomLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SpringLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/OrientDbLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SolrLibs/*.jar ./WebContent/WEB-INF/lib/.

cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppifyb2c.war/profilePic/*.* ./WebContent/profilePic/.
cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppifyb2c.war/resumes/*.* ./WebContent/resumes/.
chmod -R 755 ./WebContent/profilePic/
chmod -R 755 ./WebContent/resumes/

echo "Code downloaded from code commit"
ant clean
ant buildJar
ant buildwar

if [ $? = 0 ] ; then
        echo "Build IBMreppifyb2c Successful!!!"
else
        echo "Build IBMreppifyb2c failed. Bailing out..."
        exit -1
fi

echo "Checkout IBMreppifyb2b"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/IBMReppifyb2bV3.2 -b $branch /mntfirm/buildhere/IBMReppifyb2b
cd /mntfirm/buildhere/IBMReppifyb2b/IBMReppifyb2b
cp -v /mntfirm/buildhere/IBMReppifyDatabaseJPAModel/IBMReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/IBMScrapperv2/IBMScrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/IBMUploadProcessManager/IBMUploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/IBMReppifyb2c/IBMReppifyb2c/build/jar/Reppifyb2c.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/CommomLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SpringLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/OrientDbLibs/*.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/db/IBMSharedLibs/IBMSharedLibs/SolrLibs/*.jar ./WebContent/WEB-INF/lib/.

cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppify.war/resume/*.* ./WebContent/resume/.
cp -v /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppify.war/banner/*.* ./WebContent/banner/.
chmod -R 755 ./WebContent/resume/
chmod -R 755 ./WebContent/banner/

echo "Code downloaded from code commit"
ant clean
ant buildJar
ant buildwar

if [ $? = 0 ] ; then
        echo "Build IBMreppifyb2b Successful!!!"
else
        echo "Build IBMreppifyb2b failed. Bailing out..."
        exit -1
fi
echo "Start deployment for  IBMreppify, IBMreppifyb2c wars"
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/
echo "deleting directories.."
rm -r ibmreppify*

echo "now creating fresh directories.."
mkdir ibmreppify.war
mkdir ibmreppifyb2c.war
touch ibmreppify.war.dodeploy
touch ibmreppifyb2c.war.dodeploy
echo "Copying new wars.."
cp /mntfirm/buildhere/IBMReppifyb2b/IBMReppifyb2b/ibmreppify.war ibmreppify.war/.
cp /mntfirm/buildhere/IBMReppifyb2c/IBMReppifyb2c/ibmreppifyb2c.war ibmreppifyb2c.war/.
cd ibmreppify.war
jar -xvf ibmreppify.war
cp -r /home/ashutoshj/linkedInConnect /.
cd ..
cd ibmreppifyb2c.war
jar -xvf ibmreppifyb2c.war

if [ $? = 0 ] ; then
        echo "wars deployed successfully!!!"
else
        echo "failed to deploy. Bailing out..."
        exit -1
fi
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppifyb2c.war/assets/js/scripts/
yui-compressor -o 'js$:.js' *.js
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppifyb2c.war/assets/css/style/
yui-compressor -o 'css$:.css' *.css
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppify.war/assets/js/
yui-compressor -o 'js$:.js' *.js
cd /mntfirm/jboss-as-7.1.1.Final/standalone/deployments/ibmreppify.war/assets/css/
yui-compressor -o 'css$:.css' *.css



