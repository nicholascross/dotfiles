Below is a markdown summary you can copy directly into your docs:

# Python Virtual Environment Setup for Pygame Projects

This guide will help you create a virtual environment, upgrade pip, and install Pygame for your Python project.

## 1. Create a Project Folder

```bash
mkdir my_project
cd my_project

2. Create a Virtual Environment

Create the virtual environment in your project folder. Here, we’re naming it venv:

python3 -m venv venv

3. Activate the Virtual Environment

Activate the environment so that all Python commands use this isolated setup:

source venv/bin/activate

Your prompt should now show (venv) indicating the environment is active.

4. Upgrade pip (Optional but Recommended)

Upgrade pip to the latest version:

pip install --upgrade pip

5. Install Pygame

With your virtual environment active, install Pygame:

pip install pygame

6. Deactivate the Virtual Environment

When you’re finished working, deactivate the environment:

deactivate

7. Reactivate the Environment Later

To work on your project again, simply navigate to your project folder and activate the environment:

source venv/bin/activate

This setup keeps your project dependencies isolated from the system Python, ensuring a clean development environment.
