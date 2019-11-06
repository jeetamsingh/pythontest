echo "feature/GooglePlus"
echo "feature/GooglePlus/BackLog"
read branch
cd /mntfirm/buildhere
echo "Checkout sharedLibs"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_SharedLibsCRP   /mntfirm/buildhere/SharedLibs
echo "Code downloaded from git"

cd /mntfirm/buildhere
echo "Checkout ReppifyDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_ReppifyDatabaseJPAModel -b $branch /mntfirm/buildhere/ReppifyDatabaseJPAModel
echo "Code downloaded from git"
cd /mntfirm/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel
ant clean
ant jar


echo "Checkout AccentureDatabaseJPAModel"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_AccentureDatabaseJPAModel -b $branch /mntfirm/buildhere/AccentureDatabaseJPAModel
echo "Code downloaded from git"
cd /mntfirm/buildhere/AccentureDatabaseJPAModel/AccentureDatabaseJPAModel
ant clean
ant jar


echo "Checkout Scrapper"
sudo https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_Scrapperv2 -b $branch /mntfirm/buildhere/Scrapper
echo "Code downloaded from git"
cd /mntfirm/buildhere/Scrapper/Scrapperv2 
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./lib/.
ant clean
ant jar

echo "Checkout UploadProcessManager"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_UploadProcessManager -b $branch /mntfirm/buildhere/UploadProcessManager
cd /mntfirm/buildhere/UploadProcessManager/UploadProcessManager
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./lib/.
cp -v /mntfirm/buildhere/Scrapper/Scrapperv2/build/jar/Scrapper.jar ./lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./lib/.
echo "Code downloaded from git"
ant clean
ant jar

echo "Checkout Reppify AccentureBatch"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_AccentureBatch /mntfirm/buildhere/accenturebatch
cd /mntfirm/buildhere/accenturebatch/AccentureBatch
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/AccentureDatabaseJPAModel/AccentureDatabaseJPAModel/build/jar/accentureDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/Scrapper/Scrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/UploadProcessManager/UploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/SolrLibs/*.jar  ./WebContent/WEB-INF/lib/.
echo "Code downloaded from git"
ant clean
ant buildjar

echo "Checkout Reppify Accenture"
sudo git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/accentureRre_accenture /mntfirm/buildhere/accenture
cd /mntfirm/buildhere/accenture/accenture
cp -v /mntfirm/buildhere/ReppifyDatabaseJPAModel/ReppifyDatabaseJPAModel/build/jar/ReppifyDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/AccentureDatabaseJPAModel/AccentureDatabaseJPAModel/build/jar/accentureDatabaseJPAModel.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/accenturebatch/AccentureBatch/build/jar/accenturebatch.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/Scrapper/Scrapperv2/build/jar/Scrapper.jar ./WebContent/WEB-INF/lib/.
cp -v /mntfirm/buildhere/UploadProcessManager/UploadProcessManager/build/jar/UploadProcessManager.jar ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/CommomLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/SpringLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/OrientDBLibs/*.jar  ./WebContent/WEB-INF/lib/.
cp /mntfirm/buildhere/SharedLibs/SharedLibsCRP/SolrLibs/*.jar  ./WebContent/WEB-INF/lib/.
echo "Code downloaded from git"
ant clean
ant buildwar

echo "Start deployment for  accenture wars"
cd /mntfirm/jboss-as-7.1.0.Final/standalone/deployments/
echo "deleting directories.."
rm -r accenture*
echo "now creating fresh directories.."
mkdir accenture.war
touch accenture.war.dodeploy
echo "Copying new wars.."
cp /mntfirm/buildhere/accenture/accenture/accenture.war accenture.war/
cd accenture.war
jar -xvf accenture.war


