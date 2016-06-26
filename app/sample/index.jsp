<%-- 
    Document   : index
    Created on : Dec 21, 2015, 4:33:25 PM
    Author     : bruno
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="weblogic.management.runtime.ServerRuntimeMBean"%>
<%@page import="java.net.UnknownHostException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="weblogic.management.*"%>


<%@page import="java.io.*"%>
<%@page import="java.net.*" %>

<%String recv;
  String[] envprops = new String[4];
  try{
	String endpoint = System.getenv("ENV-FILE");
	System.out.println(endpoint);
	URL envpage = new URL(endpoint);
  	System.out.println(envpage);
  	URLConnection urlcon = envpage.openConnection();	
  	BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));
  	
	int i = 0; 
  	while((recv = buffread.readLine()) != null) {
		envprops[i] = recv;
		i++;
		
	}
  	buffread.close();
   }catch(Exception ex){System.out.println(ex);}	
%>

<%!public static String getIpAddOfCurrSrv() {
        ServerRuntimeMBean serverRuntime = null;
        Set mbeanSet = null;
        Iterator mbeanIterator = null;
        String ipAddress = "";
        String adminServerUrl = "t3://localhost:7001";
        try {
            MBeanHome mBeanHome = null;
            mBeanHome = Helper.getAdminMBeanHome("weblogic", "welcome1", adminServerUrl);
            mbeanSet = mBeanHome.getMBeansByType("ServerRuntime");
            if (mbeanSet != null) {
                mbeanIterator = mbeanSet.iterator();
                while (mbeanIterator.hasNext()) {
                    serverRuntime = (ServerRuntimeMBean) mbeanIterator.next();
                    if (serverRuntime != null) {
                        ipAddress = serverRuntime.getURL("HTTP");
                        return ipAddress;
                    }
                }
            }
        } catch (Exception e) {
        }
        return ipAddress;
    }
%>

<%
    String hostname, serverAddress;
    hostname = "error";
    serverAddress = "error";
    try {
        InetAddress inetAddress;
        inetAddress = InetAddress.getLocalHost();
        hostname = inetAddress.getHostName();
        serverAddress = inetAddress.toString();
    } catch (UnknownHostException e) {
        e.printStackTrace();
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>WebLogic on Docker - Request Information</h1>
        <ul>
            <li>getVirtualServerName(): <%= request.getServletContext().getVirtualServerName() %></li>
            <li>InetAddress.hostname: <%=hostname%></li>
            <li>InetAddress.serverAddress: <%=serverAddress%></li>
            <li>getLocalAddr(): <%=request.getLocalAddr()%></li>
            <li>getLocalName(): <%=request.getLocalName()%></li>
            <li>getLocalPort(): <%=request.getLocalPort()%></li>
            <li>getServerName(): <%=request.getServerName()%></li>
            <li>WLS Server Name: <%=System.getProperty("weblogic.Name")%></li>
            <li>getIpAddOfCurrSrv(): <%=getIpAddOfCurrSrv()%> </li>
        </ul>
	<h1>envfile Information</h1>
	<ul><li><% for(int i=0;i<4;i++) { %> <%=envprops[i]%> <%}%></li></ul>
    </body>
</html>
