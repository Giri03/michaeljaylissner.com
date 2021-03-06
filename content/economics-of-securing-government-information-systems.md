Title: Economics of Securing Government Information Systems: A Case Study
Date: 2009-09-12T13:48:45
Tags: security, https, economics
Category: Tech


Prior to becoming a student at the <a href="http://ischool.berkeley.edu">School of Information</a>, I worked doing systems support for a government database that held hundreds of thousands of records, consisting of social security numbers, addresses, names, DOBs, etc. My job was to help users with any kinds of bugs they found in the system, and to work with the vendor to report and resolve those bugs. Over the years at this job, I spent a good amount of time doing security testing of the system. I found a number of vulnerabilities which I reported to the vendor, and which were quickly fixed. One of them however had been plaguing me from the time I found it, around 2007, until now. This post is the tale of that vulnerability, which I'm proud to say was fixed earlier this week.

The problem that I discovered is a simple one, and is one that is <a href="http://www.hotmail.com" rel="nofollow">widespread</a> <a href="http://www.gmx.com/" rel="nofollow">on</a> <a href="http://webmail.juno.com" rel="nofollow">the</a> <a href="http://registration.excite.com" rel="nofollow">web</a>. Simply put, the web-based system did not use encryption on the log on page, resulting in user names and passwords being sent over the Internet in plain text rather than ciphertext. 

Now, without going into too much detail, this is not necessarily the end of the world. When you use the Internet, the information that transfers between you and websites is split up into packets, and these packets are sent down whatever wire appears to have the least load and the greatest speed. As a result, there is no guarantee all of your information will ever be sent through the same computer, and it's challenging for a hacker to place a computer between you and the website you're using.

Unfortunately though, there are some bottlenecks, and sometimes &mdash; not always &mdash; all of your information *will* pass through the same point between you and the server. Bottlenecks can occur in a number of places, such as:


 - **The web host's computers and wires** &mdash; Unless a custom <a href="http://en.wikipedia.org/wiki/Name_server">DNS server</a> is being used, all the information going to or from the server has to go through some host's computer system. If they are logging the information, and if the login information is sent in plaintext, they will immediately have it.
 - **The fastest route** &mdash; Somewhere between you and the server, there may be one route that is fastest. It's possible that some computer in the middle will in fact be relaying all of the information to and from you and the server. They will, in effect, have all of the needed information to steal your login credentials.
 - **Your network** &mdash; If you're on a home or corporate network, more than likely, there is one or more bottlenecks between you and the Internet. This is a point where your information could be gathered.
 - **The network provider's computers** &mdash; Finally, your information will be passing through the hands of the network providers, so they have a wide scope of opportunities to inspect and analyze your information.


Thus, you might say that it's OK to have an unencrypted login page, if you don't mind having vulnerabilities at both endpoints and all along the middle of the connection.

But I digress and should proceed with the tale. Around 2007, I found this vulnerability and used <a href="http://www.wireshark.org/">Wireshark</a> to demonstrate it to my managers and to the vendor. At that time, it seemed like it would be quickly fixed, and that we could go on with our lives.

Then some time passed, and nothing happened. I reminded a few people, but still nothing. The problem persisted, and I handed off my job to somebody else so that I could go back to school. But even once I was back in school, occasionally something would remind me of the problem, and I'd check to see if it was fixed. But it wasn't. So I reminded my old co-workers that they had a problem (which wasn't my favorite thing to do), and I assumed it would be taken care of. Except it *still* wasn't.

At this point, I had to decide how much of a moral duty I had to get this fixed, since I was unaffiliated with the organization for about a year by that time. Proceeding to bring up this issue meant that I would probably annoy a number of people, and that I would likely damage relationships I had spent years building, but to not bring it up meant that thousands of people's records would continue to be insecure.

With this balance in mind, I decided to contact the vendor about it some more, and to continue contacting him every so often until it was fixed. Ultimately, after an additional three or four months and about five long phone calls it's finally fixed. 

The questions now are, what took so damned long, and what can be done to avoid this in the future? Well, a number of things factored in:

1. **Staff transitions** &mdash; Part-way through this time, I left my job and transitioned to school. While I did mention this problem to my replacement, I also mentioned about 500 other things. Sadly, this one may not have caught his attention, or I did not emphasize it enough.
1. **Lack of security personnel** &mdash; Nowhere in either organizations was there a person that was designated to discover and push security problems.
1. **Vagueness of the problem** &mdash; I was able to demonstrate the problem to my superiors and to the vendor, and to explain how it could be a problem, but it wasn't a smoking gun. There had been no security failure, nor was there any obvious thing that an average user could exploit.
1. **Competing projects** &mdash; At the time I discovered the problem, there were many other competing projects that were on the table. To push them aside to fix a vague and unexploited problem did not seem like a good use of resources.
1. **Relationship maintenance and imbalances** &mdash; In 2007, when I reported this, I was not a part of the senior management, and did not have a strong relationship with the vendor. Conversely, my bosses *did* have a relationship with the vendor, but they might not have wanted to jeopardize it by pressuring the vendor to fix a security problem.
1. **Vague economic incentives** &mdash; With this 
vulnerability, it was unclear if anybody would ever know if a hacker had 
been logging into the system and collecting information. If one had, 
it's vague where the burden of the problem would fall. It's not certain 
whether it would fall on my organization or the vendor. And anyway, 
because <a href="http://www.hhs.gov/ocr/privacy/">HIPAA</a>
is so massive, and because there are many other laws that come into play 
(such as the <a href="http://www.dmv.ca.gov/pubs/vctop/appndxa/civil/civ1798_82.htm" 
target="_blank">data breach laws of CA</a>), it's unclear what exactly they
  would have to to as a result.

Some things did not factor in that one might expect to be relevant:

 - Everybody wanted to fix it. Nobody thought it shouldn't be fixed or that it shouldn't be prioritized.
 - Nobody dropped the ball and didn't get it done.
 - There were no structural impediments to getting it reported to the proper people.
 - It wasn't a complicated or difficult thing to fix.
 - It wasn't a trivial problem, nor one that was difficult to exploit.

In sum therefore, it appears that it was economic, social and personnel challenges that caused this to take so long to be fixed. So what can we do to fix these types of problems? A number of things come to mind:

1. **Full-time security personnel** &mdash; The most important thing for one of the organizations to do is to hire somebody to complete regular security audits. This person needs to be hired full time so that they understand the complexity of the problems, and so they can be there to push the solutions forward until things are fixed.
1. **Clarity of economic burden** &mdash; With so much information being stored in the system, it should be made explicit to both parties what the plan is in case of a data loss, and where the burden lies in that event.
1. **Shared bug reporting** &mdash; Currently, there are about fifteen organizations that use this vendor for their information management, however there is no shared system of bug tracking or reporting. As a result, when security problems are found, organizations have no organized way to share information with each other.  Because each organization has a relationship to maintain with the vendor, none of them want to make the product look bad or vulnerable. This isolates the information, reducing the pressure on the vendor to fix such problems.
1. **Prioritization of security fixes** &mdash; Finally, it's vital that such problems be prioritized so that they do not fall by the wayside, and so that they can all be fixed before they are exploited.
