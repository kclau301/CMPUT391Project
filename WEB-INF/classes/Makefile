JC = javac
CLASSPATH = -classpath ../lib/ojdbc6.jar:../lib/commons-fileupload-1.0.jar:../lib/servlet-api.jar
SOURCEPATH = -sourcepath .:db
#CLASSES = \
#		db/Database.java \
#		GetOnePic.java \
#		ModifyAccountCheck.java \
#		UploadImage.java

default: Database.class GetOnePic.class ModifyAccountCheck.class UploadImage.class

Database.class: db/Database.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) db/Database.java

GetOnePic.class: GetOnePic.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) GetOnePic.java

ModifyAccountCheck.class: ModifyAccountCheck.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) ModifyAccountCheck.java

UploadImage.class: UploadImage.java
	$(JC) $(CLASSPATH) $(SOURCEPATH) UploadImage.java	

clean:
	$(RM) *.class
	$(RM) db/*.class
