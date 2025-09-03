package com.worknest.service;

import com.worknest.dao.ReassignLogDAO;
import com.worknest.model.ReassignLog;
import com.worknest.model.Task;
import com.worknest.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ReassignLogService {

    @Autowired
    private ReassignLogDAO reassignLogDAO;

    public void log(Task task, User from, User to){
        ReassignLog rl = new ReassignLog();
        rl.setTask(task);
        rl.setFromUser(from);
        rl.setToUser(to);
        reassignLogDAO.save(rl);
    }

    public List<ReassignLog> allNewestFirst(){
        return reassignLogDAO.findAllNewestFirst();
    }

    public List<ReassignLog> byTask(Task task){
        return reassignLogDAO.findByTask(task);
    }

	
}
