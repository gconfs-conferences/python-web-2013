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
* Perfect if you want to tinker

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

## Pyramid

* Well designed and documented
* Minimalist *but* complete
* Again, no boilerplate
* A lot of "add-ons"

## Pyramid example

\tiny{
\begin{minted}{python}

    from wsgiref.simple_server import make_server
    from pyramid.config import Configurator
    from pyramid.response import Response


    def hello_world(request):
        return Response('Hello %(name)s!' % request.matchdict)

    if __name__ == '__main__':
        config = Configurator()
        config.add_route('hello', '/hello/{name}')
        config.add_view(hello_world, route_name='hello')
        app = config.make_wsgi_app()
        server = make_server('0.0.0.0', 8080, app)
        server.serve_forever()

\end{minted}
}

## Bottle

* Similar to flask (maybe simpler)
* Single file, zero dependancies

## Bottle example

\begin{minted}{python}
    from bottle import route, run

    @route('/hello')
    def hello():
        return "Hello World!"

    run(host='localhost', port=8080, debug=True)
\end{minted}

## Django Example

I can't possibly do it justice in one slide, but:

\tiny{
\begin{minted}{python}
    @login_required
    def add_quote(request):
        print type(request.user)
        if request.method == 'POST':
            form = AddQuoteForm(request.POST)
            if form.is_valid():
                cd = form.cleaned_data
                quote = Quote(author=cd['author'], context=cd['context'],
                        content=cd['content'], user=request.user)
                quote.save()
                return HttpResponseRedirect('/add_confirm')
        else:
            form = AddQuoteForm()
        return render(request, 'add.html', {'name_page':
            u'Ajouter une citation', 'add_form': form})
\end{minted}
}

## Others

* web2py
* -Apache's mod\_python-
* Manually (CGI or WSGI)

# Structure

## Routing

* Again, this is not PHP
* You don't just give a bunch of files and let the httpd do the routing
* You can decide exactly where your request is getting routed
* Connecting URLs to a particular piece of code gives you flexibility

## Routing

You can route URLs with special placeholders:

    /users/{name}
    /companies/{id}/products
    /blog/{year:\d\d\d\d}/{month:\d\d}/{day:\d\d}/{title}

* You can attach each of these to a specific function
* _users(name), blog(year, month, day, title)_
* You can have pretty URLs easily
* mod\_rewrite is *not* a routing system

## Request handling

The framework usually give you a **request** interface, which usually includes:

* request.GET, request.POST
* request.cookies
* request.headers
* ...

## Request handling

When you're done, you usually reply with a **response** object (or just
directly the generated HTML)
