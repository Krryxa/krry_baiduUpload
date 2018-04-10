package com.krry.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.krry.dao.BaiduDao;

/**
 * 文件批量上传，云盘上传工具类
 * UploadUtil
 * @author krry
 * @version 1.0.0
 *
 */
public class UploadUtil {
	
	/**
	 * 批量上传工具类
	 * com.krry.uitl 
	 * 方法名：uploadFiles
	 * @author krry 
	 * @param request
	 * @param response
	 * @return HashMap<String,Object>
	 * @exception 
	 * @since  1.0.0
	 */
	public static HashMap<String, Object> uploadFiles(HttpServletRequest request,HttpServletResponse response){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String fileName;
		
		try {
			//设置编码集
			request.setCharacterEncoding("utf-8");
			response.setContentType("html/text;charset=utf-8");
			
			//获取文件上传的目录
			String realPath = request.getRealPath("/");
			//定义上传目录
			String dirPath = realPath+"/upload";
			
			File dirFile = new File(dirPath);
			//如果此文件夹不存在
			if(!dirFile.exists()){
				dirFile.mkdirs();//创建此文件夹
			}
			
			//上传操作
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			List items = upload.parseRequest(request);
			if(null != items){
				Iterator itr = items.iterator();
				while(itr.hasNext()){
					FileItem item = (FileItem) itr.next();
					if(item.isFormField()){
						continue;
					}else{
						//获取文件名
						String name = item.getName();
						//从后面往前找.
						int i = name.lastIndexOf(".");
						//截取文件格式名
						String ext = name.substring(i, name.length());
						
						//文件重命名
						fileName = new Date().getTime() + ext;
						File saveFile = new File(dirPath,fileName);
						//上传文件
						item.write(saveFile);
						
						//格式化时间类型
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String nowTime = sdf.format(new Date());
						
						map.put("name", item.getName());
						map.put("newName", fileName);
						map.put("url", "upload/"+fileName);
						map.put("size", format(item.getSize()));
						map.put("time", nowTime);
						
						//存入数据库
						BaiduDao.addfiles((String)map.get("name"), (String)map.get("url"), (String)map.get("size"), nowTime);
						
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
		
	}
	/**
	 * 将文件的字节数转换成文件的大小
	 * com.krry.uitl 
	 * 方法名：format
	 * @author krry 
	 * @param size
	 * @return String
	 * @exception 
	 * @since  1.0.0
	 */
	public static String format(long size){
		float fsize = size;
		String fileSizeString;
		if (fsize < 1024) {
			fileSizeString = String.format("%.2f", fsize) + "B"; //2f表示保留两位小数
		} else if (fsize < 1048576) {
			fileSizeString = String.format("%.2f", fsize/1024) + "KB";
		} else if (fsize < 1073741824) {
			fileSizeString = String.format("%.2f", fsize/1024/1024) + "MB";
		} else if (fsize < 1024 * 1024 * 1024) {
			fileSizeString = String.format("%.2f", fsize/1024/1024/1024) + "GB";
		} else {
			fileSizeString = "0B";
		}
		return fileSizeString;
	}
}






