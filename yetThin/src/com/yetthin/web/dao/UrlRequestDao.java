package com.yetthin.web.dao;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository("UrlRequestDao")
public class UrlRequestDao {
	private final static String  CHARACTER_SET="utf-8";
    public   List<String> readContentFromGet(String url) throws IOException {   

        // 拼凑get请求的URL字串，使用URLEncoder.encode对特殊和不可见字符进行编码   
     
    	List<String> list=new LinkedList<>();
        URL getUrl = new URL(url);   
        
        // 根据拼凑的URL，打开连接，URL.openConnection()函数会根据 URL的类型，返回不同的URLConnection子类的对象，在这里我们的URL是一个http，因此它实际上返回的是HttpURLConnection   

        HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();   
        connection.setRequestProperty("Charset", "UTF-8"); 
        connection.setRequestProperty("Accept-Charset", "UTF-8");
        // 建立与服务器的连接，并未发送数据   

        connection.connect();   
        // 发送数据到服务器并使用Reader读取返回的数据   
        //gb2312
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"gbk"));   
//        System.out.println(" ============================= ");   
//
//        System.out.println(" Contents of get request ");   
//
//        System.out.println(" ============================= ");   

        String lines;   
        while ((lines = reader.readLine()) != null) {   
      
        	String [] subStr = lines.split("=");
        	String value=subStr[1];
        	value=value.replace("\"", "");
        	value=value.replace(";", "");
 	   		String sybmol =lines.split("=")[0].substring(lines.split("=")[0].length()-8);
 	   		 	list.add(value+"&"+sybmol);
     	   }   

        reader.close();   

        // 断开连接   

        connection.disconnect();   
  //      System.out.println(Arrays.asList(list));
        return list;
 }   



 private String readContentFromPost(String url) throws IOException {   

        // Post请求的url，与get不同的是不需要带参数   

        URL postUrl = new URL(url);   

        // 打开连接   

        HttpURLConnection connection = (HttpURLConnection) postUrl.openConnection();   

        //打开读写属性，默认均为false   
        connection.setDoOutput(true);                   
        connection.setDoInput(true);  
        // 设置请求方式，默认为GET   

        connection.setRequestMethod(" POST ");   

        // Post 请求不能使用缓存   

        connection.setUseCaches(false);   

        // URLConnection.setFollowRedirects是static 函数，作用于所有的URLConnection对象。   

        // connection.setFollowRedirects(true);   

        //URLConnection.setInstanceFollowRedirects 是成员函数，仅作用于当前函数   

        connection.setInstanceFollowRedirects(true);   

        // 配置连接的Content-type，配置为application/x- www-form-urlencoded的意思是正文是urlencoded编码过的form参数，下面我们可以看到我们对正文内容使用URLEncoder.encode进行编码   

        connection.setRequestProperty(" Content-Type ",   

                        " application/x-www-form-urlencoded ");   

        // 连接，从postUrl.openConnection()至此的配置必须要在 connect之前完成，   

        // 要注意的是connection.getOutputStream()会隐含的进行调用 connect()，所以这里可以省略   

        //connection.connect();   

        DataOutputStream out = new DataOutputStream(connection   

                        .getOutputStream());   

        //正文内容其实跟get的URL中'?'后的参数字符串一致   

        String content = " firstname= "+URLEncoder.encode(" 一个大肥人 ", " utf-8 ");   

        // DataOutputStream.writeBytes将字符串中的16位的 unicode字符以8位的字符形式写道流里面   

        out.writeBytes(content);   

        out.flush();   

        out.close(); // flush and close   

        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));   

        String line;   

        System.out.println(" ============================= ");   

        System.out.println(" Contents of post request ");   

        System.out.println(" ============================= ");   

        while ((line = reader.readLine()) != null) {   

                System.out.println(line);   

        }   

        System.out.println(" ============================= ");   

        System.out.println(" Contents of post request ends ");   

        System.out.println(" ============================= ");   

        reader.close();   

        //connection.disconnect();   
        return "";
 }   
}
