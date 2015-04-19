# cl-fuseki

Common Lisp library for connecting to SPARQL endpoints.

## Why?

I once had a need for a library which talked to Fuseki, a SPARQL11 endpoint.  Due to some issues we
have added some performance improvements.

## What does it do?

It allows you to connect to SPARQL endpoints and send queries to it.  There is also some support
built in for postponing update requests so they can be bundled together.

## How do I use it?

First, you create a reference to the repository to which we will perform updates.

    (defparameter *repository*
      (make-instance 'fuseki::virtuoso-repository :name "main repository"
                     :server (make-instance 'fuseki::virtuoso-server
                                            :base-url "http://localhost:8890")))

Then we add some prefixes which we'll use.

    (add-prefix "app" "http://mu.semte.ch/app/")
    (add-prefix "mu" "http://mu.semte.ch/vocabulary/")
    (add-prefix "rm" "http://mu.semte.ch/vocabulary/logical-delete/")
    (add-prefix "comment" "http://mu.semte.ch/vocabulary/comments/")
    (add-prefix "commentsResource" "http://mu.semte.ch/app/comments/")

Next we execute our query

    (query *repository*
           (concatenate
            'string
            "SELECT ?id ?content ?date FROM app: WHERE "
            "{ "
            "  GRAPH app: { "
            "    ?page a comment:Comment; "
            "        comment:id ?id; "
            "        comment:content ?content; "
            "        comment:date ?date; "
            "        comment:page <" page ">."
            "    FILTER NOT EXISTS { ?page a rm:removedResource. } "
            "  } "
            "} ORDER BY DESC(?date)"))
                   
The result of which is an array containing jsown objects with `id`, `content` and `date` keys.  The
values of these keys are objects.  The object contains the type and the value of the binding.  More
information may be supplied if the literal was a typed string.  You can distill the content value of
each of these with jsown's filter easily.

    (jsown:filter result map "content" "value")

Given that result contains the result of the previous query, this will yield the values of each
content binding.
