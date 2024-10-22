# Sarcathon-2024 : Hackathon

## Gettings Started
This contains all of our solution's source code. The project is a mono repo, which means that all of the code is in one repository. This makes managing dependencies and sharing code between different project parts easier.

<hr>

## See Demo
Explore the `./Demo` folder for a preview of the solution in action. We recommend watching the demo once to better understand the project's workflows and features.

<hr>

## Directory Structure

```bash
sarcathon-2024/
│
├── Demo/                     # Demo files showcasing the project
│   ├── demo_video.mp4
│   └── demo_images/
│
│
├── src/
│   ├── client/                # Frontend Flutter application
│   └── server/                # Backend Django application
│
├── Presentation.pptx          # Presentation of our Solution
├── test/                      # Contains larger datasets and tests to
│                              # test the performance of the system
│
├── Dockerfile                 # Dockerfile for containerizing the project
├── README.md                  # Project overview and setup instructions
└── .gitignore                 # Files and directories to ignore in Git

```

<hr>

## How to Run this yourself (locally)

Clone the repository onto your local machine
```bash
git clone https://github.com/sudo-boo/sarcathon-2024.git
```
### Frontend
**Android**: Just install the `.apk` file provided in the Releases section of the repository. Otherwise, you can follow the same steps given below to build and install it for Android too.

**iOS**: If you want to test it for iOS, `cd` to the client source code folder
```bash
cd sarcathon-2024/src/client/
```
Connect your iPhone or iOS emulator, build and install it using
```flutter
flutter install
```
> Note: The server address by default is set to `localhost:8000`. You might want to change that and rebuild.


<be>

### Backend
To run the backend, `cd` to the server source code folder
```bash
cd sarcathon-2024/src/server/
```
Create a virtual environment and turn it on
```python
python -m venv .
./Scripts/activate
```
Now install all the dependencies using pip. (You just have to do these steps only for the first time)
```pip
pip install -r requirements.txt
```

Run the server
```python
python -m makemigrations
python -m migrate
python -m runserver
```

<!--## Client
The client application is written in **Flutter** 
It is chosen considering:
- Cross-platform compatibility (iOS, Android, Web, and Desktop).
- Ease of deployment and streamlined development across multiple environments.

## Backend
This section contains the code for the API backend, which is built with the **Django REST Framework** and the **SQLite3** database. This ensures a lightweight and efficient solution for handling data.

## Docker
**Dockerfile** to provide the setup to containerize each service. These ensure consistent and reproducible environments, simplifying the deployment process across platforms.

## Kubernetes
The k8s directory contains **Kubernetes** configuration files that are used to deploy the application to a Kubernetes cluster. -->

