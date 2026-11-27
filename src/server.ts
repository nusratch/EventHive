import env from "./config/env.js";
import app from "./app.js";

const PORT = env.PORT;

app.listen(PORT, () => {
  console.log(`EventHive server is running on port ${PORT}`);
});
