package ec.edu.ups.jpa;

import java.util.ArrayList;
import java.util.List;

import ec.edu.ups.dao.UserDAO;
import ec.edu.ups.modelo.User;

public class JPAUserDAO extends JPAGenericDao<User, String> implements UserDAO {
	
	public JPAUserDAO() {
		super(User.class);

	}

	@Override
	public User findUser(String correo, String pass) {
		//m.getTransaction().begin();
		String sql = "FROM User u WHERE u.correo = '" + correo + "' AND u.password = '" + pass+"'";
		User user = (User) em.createQuery(sql).getSingleResult();
		user.getTelefonos().size();
		//System.out.println("Resultado de la consulta SQL: "+user.toString());
		//em.close();
		return user;
	}

	@Override
	public List<User> findByIdOrMail(String context) {
		List<User> users = new ArrayList<>();
		//em.getTransaction().begin();
        if (context.equals("all")) {
        	users = (List<User>) em.createQuery("FROM User u").getResultList();
        } else {
        	String jpql = "FROM User u WHERE u.cedula = '" + context + "' OR u.correo = '" + context + "'";
        	users = (List<User>) em.createQuery(jpql).getResultList();
        }
        //em.close();
        return users;
	}

}
