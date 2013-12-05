% Python Web Development
% Antoine Pietri & Paul Hervot
% 2013-12-06

# Introduction

## Python Web Development

\begin{center}
\includegraphics[width=9cm]{img/php}
\end{center}

## Introduction

* This is not a tutorial
* There are plenty frameworks and a lot of documentation everywhere on the
  Internet
* More like a global current overview to help someone new to Python Development

# Getting started

## Python

* You will need Python.
* Which version to choose is a very difficult choice.
* Python 3: the future, but made some backwards incompatible changes
* Be sure everything you want to use supports it
* Python 2 is generally the poor but reasonable choice :(

## pip

* For installing Python librairies, use pip
* Package manager for Python libs
* Very handy
* You will use it often to install modules, especially with Django

## virtualenv

* You can install modules in your user home or globally, but that's dirty
* virtualenv is the solution!
* Keep the same environment with the versions of libraries you want

## VCS

* You're of course *planning* to use version control, right?
* Anything is better than nothing

# Framework

## Connect your code to a browser

* This is not PHP
* You can't just drop some files in a folder and tell apache to use them
* That's really a *bad* approach anyway
* You should use a **web framework** that will do a lot of job for you

## Workflow

* Install it
* Generate the boilerplate
* Configure the necessary
* Start a development server
* Code!

## Flask

* Simple
* Extensible
* No boilerplate, works "out of the box"

## Flask example

\begin{minted}{python}

    from flask import Flask
    app = Flask(__name__)

    @app.route("/")
    def hello():
        return "Hello World!"

        if __name__ == "__main__":
            app.run()

\end{minted}
