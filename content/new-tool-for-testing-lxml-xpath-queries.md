Title: New tool for testing lxml XPath queries
Date: 2012-05-20T15:48:06
Tags: Python, lxml, juriscraper, courtlistener.com
Category: Tech

I got a bit frustrated today, and decided that I should build a tool to fix my frustration. The problem was that we're using a lot of XPath queries to scrape various court websites, but there was no tool that could be used to test xpath expressions efficiently.

There are a couple tools that are quite similar to what I just built: There's one called Xacobeo, Eclipse has one built in, and even Firebug has a tool that does similar. Unfortunately though, these each operate on a different DOM interpretation than the one that lxml builds. 

So the problem I was running into was that while these tools helped, I consistently had the problem that when the HTML got nasty, they'd start falling over. 

No more! Today I built [a quick Django app][1] that can be run locally or on a server. It's quite simple. You input some HTML and an XPath expression, and it will tell you the matches for that expression. It has syntax highlighting, and a few other tricks up its sleeve, but it's pretty basic on the whole.

I'd love to get any feedback I can about this. It's probably still got some bugs, but it's small enough that they should be quite easy to stamp out.

**Update:** I got in touch with the developer of Xacobeo. There's an --html flag that you can pass to it at startup, if that's your intention. If you use that, it indeed uses the same DOM parser that my tool does. Sigh. Affordances are important, especially in a GUI-based tool.

[1]: https://bitbucket.org/mlissner/lxml-xpath-tester/
