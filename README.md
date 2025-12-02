# Project Repository Links

## Student Information
- **Name:** Jigarkumar Dilipkumar Patel
- **Student ID:** 041169204
- **Course:** CST8916 - Fall 2025

## Repository Links

### 1. Main Documentation Repository
- **URL:** https://github.com/Jigarkumar25/rideau-canal-monitoring
- **Description:** Complete project documentation, architecture, screenshots, and guides

### 2. Sensor Simulation Repository
- **URL:** https://github.com/Jigarkumar25/rideau-canal-sensor-simulation
- **Description:** IoT sensor simulator code

### 3. Web Dashboard Repository
- **URL:** https://github.com/Jigarkumar25/rideau-canal-dashboard
- **Description:** Web dashboard application

## Demo

- **Video Demo:** [YouTube]


## Project Overview  
This project implements a real-time IoT-based monitoring system for the Rideau Canal Skateway.  
It uses simulated sensors, Azure IoT Hub, Azure Stream Analytics, Azure Cosmos DB, Azure Blob Storage, and a live Web Dashboard.  
The system monitors ice thickness, temperature, and snow accumulation to help determine skating safety conditions.

---


### System Objectives  
- Collect sensor data continuously  
- Process streaming data automatically  
- Store real-time and historical data  
- Display live conditions on a web dashboard  
- Support safety decisions using real-time analytics  

---

## System Architecture  

### Architecture Diagram  
The architecture diagram is located in the following folder:  

### Data Flow Explanation  
1. Sensor simulator sends telemetry to Azure IoT Hub  
2. IoT Hub forwards data to Azure Stream Analytics  
3. Stream Analytics aggregates data every 5 minutes  
4. Aggregated data is stored in:
   - Azure Cosmos DB for real-time access
   - Azure Blob Storage for historical storage
5. The Web Dashboard fetches live data from Cosmos DB  

### Azure Services Used  
- Azure IoT Hub  
- Azure Stream Analytics  
- Azure Cosmos DB  
- Azure Blob Storage  
- Azure Storage Account  


---

## Implementation Overview  

### IoT Sensor Simulation  
A Python-based simulator generates random sensor readings for three locations (Dows Lake, Fifth Avenue, NAC) and sends the data to Azure IoT Hub.

### Azure IoT Hub Configuration  
The IoT Hub receives all telemetry from the simulated devices and forwards it to the Stream Analytics job using the messaging endpoint.

### Stream Analytics Job  
The Stream Analytics job reads data from IoT Hub, aggregates five-minute windows, assigns a safety status, and outputs to Cosmos DB and Blob Storage.

### Azure Cosmos DB Setup  
Cosmos DB stores live aggregated sensor data for fast access by the web dashboard.  
Database name: RideauCanalDB  
Container name: SensorAggregations  
Partition Key: /location  

### Azure Blob Storage Configuration  
Blob Storage stores historical JSON files of aggregated data.  
Container name: historical-data  

### Web Dashboard  
A Node.js and Express-based dashboard fetches real-time data from Cosmos DB and displays the current conditions for each location.

### Azure App Service Deployment  
The dashboard is deployed to Azure App Service using environment variables for secure database access.

---

## Setup Instructions  

### Prerequisites  
- Azure Subscription  
- Python 3  
- Node.js  
- Git  

### High-Level Setup Steps  
1. Run the sensor simulator  
2. Verify data in IoT Hub  
3. Start the Stream Analytics job  
4. Verify Cosmos DB records  
5. Verify Blob Storage files  
6. Run the dashboard locally  
7. Deploy the dashboard to Azure  

---

## Results and Analysis  

### Sample Outputs  
- Real-time data visible in Cosmos DB  
- Historical JSON files created in Blob Storage  
- Live values displayed on the dashboard  

### System Performance Observations  
- Real-time streaming with low latency  
- Continuous stable data flow  
- Fast query response from Cosmos DB  

---

## Challenges and Solutions  

### Cosmos DB ID Error  
Cause: Missing document ID in Stream Analytics output  
Solution: Added a unique ID using location and timestamp  

### Partition Key Mismatch  
Cause: Container created with the wrong partition key  
Solution: Recreated the container with `/location` as the partition key  

### Dashboard Data Not Loading  
Cause: Incorrect environment variable configuration  
Solution: Corrected `.env` values and restarted the server  

---

## AI Tools Disclosure  
ChatGPT was used for documentation wording, debugging guidance, and error explanation.  
All Azure configuration, coding, and testing were completed manually by me.

---

## References  
- Microsoft Azure IoT Hub Documentation  
- Microsoft Azure Stream Analytics Documentation  
- Azure Cosmos DB Documentation  
- Azure Blob Storage Documentation  
- Node.js Express Documentation  
