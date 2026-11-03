@echo off
cd /d "%~dp0"
if not exist reports mkdir reports
python monitor.py >> reports\startup.log 2>&1
