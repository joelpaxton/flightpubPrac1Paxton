<%--
  Created by IntelliJ IDEA.
  User: joelp
  Date: 1/09/2018
  Time: 3:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <div id="progress" class="container p-5" >
        <p class="h5 text-white">You're almost there...</p>
        <div class="progress" style="height: 20px;">
            <div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">50%</div>
        </div>
    </div>
</div>
<div id="results" class="container mt-5">
    <table class="table table-hover">
        <thead>
        <tr>
            <th scope="col">Departure Time</th>
            <th scope="col">Arrival Time</th>
            <th scope="col">Departure City</th>
            <th scope="col">Arrival City</th>
            <th scope="col">Cabin Class</th>
            <th scope="col">Price</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="flights" var="flight">
            <tr>
                <td>
                    <fmt:formatDate value="${departureTime}" pattern="dd/MM/YY HH:mm" />
                </td>
                <td>
                    <fmt:formatDate value="${arrivalTime}" pattern="dd/MM/YY HH:mm" />
                </td>
                <td>${flight.departure}</td>
                <td>${flight.destination}</td>
                <td>${price.classCode}</td>
                <td>
                    <fmt:formatNumber value="${price.price}" type="currency" currencySymbol="$"/>
                </td>
                <td class="text-white">
                    <a href="<s:url action="addToCart">
                                <s:param name="flightId" value="%{id}" />
                                <s:param name="airline" value="%{price.airlineCode}" />
                                <s:param name="tcktClass" value="%{price.classCode}" />
                                <s:param name="tcktType" value="%{price.ticketCode}" />
                                <s:param name="flightNumber" value="%{flightNumber}" />
                            </s:url>" role="button" class="btn btn-primary btn-sm float-right">Add to Cart</a>
                </td>
            </tr>
        </s:iterator>
        </tbody>
    </table>
    <a role="button" class="btn btn-secondary" href="<s:url action='search' >
                        <s:param name='userType' value='userType' />
                    </s:url>">Back to Search</a>
</div>