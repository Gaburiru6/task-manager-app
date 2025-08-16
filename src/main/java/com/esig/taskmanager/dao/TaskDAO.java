package com.esig.taskmanager.dao;

import com.esig.taskmanager.model.Task;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class TaskDAO {

    private EntityManagerFactory emf;

    public TaskDAO() {
        emf = Persistence.createEntityManagerFactory("task-manager-pu");
    }

    public void save(Task task) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(task);
        em.getTransaction().commit();
        em.close();
    }

    public void update(Task task) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(task);
        em.getTransaction().commit();
        em.close();
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Task task = em.find(Task.class, id);
        if (task != null) {
            em.remove(task);
        }
        em.getTransaction().commit();
        em.close();
    }

    public Task findById(Long id) {
        EntityManager em = emf.createEntityManager();
        Task task = em.find(Task.class, id);
        em.close();
        return task;
    }

    public List<Task> findAll() {
        EntityManager em = emf.createEntityManager();
        List<Task> tasks = em.createQuery("SELECT t FROM Task t", Task.class).getResultList();
        em.close();
        return tasks;
    }
}


