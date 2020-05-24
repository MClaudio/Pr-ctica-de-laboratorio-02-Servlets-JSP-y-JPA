/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.dao;
import java.util.List;
/**
 *
 * @author claum
 */
public interface GenericDAO<T, ID> {

    public boolean create(T entity);

    public T findById(ID id);

    public boolean update(T entity);

    public boolean delete(T entity);
    
    public boolean deleteById(ID id);

    public List<T> find();
    
    public List<T> find(String[] attributes, String[] values);
}
