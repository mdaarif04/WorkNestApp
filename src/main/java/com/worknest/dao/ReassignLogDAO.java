package com.worknest.dao;

import com.worknest.model.ReassignLog;
import com.worknest.model.Task;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReassignLogDAO {
    @Autowired
    private SessionFactory sessionFactory;

    public void save(ReassignLog log){
        sessionFactory.getCurrentSession().save(log);
    }

    public List<ReassignLog> findAllNewestFirst(){
        Query<ReassignLog> q = sessionFactory.getCurrentSession()
                .createQuery("from ReassignLog rl order by rl.at desc", ReassignLog.class);
        return q.list();
    }

    public List<ReassignLog> findByTask(Task task){
        Query<ReassignLog> q = sessionFactory.getCurrentSession()
                .createQuery("from ReassignLog rl where rl.task=:t order by rl.at desc", ReassignLog.class);
        q.setParameter("t", task);
        return q.list();
    }
    
 // In ReassignLogDaoImpl.java
//    @Override
//    public List<ReassignLog> findAll() {
//        Session session = sessionFactory.getCurrentSession();
//        Query<ReassignLog> query = session.createQuery(
//            "SELECT rl FROM ReassignLog rl " +
//            "JOIN FETCH rl.task " +
//            "JOIN FETCH rl.fromUser " +
//            "JOIN FETCH rl.toUser " +
//            "ORDER BY rl.at DESC",
//            ReassignLog.class
//        );
//        return query.getResultList();
//    }

}
