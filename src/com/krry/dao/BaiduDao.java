package com.krry.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.krry.entity.FileList;
import com.tanzhou.jdbc.util.MJdbcTemplate;
import com.tanzhou.jdbc.util.MRowMapper;

public class BaiduDao {
	static MJdbcTemplate jdbcTemplate = new MJdbcTemplate();
	/**
	 * 文件存入数据库
	 * com.krry.dao 
	 * 方法名：addfiles
	 * @author krry 
	 * @return int
	 * @exception 
	 * @since  1.0.0
	 */
	public static void addfiles(String name,String url,String size,String time){
		String sql = "INSERT INTO BAIDU_YUN VALUES(SEQ_BAIDU.Nextval,?,?,?,?)";
		
		Object[] obj = new Object[]{name,url,size,time};
		jdbcTemplate.executeUpdate(sql, obj);
	}
	
	/**
	 * 获取数据库中的文件数据
	 * com.krry.dao 
	 * 方法名：getFiles
	 * @author krry 
	 * @return List<FileList>
	 * @exception 
	 * @since  1.0.0
	 */
	public static List<FileList> getFiles(){
		List<FileList> list = jdbcTemplate.queryForList(new MRowMapper<FileList>() {

			@Override
			public FileList mappingRow(ResultSet rs, int row)
					throws SQLException {
				//读取数据库的数据。存进实体类
				FileList fl = new FileList();
				fl.setIndex(rs.getLong("BAIDU_INDEX"));
				fl.setName(rs.getString("BAIDU_NAME"));
				fl.setSrc(rs.getString("BAIDU_SRC"));
				fl.setSize(rs.getString("BAIDU_SIZE"));
				fl.setDate(rs.getString("BAIDU_DATE"));
				return fl;
			}
			
		}, "SELECT * FROM BAIDU_YUN", null);
		return list;
	}
	
	/**
	 * 根据文件路径(包括文件名和后缀名)删除一条数据
	 * com.krry.dao 
	 * 方法名：deleteFile
	 * @author krry 
	 * @param fileName void
	 * @exception 
	 * @since  1.0.0
	 */
	public static int deleteFile(String fileSrc){
		String sql = "DELETE FROM BAIDU_YUN WHERE BAIDU_SRC = ?";
		Object[] obj = new Object[]{fileSrc};
		int mun = jdbcTemplate.executeUpdate(sql, obj);
		return mun;
	}
	
}

