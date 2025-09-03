package com.worknest.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.service.CommentService;
import com.worknest.service.ReassignLogService;
import com.worknest.service.TaskService;
import com.worknest.service.UserService;

@Controller
@RequestMapping("/user")
public class TaskController {

    @Autowired
    private TaskService taskService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;
    @Autowired
    private ReassignLogService reassignLogService;

    @GetMapping("/tasks")
    public String myTasks(HttpSession session, Model model, 
                          @ModelAttribute("msg") String msg){
        User u = (User) session.getAttribute("user");
        if(u == null){ 
            return "redirect:/login"; 
        }

        List<Task> tasks = taskService.byUser(u);
        model.addAttribute("tasks", tasks);
        model.addAttribute("users", userService.all());
        model.addAttribute("currentUser", u); // NEW: for JSP lock checks
        if(msg != null && !msg.isEmpty()){
            model.addAttribute("msg", msg);
        }
        return "user-tasks";
    }

    @PostMapping("/tasks/reassign")
    public String reassignTask(@RequestParam(required = false) Integer taskId,
                               @RequestParam(required = false) Integer newUserId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes){
        User sender = (User) session.getAttribute("user");
        if(sender == null) return "redirect:/login";

        if(taskId == null || newUserId == null){
            redirectAttributes.addFlashAttribute("msg", "❌ Task or User ID missing!");
            return "redirect:/user/tasks";
        }

        User toUser = userService.byId(newUserId);
        Task task = taskService.reassignAndLockSender(taskId, toUser, sender);

        if(task != null){
            reassignLogService.log(task, sender, toUser);
            redirectAttributes.addFlashAttribute("msg",
                "Task reassigned to " + toUser.getName() + " and locked for you.");
        }
        return "redirect:/user/tasks";
    }


    
    @PostMapping("/tasks/forward")
    public String forwardTask(@RequestParam Integer taskId,
                              @RequestParam Integer newUserId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User sender = (User) session.getAttribute("user");
        if(sender == null) return "redirect:/login";

        Task t = taskService.forwardAndLockSender(taskId, newUserId, sender.getId());
        if(t != null){
            User toUser = userService.byId(newUserId);
            reassignLogService.log(t, sender, toUser);
        }
        redirectAttributes.addFlashAttribute("msg", "✅ Task forwarded and locked for you!");
        return "redirect:/user/tasks";
    }


    @PostMapping("/tasks/status")
    public String updateStatus(@RequestParam Integer taskId, @RequestParam String status, HttpSession session){
        User u = (User) session.getAttribute("user");
        if(u == null){ return "redirect:/login"; }

        Task t = taskService.byId(taskId);
        if(t != null && t.isLockedForUser(u.getId())){
            // user locked: cannot act
            return "redirect:/user/tasks";
        }

        taskService.updateStatus(taskId, status);
        return "redirect:/user/tasks";
    }

    @PostMapping("/tasks/comment")
    public String addComment(@RequestParam Integer taskId, @RequestParam String content, HttpSession session){
        User u = (User) session.getAttribute("user");
        if(u == null){ return "redirect:/login"; }

        Task t = taskService.byId(taskId);
        if(t != null && t.isLockedForUser(u.getId())){
            // user locked: cannot act
            return "redirect:/user/tasks";
        }

        if(t != null){
            commentService.add(t, u, content);
        }
        return "redirect:/user/tasks";
    }
    
    
    @GetMapping("/tasks/allocate")
    public String allocatePage(Model model) {
        // saare users laao (except admin agar chahiye to filter kar lena)
        List<User> users = userService.all();
        model.addAttribute("users", users);

        return "allocate"; // ye allocate.jsp open karega
    }
    
//    @GetMapping("/tasks/{taskId}")
//    public String showTaskDetails(@PathVariable Long taskId, Model model) {
//        Task task = taskService.getTaskById(taskId);
//        List<User> users = userService.getAllUsers(); // yahi sirf dikhana hai dropdown me
//
//        model.addAttribute("task", task);
//        model.addAttribute("users", users);
//        return "taskDetails"; // same JSP page
//    }

}
