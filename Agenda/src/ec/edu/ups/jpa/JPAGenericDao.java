package ec.edu.ups.jpa;

import java.util.List;


import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import ec.edu.ups.dao.GenericDAO;


public class JPAGenericDao<T, ID> implements GenericDAO<T, ID> {
	
	private Class<T> persistenClass;
	protected  EntityManager em;
	
	
	public JPAGenericDao(Class<T> persistenClass) {
		this.persistenClass = persistenClass;
		this.em = Persistence.createEntityManagerFactory("Agenda").createEntityManager();
	}

	@Override
	public boolean create(T entity) {
		em.getTransaction().begin();
		try {
			em.persist(entity);
			em.getTransaction().commit();
			//em.getTransaction().getClass();
			return true;
		} catch (Exception e) {
			System.out.println(">>>>> Error: JPAgenericDao.create "+e);
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
				//em.getTransaction().getClass();
			}
			return false;
		}

	}

	@Override
	public T findById(ID id) {
		//em.getTransaction().begin();
		return em.find(persistenClass, id);
	}

	@Override
	public boolean update(T entity) {
		em.getTransaction().begin();
		try {
			em.merge(entity);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			System.out.println(">>>>> Error: JPAgenericDao.update "+e);
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			return false;
		}
	}

	@Override
	public boolean delete(T entity) {
		em.getTransaction().begin();
		try {
			em.remove(entity);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			System.out.println(">>>>> Error: JPAgenericDao.delete "+e);
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			return false;
		}
	}

	@Override
	public List<T> find() {
		em.getTransaction().begin();
		List<T> lista = null;
		try {
		    javax.persistence.criteria.CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
		    cq.select(cq.from(persistenClass));
		    lista = em.createQuery(cq).getResultList();
		    em.getTransaction().commit();
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return lista;
	}

	@Override
	public boolean deleteById(ID id) {
		T entity = this.findById(id);
		if (entity != null) {
			return this.delete(entity);	
		}
		return false;
	}

	@Override
	public List<T> find(String[] attributes, String[] values) {
		CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
		CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.persistenClass);
		Root<T> root = criteriaQuery.from(this.persistenClass);
		criteriaQuery.select(root);
		Predicate predicate = criteriaBuilder.conjunction();
		for (int i = 0; i < attributes.length; i++) {
			Predicate sig = criteriaBuilder.like(root.get(attributes[i]).as(String.class), values[i]);
			predicate = criteriaBuilder.and(predicate, sig);
		}
		criteriaQuery.where(predicate);
		Query query = em.createQuery(criteriaQuery);
		return query.getResultList();
	}

}
