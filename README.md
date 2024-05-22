# NutriSAY!

NutriSAY! is a Nutrition Tracking App that uses AI & HealthKit for watchOS. 
Just say what you just eat, and the AI will analyze the nutrition, very detailed, which is every nutrient available in HealthKit. 
You'll never again spend time finding a meal that doesn't exist in the database of other Nutrition Tracking Apps.

## Features

- **Nutrition Tracker**: Displays daily progress bars for calories, protein, and carbohydrates.
- **AI Nutrition Analyzer**: Speak to log meals. The AI will determine the nutrients.
- **Meal History with Detailed Nutrients**: View the history of consumed meals with complete nutrients.
- **HealthKit Integration**: Syncs nutrition data with HealthKit.

## Tech Stack

- **SwiftUI** to build responsive UI
- **SwiftData** for data persistence
- **WatchKit** to build watchOS apps
- **HealthKit** to sync nutrition into iOS and Apple account
- **GitHub** as version control system
- **Dify.ai** and **OpenAI API** to interact with AI LLMs

## Build Configuration

The project includes configurations for both iOS and watchOS targets:

- **NutriSAY**: The main iOS app.
- **NutriSAY Watch App**: The companion watchOS app.

## Dependencies

The project uses the following Swift package:

- **Yams**: A library for parsing and writing YAML.

## Getting Started

### Prerequisites

- Xcode 14.0 or later
- Swift 5.0

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/NutriSAY.git
    cd NutriSAY
    ```

2. Open the project in Xcode:
    ```sh
    open NutriSAY.xcodeproj
    ```

3. Build and run the project on your preferred device or simulator.
