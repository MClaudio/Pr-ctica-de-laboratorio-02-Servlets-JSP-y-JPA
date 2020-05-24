/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.dao;

import ec.edu.ups.modelo.User;
import java.util.List;

/**
 *
 * @author claum
 */
public interface UserDAO extends GenericDAO<User, String> {
    public abstract User findUser(String correo, String pass);
    public abstract List<User> findByIdOrMail(String context);
}
