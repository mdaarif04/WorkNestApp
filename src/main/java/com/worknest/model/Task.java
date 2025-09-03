package com.worknest.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;

@Entity
@Table(name="tasks")
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String taskCode;

    @Column(nullable=false)
    private String title;

    @Column(columnDefinition="TEXT")
    private String description;

    @Column(nullable=false)
    private String status = "PENDING";

    private Date startDate;
    private Date dueDate;
    
 // NEW: soft-finish flag (hide from lists but keep in DB)
    @Column(nullable = false)
    private boolean permanentlyFinished = false;

    // NEW: comma-separated user IDs who are locked out (cannot act)
    @Column(name="lockedForUserIds")
    private String lockedUserIds; // e.g., "3,7,12"

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name="task_users",
        joinColumns = @JoinColumn(name="task_id"),
        inverseJoinColumns = @JoinColumn(name="user_id")
    )
    private List<User> users;
    
    
	// getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    public List<User> getUsers() { return users; }
    public void setUsers(List<User> users) { this.users = users; }
    
    public String getTaskCode() { return taskCode; }
    public void setTaskCode(String taskCode) { this.taskCode = taskCode; }
    
    
    public boolean isPermanentlyFinished() { return permanentlyFinished; }
    public void setPermanentlyFinished(boolean permanentlyFinished) { this.permanentlyFinished = permanentlyFinished; }

    public String getLockedUserIds() { return lockedUserIds; }
    public void setLockedUserIds(String lockedUserIds) { this.lockedUserIds = lockedUserIds; }

    // Helpers
    @Transient
    public boolean isLockedForUser(int userId) {
        if (lockedUserIds == null || lockedUserIds.trim().isEmpty()) return false;
        return Arrays.stream(lockedUserIds.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .anyMatch(s -> Integer.toString(userId).equals(s));
    }

    public void lockUser(int userId){
        if (isLockedForUser(userId)) return;
        if (lockedUserIds == null || lockedUserIds.trim().isEmpty()){
            lockedUserIds = Integer.toString(userId);
        } else {
            lockedUserIds = lockedUserIds + "," + userId;
        }
    }

    public void clearLocks(){
        this.lockedUserIds = null;
    }
}
