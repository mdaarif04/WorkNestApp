package com.worknest.controller;

import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.service.CommentService;
import com.worknest.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class TaskController {

    @Autowired
    private TaskService taskService;
    @Autowired
    private CommentService commentService;

    @GetMapping("/tasks")
    public String myTasks(HttpSession session, Model model){
        User u = (User) session.getAttribute("user");
        if(u == null){ return "redirect:/login"; }
        List<Task> tasks = taskService.byUser(u);
        model.addAttribute("tasks", tasks);
        return "user-tasks";
    }

    @PostMapping("/tasks/status")
    public String updateStatus(@RequestParam int taskId, @RequestParam String status, HttpSession session){
        User u = (User) session.getAttribute("user");
        if(u == null){ return "redirect:/login"; }
        taskService.updateStatus(taskId, status);
        return "redirect:/user/tasks";
    }

    @PostMapping("/tasks/comment")
    public String addComment(@RequestParam int taskId, @RequestParam String content, HttpSession session){
        User u = (User) session.getAttribute("user");
        if(u == null){ return "redirect:/login"; }
        Task t = taskService.byId(taskId);
        if(t != null){
            commentService.add(t, u, content);
        }
        return "redirect:/user/tasks";
    }
    
    @GetMapping("/tasks/{id}")
    public String viewTask(@PathVariable int id, Model model) {
        Task task = taskService.byId(id);
        model.addAttribute("task", task);
        model.addAttribute("comments", commentService.forTask(task));
        return "taskDetail";
    }

}
