/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.dao;

import ec.edu.ups.modelo.Phone;
import java.util.List;

/**
 *
 * @author claum
 */
public interface PhoneDAO extends GenericDAO<Phone, Integer>{
    public abstract List<Phone> findByUserId(String cedula);
    public abstract List<Phone> findByNumber(String numero, String cedula);
}
