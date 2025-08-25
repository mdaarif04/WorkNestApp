package com.worknest.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.worknest.dao.TaskDAO;
import com.worknest.model.Task;
import com.worknest.model.User;

@Service
@Transactional
public class TaskService {
    @Autowired
    private TaskDAO taskDAO;

    public void allocate(String title, String description, Date start, Date due, User user){
        Task t = new Task();
        t.setTitle(title);
        t.setDescription(description);
        t.setStartDate(start);
        t.setDueDate(due);
        t.setStatus("PENDING");
        t.setUser(user);
        taskDAO.save(t);
    }

    public void updateStatus(int taskId, String status){
        Task t = taskDAO.findById(taskId);
        if(t != null){
            t.setStatus(status);
            taskDAO.save(t);
        }
    }
    
    public void delete(int id){
        Task t = taskDAO.findById(id);
        if(t != null){
            taskDAO.delete(t);
        }
    }
    
    public void update(int id, String title, String description, String status, Date start, Date due, User user){
        Task t = taskDAO.findById(id);
        if(t != null){
            t.setTitle(title);
            t.setDescription(description);
            t.setStatus(status);
            t.setStartDate(start);
            t.setDueDate(due);
            t.setUser(user);
            taskDAO.save(t);
        }
    }



    public Task byId(int id){ return taskDAO.findById(id); }
    public List<Task> all(){ return taskDAO.findAll(); }
    public List<Task> byUser(User u){ return taskDAO.findByUser(u); }
}
