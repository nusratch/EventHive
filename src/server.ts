import env from "./config/env.js";
import app from "./app.js";
import pool from "./config/db.js";

const PORT = env.PORT;

pool.query("SELECT NOW()")
  .then((result) => {
    console.log("Database connected successfully!");
    console.log("Database time:", result.rows[0].now);
  })
  .catch((error) => {
    console.error("Database connection failed:", error);
  });
  
app.listen(PORT, () => {
  console.log(`EventHive server is running on port ${PORT}`);
});
