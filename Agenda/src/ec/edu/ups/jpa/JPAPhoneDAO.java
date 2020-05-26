package ec.edu.ups.jpa;

import java.util.List;

import ec.edu.ups.dao.DAOFactory;
import ec.edu.ups.dao.PhoneDAO;
import ec.edu.ups.dao.UserDAO;
import ec.edu.ups.modelo.Phone;
import ec.edu.ups.modelo.User;

public class JPAPhoneDAO extends JPAGenericDao<Phone, Integer> implements PhoneDAO {

	public JPAPhoneDAO() {
		super(Phone.class);
	}
	
	@Override
	public List<Phone> findByUserId(String cedula) {
        String jpql = "FROM Phone p WHERE p.user_cedula = '" + cedula + "'";
        List<Phone> phones = (List<Phone>) em.createQuery(jpql).getResultList();
        return phones;  
	}

	@Override
	public List<Phone> findByNumber(String numero, String cedula) {
		UserDAO userDao = DAOFactory.getDAOFactory().getUserDAO();
        User user = userDao.findById(cedula);
        user.getTelefonos().size();
        if(user.getTelefonos().contains(numero)) {
        	 return null;
        }
        return null;
       
	}

}
