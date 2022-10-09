import pathlib
import os
import subprocess

DATABASE_FILE = "demo_app.sqlite"
DATABASE_DIR = "instance"

def get_project_location():
    '''Return project location'''
    current_path = pathlib.Path(__file__).parent.resolve()
    parent_path = current_path.parent.absolute()

    return str(parent_path).split("test", maxsplit=1)[0]

def get_database_location():
    '''Return database location'''

    return get_project_location() + f"/{DATABASE_DIR}/{DATABASE_FILE}"


def check_database_exist():
    '''Check if database file exists'''
    database_location = get_database_location()
    database_exists = os.path.exists(database_location)

    return database_exists

def init_database():
    '''Create database file'''
    if check_database_exist() is False:
        subprocess.call(f"cd {get_project_location()} && flask init-db", shell=True)

def remove_database():
    '''Remove database file'''
    database_location = get_database_location()
    database_exists = check_database_exist()
    if database_exists:
        os.remove(database_location)