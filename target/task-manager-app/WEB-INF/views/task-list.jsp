<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gerenciador de Tarefas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        
        h1 {
            color: #333;
            text-align: center;
        }
        
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }
        
        .btn:hover {
            background-color: #0056b3;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-success {
            background-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <h1>Gerenciador de Tarefas</h1>
    
    <div class="container">
        <a href="tasks?action=edit" class="btn">Nova Tarefa</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Descrição</th>
                    <th>Responsável</th>
                    <th>Prioridade</th>
                    <th>Deadline</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="task" items="${tasks}">
                    <tr>
                        <td>${task.id}</td>
                        <td>${task.title}</td>
                        <td>${task.description}</td>
                        <td>${task.responsible}</td>
                        <td>${task.priority}</td>
                        <td>
                            <c:if test="${task.deadline != null}">
                                <fmt:formatDate value="${task.deadline}" pattern="dd/MM/yyyy"/>
                            </c:if>
                        </td>
                        <td>${task.status}</td>
                        <td>
                            <a href="tasks?action=edit&id=${task.id}" class="btn">Editar</a>
                            <a href="tasks?action=delete&id=${task.id}" class="btn btn-danger" 
                               onclick="return confirm('Tem certeza que deseja remover esta tarefa?');">Remover</a>
                            <c:if test="${task.status == 'EM_ANDAMENTO'}">
                                <a href="tasks?action=complete&id=${task.id}" class="btn btn-success">Concluir</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tasks}">
                    <tr>
                        <td colspan="8" style="text-align: center;">Nenhuma tarefa encontrada.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>

