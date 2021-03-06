Title: Rid Thyself of Autocomplete=Off in Firefox
Date: 2009-10-28T09:39:19
Tags: firefox, frustration, autocomplete
Category: Tech

**Update, 12-15-09:** See [this script][1] for an automated way to apply 
this change.

If you're at all like me, you use a password manager to keep track of all 
your passwords, and it works great. Most of the time. Except sometimes, 
it doesn't work, and you're confused why. Well, more often than not, 
it's because your password manager has been blocked by the web page you're 
viewing.

If you look closely at the code of the page, somewhere in it, 
you'll probably find something that looks like this:

    :::html
    <input class="button" type="submit"  name="login" value="login" autocomplete="off">


That autocomplete parameter that you see at the end there? Yeah, 
that's the one that's blocking your password manager. So we must block it, 
so it doesn't block us.

There's a couple approaches to this, but probably the best is to disable 
Firefox's ability to interpret autocomplete. The way to do this on Linux is
to browse to:

    :::txt
    /usr/lib/xulrunner-1.9.1.5/components/nsLoginManager.js


And in Windows, I believe it's at:

    :::txt
    C:\Program Files\Mozilla Firefox\nsLoginManager.js


Once you've found that file, open it in an editor, and find the section 
that has `isAutoCompleteDisabled`, and make it look like this (so it will 
always return FALSE):

    :::javascript
    /*
     * _isAutoCompleteDisabled
     *
     * Returns true if the page requests autocomplete be disabled for the
     * specified form input.
     */
     _isAutocompleteDisabled :  function (element) {
     //        if (element && element.hasAttribute("autocomplete") &&
     //            element.getAttribute("autocomplete").toLowerCase() == "off")
     //            return true;

     return false;
     },

Once that's done, save the file, restart Firefox and you're all set.

[1]: {filename}/script-to-rid-thyself-of-autocomplete-in-firefox.md
