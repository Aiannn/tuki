# Tuki the Game

## 1. Overview

Tuki the Game is a 2D endless runner built with Flutter for mobile devices (iOS/Android). The game mechanics combine elements of Flappy Bird and Hill Climb Racing. The main character, **Tuki**, automatically moves forward while carrying a **stack of boxes** on his shoulders. The player must balance the stack by tapping the screen to prevent it from tipping over.

## 2. Core Mechanics

- **Character Movement:**

  - Tuki moves automatically from **left to right**.
  - The **stack of boxes** tilts automatically **counterclockwise**.
  - The player must **tap the screen** to tilt the stack **clockwise** and maintain balance.

- **Terrain Influence:**

  - **Uphill:** The stack tilts more **counterclockwise**.
  - **Downhill:** The stack tilts **clockwise** at a slower rate.
  - Terrain is randomly generated within predefined limits.

- **Game Over Condition:**
  - If the stack tilts beyond a certain **critical angle**, the game ends.

## 3. Score System

- Score is based on:
  - **Time survived**.
  - **How long the player keeps the stack near the critical angle**.
  - These parameters should be adjustable for fine-tuning.

## 4. Technologies & Tools

- **Flutter** (for cross-platform mobile development)
- **Flame Engine** (game engine for Flutter)
- **Forge2D** (for physics, terrain generation)

## 5. Game Architecture

The game will be structured into the following core components:

1. **Tuki (Character Class):** Handles movement.
2. **Stack (Box Stack Class):** Controls box balancing physics.
3. **Terrain (Landscape Class):** Manages terrain generation and physics.
4. **ScoreCounter:** Manages the scoring system.

## 6. Development Approach (Scrum)

To structure development and avoid stress, we will follow an **Agile/Scrum** approach with user stories and spikes.

### **User Stories**

#### **Sprint 1: Core Mechanics & Physics**

1. _As a player, I want Tuki to move automatically from left to right so that I don’t have to control movement._
2. _As a player, I want the stack of boxes to tilt automatically so that I must focus on balancing them._
3. _As a player, I want to tap the screen to adjust the tilt of the stack so that I can maintain balance._
4. _As a developer, I want to create a test level with static terrain to verify movement and balance mechanics._
   4.1 _As s a player, I want to have critical value of boxes stack tilting angle, so if tilting exceeds critical angle game over. And user have to click to start game again._

#### **Sprint 2: Terrain & Randomization**

5. _As a player, I want the terrain to be dynamically generated so that each game session is unique._
6. _As a player, I want different slopes (uphill, downhill) to affect balance difficulty so that the game is more challenging._
7. _As a developer, I want to fine-tune the terrain generation parameters to keep gameplay balanced._

#### **Sprint 3: Score System & UI**

8. _As a player, I want to earn points based on survival time so that I am rewarded for lasting longer._
9. _As a player, I want additional points for keeping the stack close to the critical angle so that balance matters._
10. _As a player, I want to see my score on the screen during gameplay._
11. _As a developer, I want to allow score-related parameters to be adjustable for future tuning._

#### **Sprint 4: Game Over & Polish**

12. _As a player, I want the game to end when the stack tilts too much so that I have a clear failure condition._
13. _As a player, I want a Game Over screen that shows my final score._
14. _As a developer, I want to add animations and visual effects for feedback._

### **Spikes (Research Tasks)**

- Research best physics implementation for balancing mechanics.
- Experiment with different terrain generation algorithms in Forge2D.
- Optimize tap responsiveness for mobile controls.

## 7. Goals & Timeline

- **Week 1-2:** Implement movement and basic physics.
- **Week 3-4:** Add terrain generation and difficulty scaling.
- **Week 5-6:** Implement scoring and UI elements.
- **Week 7-8:** Polish animations, optimize performance, and refine gameplay balance.

By following this structured plan, we aim to complete development in **1-2 months** with an iterative, stress-free approach.

## IMPORTANT

### As I am close to end developing the game, I modified already existing sprints and user stories. NOW I ORGANIZED IT THIS WAY:

#### Sprint 1: Core Functionality and Alignment

##### User Story 1: Align Body and Sprite Components

###### Objective: Ensure Tuki's physics body and sprite are perfectly aligned in both size and position.

1. Adjust the physics body's dimensions to match the sprite's size.
2. Set both components' anchors to Anchor.center for consistent alignment.
3. Implement a debug toggle to visualize the physics body during development.

##### User Story 2: Implement Terrain and Background Movement

###### Objective: Create the illusion of Tuki moving by animating the terrain and background.

1. Develop a system to move terrain and background layers leftward at a consistent speed.
2. Synchronize the movement speeds of terrain and background to maintain visual coherence.
3. Ensure Tuki remains stationary horizontally while the environment moves.

##### User Story 3: Procedural Terrain Generation

###### Objective: Generate terrain dynamically to provide an endless path for Tuki.

1. Initialize a set number of terrain chunks at game start.
2. Implement logic to generate new terrain chunks as Tuki progresses.
3. Remove off-screen terrain chunks to optimize performance.
4. Ensure seamless connection between terrain chunks for a continuous experience.

#### Sprint 2: Advanced Mechanics and Enhancements

##### User Story 4: Dynamic Stack Tilting Based on Terrain Slope

###### Objective: Adjust the tilt of Tuki's stack of boxes based on the terrain's slope.

1. Detect the slope of the terrain beneath Tuki using raycasting.
2. Modify the stack's tilt angle proportionally to the detected slope.
3. Introduce variables to control the sensitivity and direction of the tilt for fine-tuning.

##### User Story 5: Optimize Performance and Resource Management

###### Objective: Ensure smooth gameplay by managing resources efficiently.

1. Implement object pooling for terrain chunks to reduce instantiation overhead.
2. Optimize rendering by culling off-screen elements.
3. Profile the game to identify and address performance bottlenecks.

#### Spikes

##### Spike 1: Evaluate Terrain Generation Techniques

###### Objective: Research and select the most suitable method for procedural terrain generation.

1. Compare noise functions (e.g., Perlin, Simplex) for terrain generation.
2. Assess the impact of different generation techniques on performance and visual appeal.

##### Spike 2: Investigate Physics Engine Capabilities

###### Objective: Understand the physics engine's features to better implement stack tilting.

1. Explore the physics engine's support for compound bodies and joints.
2. Determine the best approach to simulate realistic tilting behavior.
