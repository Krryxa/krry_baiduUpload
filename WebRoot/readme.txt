
百度大数据云盘系统

java

util:	文件批量上传，云盘上传工具类:	UploadUtil.java
dao:	操作数据库:				BaiduDao.java
entity:	数据库数据实体类:			javabean:FileList.java
servlet:删除文件所需的servlet:	DeleteServlet.java

1.数据库：BAIDU_YUN
2.上传文件自动保存到数据库
3.删除文件，通过ajax异步请求DeleteServlet，数据库中的该文件数据删除，而服务器的文件不会删除