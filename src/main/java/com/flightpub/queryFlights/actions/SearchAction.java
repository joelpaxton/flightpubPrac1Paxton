package com.flightpub.queryFlights.actions;

import com.flightpub.base.hibernate.dao.*;
import com.flightpub.base.hibernate.listener.HibernateListener;
import com.flightpub.base.model.*;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.hibernate.SessionFactory;

import java.util.*;

public class SearchAction extends ActionSupport implements SessionAware {

    private String userType;
    private Map<String, Object> userSession ;

    private List<Destination> destinations = new ArrayList<Destination>();
    private List<TicketClass> ticketClasses = new ArrayList<TicketClass>();
    private List<TicketType> ticketTypes = new ArrayList<TicketType>();
    private List<Airlines> airlines = new ArrayList<Airlines>();

    private List<Flights> flights = new ArrayList<Flights>();
//    private List<Flights> twoCities = new ArrayList<Flights>();
//    private List<Flights> threeCities = new ArrayList<Flights>();
//    private List<Flights> fourCities = new ArrayList<Flights>();

    private String dptCode;
    private String dptCode2;
    private String dptCode3;
    private String dptCode4;
    private String dstCode;
    private String tcktClass;
    private String tcktType;
    private Date dptTime;
    private Date dstTime;
    private boolean directFlightsOnly;
    private boolean arriveDayBefore;
    private boolean includeReturn;
    private boolean multiCity;
    private boolean surroundingDays;
    private int minPrice;
    private int maxPrice;
    private int stopOvers;
    private int passengers;
    private boolean sameFlight;
    private boolean groupDiscount;

    public SearchAction() {
        this.stopOvers = -1;
    }

    public String display() {
        userSession.put("USER_TYPE", userType);

        SessionFactory sessionFactory =
                (SessionFactory) ServletActionContext.getServletContext()
                        .getAttribute(HibernateListener.KEY_NAME);

        // Get destinations
        DestinationsDAO destinationsDAO = new DestinationsDAOImpl(sessionFactory);
        this.destinations = destinationsDAO.getDestinations();

        // Get cabin classes
        TicketTypesDAO ticketTypesDAO = new TicketTypesDAOImpl(sessionFactory);
        this.ticketTypes = ticketTypesDAO.getTicketTypes();

        TicketClassesDAO ticketClassesDAO = new TicketClassesDAOImpl(sessionFactory);
        this.ticketClasses = ticketClassesDAO.getTicketClasses();

        // Get carriers
        AirlinesDAO airlinesDAO = new AirlinesDAOImpl(sessionFactory);
        this.airlines = airlinesDAO.getAirlines();

        return SUCCESS;
    }

    public String execute() {
        SessionFactory sessionFactory =
                (SessionFactory) ServletActionContext.getServletContext()
                        .getAttribute(HibernateListener.KEY_NAME);
        userType = userSession.get("USER_TYPE").toString();
        if (userType=="group") {
            userSession.put("PASSENGERS", passengers);
        }

        HashMap<String, String> params = new HashMap<String, String>();

        params.put("departureCode", dptCode);
        if (dptCode2!=null) {
            params.put("departureCode2", dptCode2);
        }
        if (dptCode3!=null) {
            params.put("departureCode3", dptCode3);
        }
        if (dptCode4!=null) {
            params.put("departureCode4", dptCode4);
        }
        params.put("arrivalCode", dstCode);
        if (directFlightsOnly) {
            params.put("directFlightsOnly", "true");
        }
        if (arriveDayBefore) {
            params.put("arriveDayBefore", "true");
        }
        if (stopOvers >= 0) {
            params.put("stopOvers", Integer.toString(stopOvers));
        }

        HashMap<String, Date> dates = new HashMap<String, Date>();
        if (dptTime != null) {
            dates.put("departureTime", dptTime);
        }
        if (dstTime == null) {
            Date tomorrow = new Date(dptTime.getTime()+(1000*60*60*48));
            dates.put("arrivalTime", tomorrow);
        }
            else {
                dates.put("arrivalTime", dstTime);
            }


        FlightsDAO flightsDAO = new FlightsDAOImpl(sessionFactory);
        flights = flightsDAO.getFlights(params, dates);

        PriceDAO priceDAO = new PriceDAOImpl(sessionFactory);
        List<Flights> toRemove = new ArrayList<Flights>();
        for (Flights f : flights) {
            Price price = priceDAO.getPrice(f.getAirlineCode(), tcktClass, tcktType, f.getFlightNumber());

            if (minPrice > 0 && price.getPrice() < minPrice) {
                toRemove.add(f);
            }

            if (maxPrice > 0 && price.getPrice() > maxPrice) {
                toRemove.add(f);
            }

            f.setPrice(price);
        }

        for (Flights f : toRemove) {
            flights.remove(f);
        }

        return SUCCESS;
    }

    public Date getTodayDate(){

        return new Date();
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session ;
    }

    public String getUserType() {
        return userType;
    }
    public void setUserType(String userType) {
        this.userType = userType;
    }

    public List<Destination> getDestinations() {
        return destinations;
    }

    public void setDestinations(List<Destination> destinations) {
        this.destinations = destinations;
    }

    public List<TicketClass> getTicketClasses() {
        return ticketClasses;
    }

    public void setTicketClasses(List<TicketClass> ticketClasses) {
        this.ticketClasses = ticketClasses;
    }

    public List<TicketType> getTicketTypes() {
        return ticketTypes;
    }

    public void setTicketTypes(List<TicketType> ticketTypes) {
        this.ticketTypes = ticketTypes;
    }

    public List<Airlines> getAirlines() {
        return airlines;
    }

    public void setAirlines(List<Airlines> airlines) {
        this.airlines = airlines;
    }

    public List<Flights> getFlights() {
        return flights;
    }

    public void setFlights(List<Flights> flights) {
        this.flights = flights;
    }

//    public List<Flights> getTwoCities() {
//        return twoCities;
//    }
//
//    public void setTwoCities(List<Flights> twoCities) {
//        this.twoCities = twoCities;
//    }
//
//    public List<Flights> getThreeCities() {
//        return threeCities;
//    }
//
//    public void setThreeCities(List<Flights> threeCities) {
//        this.threeCities = threeCities;
//    }
//
//    public List<Flights> getFourCities() {
//        return fourCities;
//    }
//
//    public void setFourCities(List<Flights> fourCities) {
//        this.fourCities = fourCities;
//    }

    public String getDptCode() {
        return dptCode;
    }

    public void setDptCode(String dptCode) {
        this.dptCode = dptCode;
    }

    public String getDptCode2() {
        return dptCode2;
    }

    public void setDptCode2(String dptCode2) {
        this.dptCode2 = dptCode2;
    }

    public String getDptCode3() {
        return dptCode3;
    }

    public void setDptCode3(String dptCode3) {
        this.dptCode3 = dptCode3;
    }

    public String getDptCode4() {
        return dptCode4;
    }

    public void setDptCode4(String dptCode4) {
        this.dptCode4 = dptCode4;
    }

    public Map<String, Object> getUserSession() {
        return userSession;
    }

    public void setUserSession(Map<String, Object> userSession) {
        this.userSession = userSession;
    }

    public String getDstCode() {
        return dstCode;
    }

    public void setDstCode(String dstCode) {
        this.dstCode = dstCode;
    }

    public String getTcktClass() {
        return tcktClass;
    }

    public void setTcktClass(String tcktClass) {
        this.tcktClass = tcktClass;
    }

    public String getTcktType() {
        return tcktType;
    }

    public void setTcktType(String tcktType) {
        this.tcktType = tcktType;
    }

    public Date getDptTime() {
        return dptTime;
    }

    public void setDptTime(Date dptTime) {
        this.dptTime = dptTime;
    }

    public Date getDstTime() {
        return dstTime;
    }

    public void setDstTime(Date dstTime) {
        this.dstTime = dstTime;
    }

    public boolean isDirectFlightsOnly() {
        return directFlightsOnly;
    }

    public void setDirectFlightsOnly(boolean directFlightsOnly) {
        this.directFlightsOnly = directFlightsOnly;
    }

    public boolean isArriveDayBefore() {
        return arriveDayBefore;
    }

    public void setArriveDayBefore(boolean arriveDayBefore) {
        this.arriveDayBefore = arriveDayBefore;
    }

    public boolean isIncludeReturn() {
        return includeReturn;
    }

    public void setIncludeReturn(boolean includeReturn) {
        this.includeReturn = includeReturn;
    }

    public boolean isMultiCity() {
        return multiCity;
    }

    public void setMultiCity(boolean multiCity) {
        this.multiCity = multiCity;
    }

    public boolean isSurroundingDays() {
        return surroundingDays;
    }

    public void setSurroundingDays(boolean surroundingDays) {
        this.surroundingDays = surroundingDays;
    }

    public int getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(int minPrice) {
        this.minPrice = minPrice;
    }

    public int getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(int maxPrice) {
        this.maxPrice = maxPrice;
    }

    public int getStopOvers() {
        return stopOvers;
    }

    public void setStopOvers(int stopOvers) {
        this.stopOvers = stopOvers;
    }

    public int getPassengers() {
        return passengers;
    }

    public void setPassengers(int passengers) {
        this.passengers = passengers;
    }

    public boolean isSameFlight() {
        return sameFlight;
    }

    public void setSameFlight(boolean sameFlight) {
        this.sameFlight = sameFlight;
    }

    public boolean isGroupDiscount() {
        return groupDiscount;
    }

    public void setGroupDiscount(boolean groupDiscount) {
        this.groupDiscount = groupDiscount;
    }
}