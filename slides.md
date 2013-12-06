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

## Django

* The other extreme
* Really massive
* Designed for CMS-likes or content-rich sites
* Enormous ecosystem of pluggable components
* Built-in everything (templates to ORM)
* Generally considered as the Python equivalent to Ruby on Rails
* Possibly a little heavy for your first attempt though

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

* You can manually edit headers
* You very rarely need to handcraft your request
* For common cases (returning json or xml) every framework has its own shortcut

# Templates

## Introduction

* You don't want to write the HTML in your code (remember, this isn't PHP...)
* A common approach is to use templates

## Template libraries

* Django templates
* Jinja2
* Mako
* Genshi
* Do not use Cheetah.
* Do **NOT** use Cheetah.
* Really. Cheetah is an abomination.

## Template example

\tiny{
\begin{minted}{html}
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
    <html lang="en">
    <head>
        <title>My Webpage</title>
    </head>
    <body>
        <ul id="navigation">
        {% for item in navigation %}
            <li><a href="{{ item.href }}">{{ item.caption }}</a></li>
        {% endfor %}
        </ul>

        <h1>My Webpage</h1>
        {{ a_variable }}
    </body>
    </html>
\end{minted}
}

## Logic in templates

* You will inevitably ask yourself "does this belongs to the template?"
* This has been debated for ages
* Try to minimize how much you'll hate yourself
* Keep complexity out, but don't try to avoid it at any costs
* Maybe your framework is already doing what you want

# Dealing with data

## Unicode

* Dealing with encoding is tedious.
* If you use Python 2, it's even **worse**.
* Before doing anything, learn how unicode is handled in your version of Python
* Good lecture: *The Absolute Minimum Every Software Developer Absolutely,
  Positively Must Know About Unicode and Character Sets*
* **NEVER** solve a Unicode problem by stripping out non-ASCII characters. This
  is just the beginning of the end.

## XSS

* *This is not PHP.*
* Every template framework escapes HTML tags by default
* For the most part, you don't have to worry about XSS
* Sometimes you want to turn it off though
* There are libraries for that (MarkupSafe) used by default in some frameworks

## "Sanitizing"

* This seems to be a common trend for PHP developpers
* We **don't** sanitize
* It makes no sense, you can't make a string "safe"
* Just think about what you're doing and which data you are treating

## Debugging

* All the frameworks have some built-in interactive debugger
* You can directly have a precise stacktrace showing where you code failed, the
  local variables, ...
* Just make sure these informations are not available when you deploy

## Sessions

* Every framework has session support.
* As usual, a session token stored in a cookie and a database of sessions
* You can just magically put some data in a dictionnary provided by the
  framework
* Pyramid and Django include of course a built-in CSRF protection

# Databases

## Overview

* You can use sqlite to debug (simple file but not multiuser)
* When you deploy, give PostgreSQL a try!
* This whole presentation is about doing things right, so don't use MySQL

## Using an ORM

* Using an ORM is really great
* Yes, it can generates bad SQL
* If you need performances for complex tasks, you still can write them manually

## ORM Libraries

* Django has its own, as always
* SQLAlchemy is really complete and nice to use

## ORM example

\begin{minted}{python}

class Quote(models.Model):
    author = models.CharField(max_length=50, verbose_name='auteur')
    context = models.TextField(verbose_name='contexte', blank=True)
    content = models.TextField(verbose_name='contenu')
    date = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(User, null=True, blank=True)
    visible = models.BooleanField(default=False)
    accepted = models.BooleanField(default=False, verbose_name=u'accepté')

\end{minted}

# Deployment

## Overview

* Okay, deployment is not as easy as PHP
* But that's inherently related to the fact that PHP has his stupid FS-based
  routing thing
* Doing things right require a bit more time, but not as much as you'd think
* Having to deploy means you've actually built something useful!

## If you're willing to spend money

* Providing a service inherently has a cost
* Heroku (quality service, but expensive)
* AlwaysData (free plan!)
* Webfaction
* Other free hosts

## On your own server

* There are a lot of ways to deploy, we can't present all here
* mod\_wsgi in Apache works well
* Nginx is great for reverse-proxying
* Use one of many event-driven workers (Tornado, gunicorn, ...)

# Conclusion

## Questions?

* antoine.pietri@epita.fr
* paul.hervot@epita.fr
* \#epita @ irc.rezosup.org
* Slides available soon on http://gconfs.fr/confs

