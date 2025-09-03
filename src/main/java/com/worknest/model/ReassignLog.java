package com.worknest.model;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name="reassign_logs")
public class ReassignLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="task_id", nullable=false)
    private Task task;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="from_user_id", nullable=false)
    private User fromUser;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="to_user_id", nullable=false)
    private User toUser;

    @Column(nullable=false)
    private Timestamp at;

    @PrePersist
    public void prePersist(){
        if(at == null) at = new Timestamp(System.currentTimeMillis());
    }

    // getters/setters
    public int getId() { return id; }
    public Task getTask() { return task; }
    public void setTask(Task task) { this.task = task; }
    public User getFromUser() { return fromUser; }
    public void setFromUser(User fromUser) { this.fromUser = fromUser; }
    public User getToUser() { return toUser; }
    public void setToUser(User toUser) { this.toUser = toUser; }
    public Timestamp getAt() { return at; }
    public void setAt(Timestamp at) { this.at = at; }
}
