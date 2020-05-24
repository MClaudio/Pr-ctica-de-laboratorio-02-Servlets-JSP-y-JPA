/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.dao;

import ec.edu.ups.jpa.JPAPhoneDAO;
import ec.edu.ups.jpa.JPAUserDAO;

/**
 *
 * @author claum
 */
public class JPADAOFactory extends DAOFactory{

 
    @Override
    public UserDAO getUserDAO() {
        return new JPAUserDAO();
    }

    @Override
    public PhoneDAO getPhoneDAO() {
        return new JPAPhoneDAO();
    }
    
}
