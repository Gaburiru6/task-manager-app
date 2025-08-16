package com.esig.taskmanager.servlet;

import com.esig.taskmanager.dao.TaskDAO;
import com.esig.taskmanager.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/tasks")
public class TaskServlet extends HttpServlet {

    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listTasks(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteTask(request, response);
                break;
            case "complete":
                completeTask(request, response);
                break;
            default:
                listTasks(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            saveTask(request, response);
        } else {
            listTasks(request, response);
        }
    }

    private void listTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Task> tasks = taskDAO.findAll();
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("/WEB-INF/views/task-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        Task task = new Task();
        
        if (idParam != null && !idParam.isEmpty()) {
            Long id = Long.parseLong(idParam);
            task = taskDAO.findById(id);
        }
        
        request.setAttribute("task", task);
        request.getRequestDispatcher("/WEB-INF/views/task-form.jsp").forward(request, response);
    }

    private void saveTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String responsible = request.getParameter("responsible");
        String priorityParam = request.getParameter("priority");
        String deadlineParam = request.getParameter("deadline");

        Task task = new Task();
        
        if (idParam != null && !idParam.isEmpty()) {
            task.setId(Long.parseLong(idParam));
        }
        
        task.setTitle(title);
        task.setDescription(description);
        task.setResponsible(responsible);
        
        if (priorityParam != null && !priorityParam.isEmpty()) {
            task.setPriority(Task.Priority.valueOf(priorityParam));
        }
        
        if (deadlineParam != null && !deadlineParam.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date deadline = sdf.parse(deadlineParam);
                task.setDeadline(deadline);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        if (task.getId() == null) {
            task.setStatus(Task.Status.EM_ANDAMENTO);
            taskDAO.save(task);
        } else {
            taskDAO.update(task);
        }
        
        response.sendRedirect("tasks");
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            Long id = Long.parseLong(idParam);
            taskDAO.delete(id);
        }
        response.sendRedirect("tasks");
    }

    private void completeTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            Long id = Long.parseLong(idParam);
            Task task = taskDAO.findById(id);
            if (task != null) {
                task.setStatus(Task.Status.CONCLUIDA);
                taskDAO.update(task);
            }
        }
        response.sendRedirect("tasks");
    }
}

