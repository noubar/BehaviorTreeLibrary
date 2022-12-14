import os
from robot.libdoc import libdoc

DIRECTORY = "keywords"
DIRECTORY_PATH = "./" + DIRECTORY + "/"
HTML = "keywords.html"
XML = "keywords.xml"

if not os.path.exists(DIRECTORY):
    os.mkdir(DIRECTORY)

libdoc("./src/BehaviorTreeLibrary", DIRECTORY_PATH + HTML)
libdoc("./src/BehaviorTreeLibrary", DIRECTORY_PATH + XML)
