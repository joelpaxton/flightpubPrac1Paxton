<%--
  Created by IntelliJ IDEA.
  User: b8ne
  Date: 6/5/18
  Time: 5:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            var max_fields      = 4;
            var wrapper         = $(".container1");
            var add_button      = $(".add_form_field");

            var x = 1;
            $(add_button).click(function(e){
                e.preventDefault();
                if(x < max_fields){
                    x++;
                    $(wrapper).append('<div class="form-group"><label for="departure'+ x +'">Departure City ' + x +'</label>\n' +
                        '                    <select name="dptCode'+ x +' " class="form-control" id="departure" required>\n' +
                        '                        <option disabled selected value>-</option>\n' +
                        '                        <s:iterator value="destinations">\n' +
                        '                            <option value="<s:property value="destinationCode"/>"><s:property value="airport"/> - <s:property value="destinationCode"/></option>\n' +
                        '                        </s:iterator>\n' +
                        '                    </select>\n' +
                        '\n' +
                        '                </div><a href="#" class="delete">Remove</a></div>'); //add input box
                }
                else
                {
                    alert('Maximum number of passengers!')
                }
            });

            $(wrapper).on("click",".delete", function(e){
                e.preventDefault(); $(this).parent('div').remove(); x--;
            })
        });
    </script>
</head>
<body>
<div class="container">
    <div id="progress" class="container p-5">
        <p class="h5 text-white">You're almost there...</p>
        <div class="progress" style="height: 20px;">
            <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
        </div>
    </div>
</div>
<div id="search" class="container mt-5">
    <s:form action="results">
        <p class="h4">Find your Group flight.</p>
        <div class="row">
            <div class="col">
                <div class="container1">
                <div class="form-group">

                    <label for="departure">Departure City</label>
                    <select name="dptCode" class="form-control" id="departure" required>
                        <option disabled selected value>-</option>
                        <s:iterator value="destinations">
                            <option value="<s:property value="destinationCode"/>"><s:property value="airport"/> - <s:property value="destinationCode"/></option>
                        </s:iterator>
                    </select>
                    <button class="add_form_field">Add Another Departure Location &nbsp; <span style="font-size:16px; font-weight:bold;">+ </span></button>
                </div>
            </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="arrival">Arrival City</label>
                    <select name="dstCode" class="form-control" id="arrival" required>
                        <option disabled selected value>-</option>
                        <s:iterator value="destinations">
                            <option value="<s:property value="destinationCode"/>"><s:property value="airport"/> - <s:property value="destinationCode"/></option>
                        </s:iterator>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label for="price_min">Price Min</label>
                    <select name="minPrice" class="form-control" id="price_min">
                        <option disabled selected value>-</option>
                        <option value="0">$0</option>
                        <option value="500">$500</option>
                        <option value="1000">$1000</option>
                        <option value="1500">$1500</option>
                    </select>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="price_max">Price Max</label>
                    <select name="maxPrice" class="form-control" id="price_max">
                        <option disabled selected value>-</option>
                        <option value="100">$100</option>
                        <option value="500">$500</option>
                        <option value="1000">$1000</option>
                        <option value="1500">$1500+</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label for="passengers">Number of passengers</label>
                    <select name="passengers" class="form-control" id="passengers">
                        <option disabled selected value>-</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label>Departure date</label>
                    <div class="input-group date" data-target-input="nearest">
                        <input name="dptTime" type="text" class="form-control datetimepicker-input" id="departureTime" data-toggle="datetimepicker" data-target="#departureTime"/>
                        <span class="input-group-addon">
                            <span class="fas fa-calendar-alt"></span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <div class="form-check form-check-inline" style="margin-left: 20px;">
                        <s:checkbox name="sameFlight" fieldValue="true" theme="simple" />
                        <label class="form-check-label">
                            Same flight
                        </label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <div class="form-check form-check-inline float-right">
                        <s:checkbox name="includeReturn" fieldValue="true" theme="simple" />
                        <label class="form-check-label">
                            Include return fares
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <div class="form-check form-check-inline" style="margin-left: 20px;">
                        <s:checkbox name="groupDiscount" fieldValue="true" theme="simple" />
                        <label class="form-check-label">
                            Group Discount
                        </label>
                    </div>
                </div>
            </div>
            <div class="col"></div>
            <div class="col"></div>
        </div>
        <div class="row">
            <div class="col">
                <button type="submit" class="btn btn-primary float-right">Search</button>
            </div>
        </div>

    </s:form>
</div>
</body>
</html>