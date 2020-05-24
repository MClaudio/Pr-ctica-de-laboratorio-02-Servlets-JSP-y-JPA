/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.dao;

/**
 *
 * @author claum
 */
public abstract class DAOFactory {
    protected static DAOFactory factory = new JPADAOFactory();
    
    public static DAOFactory getDAOFactory(){return factory;}
   
    
    public abstract UserDAO getUserDAO();
    
    public abstract PhoneDAO getPhoneDAO();
}
