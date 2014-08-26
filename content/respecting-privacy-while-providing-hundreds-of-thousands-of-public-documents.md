Title: Respecting privacy while providing hundreds of thousands of public documents
Date: 2012-01-16T22:13:22
Tags: robots.txt, privacy, practical obscurity, policy, courtlistener.com, courtlistener.com, policy, practical obscurity, privacy, robots.txt
Category: Privacy & Security

At CourtListener, we have always taken privacy very seriously. We [have over 600,000][7] cases currently, most of which are available on Google and other search engines. But in the interest of privacy, we make two broad exceptions to what's available on search engines: 

1. As is stated in our [removal policy][1], if someone gets in touch with us in writing and requests that we block search engines from indexing a document, we generally attempt to do so within a few hours. 
2. If we discover a privacy problem within a case, we proactively block search engines from indexing it. 

Each of these exceptions presents interesting problems. In the case of requests to prevent indexing by search engines, we're often faced with an ethical dilemma, since in many instances, the party making the request is merely displeased that their involvement in the case is easy to discover and/or they are simply embarrassed by their past. In this case, the question we have to ask ourselves is: Where is the balance between the person's right to privacy and the public's need to access court records, and to what extent do changes in [practical obscurity][8] compel action on our behalf? For example, if someone convicted of murder or child molestation is trying to make information about their past harder to discover, how should we weigh the public's interest in easily locating this information via a search engine? In the case of convicted child molesters, we can look to [Megan's law][2] for a public policy stance on the issue, but even that forces us to ask to what extent we should chart our own path, and to what extent we should follow public policy decisions. 

On the opposite end of the spectrum, many of the cases that we block search engines from indexing are asylum cases where a person has lost an attempt to stay in the United States, and been sent back to a country where they feel unsafe. In such cases, it seems clear that it's important to keep the person's name out of search engine results, but still we must ask to what extent do we have an obligation to identify and block such cases from appearing proactively rather than post hoc? 

In both of these scenarios, we have taken a middle ground that we hope strikes a balance between the public's need for court documents and an individual's desire or need for privacy. Instead of either proactively blocking search engines from indexing cases or keeping cases in search results against a party's request, our current policy is to block search engines from indexing a web page as each request comes in. We currently have 190 cases that are blocked from search results, and the number increases regularly. 

Where we do take proactive measures to block cases from search results is where we have discovered unredacted or [improperly redacted][3] social security numbers in a case. Taking a cue from the now-defunct Altlaw, whenever a case is added, we look for character strings that appear to be social security numbers, tax ID numbers or alien ID numbers. If we find any such strings, we replace them with x's, and we try to make sure the unredacted document does not appear in search results outside of CourtListener. 

The methods we have used to block cases from appearing in search results have evolved over time, and I'd like to share what we've learned so others can give us feedback and learn from our experiences. There are five technical measures we use to keep a case out of search results: 

1. robots.txt file 
2. HTML meta noindex tags 
3. HTTP X-Robots-Tag headers 
4. sitemaps.xml files 
5. The webmaster tools provided by the search engines themselves

Each of these deserves a moment of explanation. [robots.txt][4] is a protocol that is respected by all major search engines internationally, and which allows site authors (such as myself) to identify web pages that shouldn't be crawled. Note that I said **crawled** not **indexed**. This is a very important distinction, as I'll explain momentarily. 

HTML meta tags are a tag that you can place into the HTML of a page, and which instructs search engines not to **index** a page. Since this is an HTML format, this method only works on HTML pages. 

HTTP X-Robots-Tag headers are similar to HTML meta tags, but they allow site authors to request that an *item* not be indexed. That item may be an HTML page, but equally, it may be a PDF or even an image that should not searchable. 

Further, we provide an [XML sitemap][5] that search engines can understand, and which tells them about every page on the site that they should crawl and index. 

All of these elements fit together into a complicated melange that has 
absorbed many development hours over the past two years, 
as different search engines interpret these standards in different ways. 

For example, Google and Bing interpret the robots.txt files as blocks to 
their crawlers. This means that web pages listed in robots.txt will not be 
**crawled** by Google or Bing, but that does not mean those pages will not 
be **indexed**. Indeed, if Google or Bing learn of the existence of a web 
page (for example, because another page linked to it), 
then they will include it in [their][6] [indexes][10]. This is true even if 
robots.txt explicitly blocks robots from crawling the page, 
because to include it in their indexes, they don't **have to** crawl it 
&mdash; they just need to know about it! Even your own link to a page is 
sufficient for Google or Bing to know about the page. And what's worse, 
if you have a good URL with descriptive words within it, 
Google or Bing will know the terms in the URLs even when they haven't 
crawled the page. So if your URL is example
.com/private-page-about-michael-jackson, a query for [ Michael Jackson ] 
could certainly bring it up, even if it were never crawled. 

The solution to this is to allow Google and Bing to crawl the pages, but to use noindex meta or HTTP tags. If these are in place, the pages will not appear in the index at all. This sounds paradoxical: to exclude pages from appearing in Google and Bing, you have to allow them to be crawled? [Yes, that's correct][11]. Furthermore, it's theoretically possible that Google or Bing could learn about a page on your site from a link, and then not crawl it immediately or at all. In this case, they will know the URL, but won't know about and X-Robots-Tag headers or meta tags. Thus, they might include the document against your wishes. For this reason, it's important to **include** private pages in your sitemap.xml file, inviting and encouraging Google and Bing to crawl the page specifically so the page can be excluded from their indexes.

Yahoo! uses Bing to power their search engine, and AOL uses Google, so the above strategy applies to them as well.

Other search engines take a different approach to robots.txt. Ask.com, The Internet Archive and the Russian search engine Yandex.ru all respect the robots meta tag, but not the x-robots-tag HTTP header. Thus, for these search engines, the strategy above works for HTML files, but not for any other files. These crawlers therefore need to be blocked from accessing those other files. On the upside, unlike Google and Bing, it appears that these search engines will not show a document in their results if they have not crawled it. Thus, using robots.txt alone should be sufficient.

A third class of search engines support neither the robots HTML meta tag, nor the x-robots-tag HTTP header. These are typically less popular or less mature crawlers, and so they must be blocked using robots.txt. There are two approaches to this. The first is to list blocked pages individually in the robots.txt file, and the second is to simply block these search engines from all access. While it's possible to list each private document in robots.txt, doing so creates a privacy loophole, since it lists all private documents in one place. At CourtListener, therefore, we take a conservative approach, and completely block all search engines that do not support the HTML meta tag or the x-robots-tag HTTP header.

The final action we take when we receive a request that a document on our site stop appearring in search results, is to use the webmaster tools provided by the major search engines<sup>1</sup> to explicitly ask those search engines to exclude the document(s) from their results.

Between these measures, private documents on CourtListener should be removed from all major and minor search engines. Where posssible this strategy takes a very granular approach, and where minor search engines do not support certain standards, we take a conservative approach, blocking them entirely.

**Update, 2012-04-29:** You may also want to look at our [discussion of the impact of putting people's names into your URLs, and the way that affects your sitemap files][12].

<!-- actual footnotes -->
1. We use <a href="http://www.google.com/webmasters/tools">Google's Webmaster 
Tools</a> and <a href="http://www.bing.com/toolbox/webmaster">Bing's 
Webmaster Tools</a>. Before it was merged into Bing's tools, 
we also previously used <a href="http://siteexplorer.search.yahoo
.com/">Yahoo's Site Explorer</a>.

[1]: http://courtlistener.com/removal/ 
[2]: http://en.wikipedia.org/wiki/Megan%27s_Law 
[3]: https://freedom-to-tinker.com/blog/tblee/what-gets-redacted-pacer 
[4]: http://www.robotstxt.org/ 
[5]: http://www.sitemaps.org/protocol.html 
[6]: http://www.youtube.com/watch?v=KBdEwpRQRD0 
[7]: http://courtlistener.com/coverage/ 
[8]: http://scholar.google.com/scholar?hl=en&q=practical+obscurity+privacy
[10]: http://www.bing.com/community/site_blogs/b/webmaster/archive/2009/08/21/prevent-a-bot-from-getting-lost-in-space-sem-101.aspx
[11]: https://support.google.com/webmasters/bin/answer.py?hl=en&answer=93710
[12]: {filename}/further-privacy-protections-at-courtlistener.md
