package com.worknest.dao;

import com.worknest.model.Task;
import com.worknest.model.User;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskDAO {
    @Autowired
    private SessionFactory sessionFactory;

    public void save(Task task) {
        sessionFactory.getCurrentSession().saveOrUpdate(task);
    }

    public Task findById(int id){
        return sessionFactory.getCurrentSession().get(Task.class, id);
    }

    public List<Task> findAll(){
        return sessionFactory.getCurrentSession().createQuery("from Task", Task.class).list();
    }

    public List<Task> findByUser(User user){
        Query<Task> q = sessionFactory.getCurrentSession()
                .createQuery("from Task where user=:u", Task.class);
        q.setParameter("u", user);
        return q.list();
    }
    
    public void delete(Task task){
        sessionFactory.getCurrentSession().delete(task);
    }

    
}
