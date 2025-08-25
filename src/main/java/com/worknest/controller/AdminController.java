package com.worknest.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.worknest.model.Comment;
import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.service.CommentService;
import com.worknest.service.TaskService;
import com.worknest.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private TaskService taskService;
    
    @Autowired
    private CommentService commentService;

//    @GetMapping("/dashboard")
//    public String dashboard(HttpSession session, Model model){
//        User u = (User) session.getAttribute("user");
//        if(u == null || !"ADMIN".equalsIgnoreCase(u.getRole())){
//            return "redirect:/login";
//        }
//        model.addAttribute("users", userService.all());
//        model.addAttribute("tasks", taskService.all());
//        return "admin-dashboard";
//    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model){
        User u = (User) session.getAttribute("user");
        if(u == null || !"ADMIN".equalsIgnoreCase(u.getRole())){
            return "redirect:/login";
        }

        model.addAttribute("users", userService.all());
        model.addAttribute("tasks", taskService.all());

        // map each task to its comments
        Map<Integer, List<Comment>> taskComments = new HashMap<>();
        for(Task t : taskService.all()){
            taskComments.put(t.getId(), commentService.forTask(t));
        }
        model.addAttribute("taskComments", taskComments);

        return "admin-dashboard";
    }
    
    
    @PostMapping("/users/delete")
    public String deleteUser(@RequestParam int userId) {
        userService.delete(userId);
        return "redirect:/admin/dashboard";
    }
    
    
    @PostMapping("/tasks/delete")
    public String deleteTask(@RequestParam int taskId) {
        taskService.delete(taskId);
        return "redirect:/admin/dashboard";
    }
    
    
    @GetMapping("/tasks/edit")
    public String editTaskPage(@RequestParam int taskId, Model model) {
        Task task = taskService.byId(taskId);
        model.addAttribute("task", task);
        model.addAttribute("users", userService.all());
        return "edit-task";
    }

    @PostMapping("/tasks/edit")
    public String editTask(@RequestParam int id,
                           @RequestParam String title,
                           @RequestParam String description,
                           @RequestParam String status,
                           @RequestParam(required=false) String startDate,
                           @RequestParam(required=false) String dueDate,
                           @RequestParam int userId) {

        Date start = (startDate==null || startDate.isEmpty()) ? null : Date.valueOf(startDate);
        Date due = (dueDate==null || dueDate.isEmpty()) ? null : Date.valueOf(dueDate);

        taskService.update(id, title, description, status, start, due, userService.byId(userId));
        return "redirect:/admin/dashboard";
    }




    

    @PostMapping("/tasks/allocate")
    public String allocate(@RequestParam String title,
                           @RequestParam(required=false) String description,
                           @RequestParam(required=false) String startDate,
                           @RequestParam(required=false) String dueDate,
                           @RequestParam int userId){
        Date start = (startDate==null || startDate.isEmpty()) ? null : Date.valueOf(startDate);
        Date due = (dueDate==null || dueDate.isEmpty()) ? null : Date.valueOf(dueDate);
        User assignee = userService.byId(userId);
        taskService.allocate(title, description, start, due, assignee);
        return "redirect:/admin/dashboard";
    }
}
