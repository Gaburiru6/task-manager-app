<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gerenciador de Tarefas - Formulário</title>
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
            max-width: 600px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input[type="text"], input[type="date"], select, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        textarea {
            height: 80px;
            resize: vertical;
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
        
        .btn-secondary {
            background-color: #6c757d;
        }
        
        .btn-secondary:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>
    <h1>Gerenciador de Tarefas</h1>
    
    <div class="container">
        <h2><c:choose><c:when test="${task.id != null}">Editar Tarefa</c:when><c:otherwise>Nova Tarefa</c:otherwise></c:choose></h2>
        
        <form action="tasks" method="post">
            <input type="hidden" name="action" value="save">
            <c:if test="${task.id != null}">
                <input type="hidden" name="id" value="${task.id}">
            </c:if>
            
            <div class="form-group">
                <label for="title">Título:</label>
                <input type="text" id="title" name="title" value="${task.title}" required>
            </div>
            
            <div class="form-group">
                <label for="description">Descrição:</label>
                <textarea id="description" name="description">${task.description}</textarea>
            </div>
            
            <div class="form-group">
                <label for="responsible">Responsável:</label>
                <input type="text" id="responsible" name="responsible" value="${task.responsible}">
            </div>
            
            <div class="form-group">
                <label for="priority">Prioridade:</label>
                <select id="priority" name="priority">
                    <option value="">-- Selecione --</option>
                    <option value="ALTA" <c:if test="${task.priority == 'ALTA'}">selected</c:if>>Alta</option>
                    <option value="MEDIA" <c:if test="${task.priority == 'MEDIA'}">selected</c:if>>Média</option>
                    <option value="BAIXA" <c:if test="${task.priority == 'BAIXA'}">selected</c:if>>Baixa</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="deadline">Deadline:</label>
                <input type="date" id="deadline" name="deadline" 
                       value="<c:if test='${task.deadline != null}'><fmt:formatDate value='${task.deadline}' pattern='yyyy-MM-dd'/></c:if>">
            </div>
            
            <button type="submit" class="btn">Salvar</button>
            <a href="tasks" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>

