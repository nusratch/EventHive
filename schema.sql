CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    ROLE VARCHAR(20) NOT NULL
DEFAULT 'attendee' CHECK (ROLE IN ('attendee', 'organizer')),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL ,
    CATEGORY VARCHAR(100) NOT NULL,
    date TIMESTAMP NOT NULL,
    location TEXT NOT NULL,
    total_seats INTEGER NOT NULL 
    CHECK (total_seats >0 ),
    available_seats INTEGER NOT NULL ,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    organizer_id INTEGER NOT NULL  REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
CONSTRAINT check_available_seats CHECK (available_seats >=0 AND available_seats <= total_seats)
);


CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    attendee_id INTEGER NOT NULL REFERENCES users(id),
    tickets_booked INTEGER NOT NULL CHECK (tickets_booked > 0),
    total_price NUMERIC(10, 2) NOT NULL CHECK (total_price >= 0),
   status VARCHAR(20) NOT NULL DEFAULT 'confirmed' CHECK (status IN ('confirmed', 'cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    
);