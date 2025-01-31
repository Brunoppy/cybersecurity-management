-- Criar o banco de dados
CREATE DATABASE CyberSecurity;
USE CyberSecurity;

-- Tabela de Usuários do Sistema
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Manager', 'Employee', 'Guest') DEFAULT 'Employee',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Permissões
CREATE TABLE Permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    module_name VARCHAR(50) NOT NULL, -- Ex: "inventory_management", "sales_management"
    can_read BOOLEAN DEFAULT TRUE,
    can_write BOOLEAN DEFAULT FALSE,
    can_delete BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Tabela de Logs de Auditoria
CREATE TABLE AuditLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Inserindo Usuários
INSERT INTO Users (username, password_hash, role) VALUES
('admin', SHA2('admin123', 256), 'Admin'),
('gestor', SHA2('manager456', 256), 'Manager'),
('funcionario', SHA2('employee789', 256), 'Employee');

-- Inserindo Permissões
INSERT INTO Permissions (user_id, module_name, can_read, can_write, can_delete) VALUES
(1, 'inventory_management', TRUE, TRUE, TRUE), -- Admin tem acesso total
(2, 'sales_management', TRUE, TRUE, FALSE),   -- Manager pode ler e escrever, mas não deletar
(3, 'customer_orders', TRUE, FALSE, FALSE);   -- Employee pode apenas ler pedidos

-- Inserindo Logs de Auditoria
INSERT INTO AuditLogs (user_id, action, ip_address) VALUES
(1, 'Modificou um pedido de cliente', '192.168.1.10'),
(2, 'Criou um novo relatório de vendas', '192.168.1.20'),
(3, 'Acessou o módulo de pedidos', '192.168.1.30');
