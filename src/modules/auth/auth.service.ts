import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import authRepository from "./auth.repository.js";
import env from "../../config/env.js";

const signup = async (
  name: string,
  email: string,
  password: string,
  role: string = "attendee"
) => {
  if (!["attendee", "organizer"].includes(role)) {
    throw new Error("Invalid role");
  }

  const existingUser = await authRepository.findUserByEmail(email);

  if (existingUser) {
    throw new Error("Email already exists");
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const user = await authRepository.createUser(
    name,
    email,
    hashedPassword,
    role
  );

  return user;
};

const login = async (email: string, password: string) => {
  const user = await authRepository.findUserByEmail(email);

  if (!user) {
    throw new Error("Invalid email or password");
  }

  const isPasswordValid = await bcrypt.compare(password, user.password);

  if (!isPasswordValid) {
    throw new Error("Invalid email or password");
  }

  const token = jwt.sign(
    { id: user.id, role: user.role },
    env.JWT_SECRET!,
    { expiresIn: "1d" }
  );

  return {
    token,
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    },
  };
};

export default {
  signup,
  login,
};