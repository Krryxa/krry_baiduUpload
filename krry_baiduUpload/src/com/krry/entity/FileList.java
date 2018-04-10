package com.krry.entity;

public class FileList {

	private long index;
	private String name;
	private String src;
	private String size;
	private String date;
	public long getIndex() {
		return index;
	}
	public void setIndex(long index) {
		this.index = index;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "FileList [index=" + index + ", name=" + name + ", src=" + src
				+ ", size=" + size + ", date=" + date + "]";
	}
	
}
