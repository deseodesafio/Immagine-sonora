# Immagine Sonora

## Overview
![preview](https://github.com/deseodesafio/Immagine-sonora/assets/157072886/56071fc1-7d09-4cb5-ad4a-7feb503ecb1c)


Immagine Sonora is a flexible visual system that maps temporal patterns in Spotify music streaming behaviours. It reveals when, throughout the year, people listen to music using real streaming data. While analysing the data gathered from my friends, I identified six distinct listening types: Gewohnheitstier (habitual listener), Taktloser (abrupt changes in their rhythm), Lückenhörer (fragmentary listener), Saisonhörer (seasonal listener), Morgenmelodiker (morning melodies) and Nachtwandler (shapeshifter).
By connecting these patterns to what I knew about their lives, I uncovered intriguing correlations—such as when they met their partners, studied abroad for a semester, or experienced other musical habits that are time-related.
The visualization represents a year as a sequence of days, with each day depicted as a rectangle divided into four color-coded time periods: morning, afternoon, evening, and night. The darker the colour the later in the day it is. The size of each segment is proportionate to the total minutes listened during that time of day. If no music was listened during a day, it remains black. Different listening types are distinguished through different colour combinations. One can see the passing of the years and switch between visualizations showing the year in weeks, months, quarters or all 365 days one below the other. 
This project is developed using Processing, a flexible software sketchbook within the context of the visual arts.


## Prerequisites

Before you start with Immagine Sonora, ensure you have the following prerequisites installed on your system:

- JDK 17: The application is developed in Processing, which requires Java Development Kit (JDK) version 17 to compile and run.

## Installation

Follow these steps to set up Immagine Sonora on your machine:

### Step 1: Install JDK 17

Immagine Sonora requires JDK 17. If you don't have it installed, follow the installation instructions provided in the official documentation: [JDK 17 Installation Guide](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html).

### Step 2: Download Processing

Download the latest version of Processing from the official website: [Processing Download](https://processing.org/download/). Choose the version compatible with your operating system.

### Step 3: Setup Immagine Sonora

1. Clone the Immagine Sonora repository to your local machine:

`git clone https://github.com/yourusername/immagine-sonora.git`

2. Open the Processing IDE and navigate to the directory where you cloned the repository.
3. Open the Immagine Sonora `.pde` file in Processing.

## Usage
You can run the sketch to visualize music listening habits in a visually engaging way. An anonymous data file is provided and automatically loaded in the data folder.
Explore music listening habits across different time frames, such as weeks, quarters, or the entire year. Use the arrow keys to navigate between years (left and right) and control the amount of days displayed (up and down keys) to explore patterns you might not have noticed before. 

---

**Note**: This application is for educational and visualization purposes only. It is not affiliated with Spotify in any official capacity.
