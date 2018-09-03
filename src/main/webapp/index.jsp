<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: joelp
  Date: 2/09/2018
  Time: 6:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Welcome</title>
</head>
<body>
Why are you travelling today?
<table>
  <tr>
    <td>
      <a href="<s:url action="search">
          <s:param name="userType">business</s:param></s:url>">Business</a>
    </td>
    <td>
      <a href="<s:url action="search">
          <s:param name="userType">couple</s:param></s:url>">Couple</a>
    </td>
    <td>
      <a href="<s:url action="search">
          <s:param name="userType">friends</s:param></s:url>">Friends</a>
    </td>
    <td>
      <a href="<s:url action="search">
          <s:param name="userType">group</s:param></s:url>">Group</a>
    </td>
  </tr>
</table>
</body>
</html>