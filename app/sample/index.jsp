<%-- 
    Document   : index
    Created on : Dec 21, 2015, 4:33:25 PM
    Author     : bruno
--%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.net.UnknownHostException"%>
<%@page import="java.net.InetAddress"%>


<%@page import="java.io.*"%>
<%@page import="java.net.*" %>

<%
  String[] props = new String[5];
  try{
	String appConfig = System.getenv("CONFIG");
	URL endpoint = new URL(appConfig);
  	URLConnection connection = endpoint.openConnection();	
  	BufferedReader buffread = new BufferedReader(new InputStreamReader(connection.getInputStream()));
  	
	int i = 0;
	String recv;
  	while((recv = buffread.readLine()) != null) {
		props[i] = recv;
		i++;
		
	}
  	buffread.close();
   }catch(Exception ex){System.out.println(ex);}	
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
        <h1>app on Docker - Request Information</h1>
        <ul>
            <li>getVirtualServerName(): <%= request.getServletContext().getVirtualServerName() %></li>
            <li>InetAddress.hostname: <%=hostname%></li>
            <li>InetAddress.serverAddress: <%=serverAddress%></li>
            <li>getLocalAddr(): <%=request.getLocalAddr()%></li>
            <li>getLocalName(): <%=request.getLocalName()%></li>
            <li>getLocalPort(): <%=request.getLocalPort()%></li>
            <li>getServerName(): <%=request.getServerName()%></li>
        </ul>
	<h1>Properties Information</h1>
	<ul><% for(int i=0;i<5;i++) { %> <li><%=props[i]%></li> <%}%></ul>
    </body>
</html>
