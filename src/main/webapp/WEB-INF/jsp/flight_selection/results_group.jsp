<%--
  Created by IntelliJ IDEA.
  User: b8ne
  Date: 6/5/18
  Time: 5:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <div id="progress" class="container p-5">
        <p class="h5 text-white">You're almost there...</p>
        <div class="progress" style="height: 20px;">
            <div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">50%</div>
        </div>
    </div>
</div>
<div>
    <a type="button" href="addToCart.action"/>Proceed to Checkout</a>
</div>
<div id="results" class="container mt-5">
    <div class="row">
        <div class="col-8">
            <p class="h4">Results.</p>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Price</th>
                    <th scope="col">Departure City</th>
                    <th scope="col">Arrival City</th>
                    <th scope="col">Cabin Class</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                    <s:iterator value="flights" var="flight">
                        <tr>

                            <td scope="row">
                                <fmt:formatNumber value="${price.price}" type="currency" currencySymbol="$"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${departureTime}" pattern="dd/MM/YY HH:mm" />
                            </td>
                            <td>
                                <fmt:formatDate value="${arrivalTime}" pattern="dd/MM/YY HH:mm" />
                            </td>
                            <td>${flight.departure}</td>
                            <td>${flight.destination}</td>
                            <td>${price.classCode}</td>
                            <td class="text-white">
                                <a href="<s:url action="addToGroup">
                                <s:param name="flightId" value="%{id}" />
                                <s:param name="airline" value="%{price.airlineCode}" />
                                <s:param name="tcktClass" value="%{price.classCode}" />
                                <s:param name="tcktType" value="%{price.ticketCode}" />
                                <s:param name="flightNumber" value="%{flightNumber}" />
                            </s:url>" role="button" class="btn btn-primary btn-sm float-right">Add to Cart</a>
                            </td>
                        </tr>
                    </s:iterator>
                    <s:iterator value="flights" var="flight">
                        <tr>

                            <td scope="row">
                                <fmt:formatNumber value="${price.price}" type="currency" currencySymbol="$"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${departureTime}" pattern="dd/MM/YY HH:mm" />
                            </td>
                            <td>
                                <fmt:formatDate value="${arrivalTime}" pattern="dd/MM/YY HH:mm" />
                            </td>
                            <td>${flight.departure}</td>
                            <td>${flight.destination}</td>
                            <td>${price.classCode}</td>
                            <td class="text-white">
                                <a href="<s:url action="addToGroup">
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
            <div>
                    <a type="button" href="addToCart.action"/>Proceed to Checkout</a>
            </div>
            <a role="button" class="btn btn-secondary" href="<s:url action='search' >
                        <s:param name='userType' value='userType' />
                    </s:url>">Back to Search</a>
        </div>
        <div class="col-4">
            <%@ include file="/WEB-INF/jsp/recommendations/friends.jsp" %>
        </div>
    </div>
</div>
