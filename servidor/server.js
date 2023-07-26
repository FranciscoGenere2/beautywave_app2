// server.js
const express = require("express");
const mysql = require("mysql");
const app = express();

// Configuración de la conexión a la base de datos MySQL
const connection = mysql.createConnection({
  host: "db4free.net",
  user: "franwave",
  password: "franwave",
  database: "beautywave",
});

// Conexión a la base de datos MySQL
connection.connect((error) => {
  if (error) {
    console.error("Error de conexión a la base de datos:", error);
  } else {
    console.log("Conexión exitosa a la base de datos");
  }
});

// Ruta para verificar la conexión
app.get("/api/verify-connection", (req, res) => {
  connection.query("SELECT 1", (error) => {
    if (error) {
      console.error("Error al verificar la conexión:", error);
      res.status(500).json({ message: "Error de conexión" });
    } else {
      res.status(200).json({ message: "Conexión exitosa" });
    }
  });
});

// Iniciar el servidor
app.listen(3000, () => {
  console.log("Servidor iniciado en el puerto 3000");
});
