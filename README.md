## Summary

Probably shell scripting, and Bash in particular, could be difficult for those kind of programmers who don't use it in their daily work.
Before I dived in into this area due to necessity for our Linux project I was able to write something in Bash only by using tutorials and examples.

Despite of the fact that it's an old language and the obvious question may be "why do I need to be proficient with Bash?" it turns out that it's absolutely necessary for those engineers who develops for Linux platforms.

Scripting in bash has a lot of caveats. 
So in this repository I'm going to collect all what I learned from my own mistakes while becoming familiar Bash.

## General guidelines

* Keep your script well structured. The main logic should be easily localized and all auxiliary stuff should be in separate functions placed locally or included from other scripts.

* Use lowercase for your own variables - don't let them override system variables (don't try to define your variable as *PATH* for instance)

* If your script accepts more than one argument provide ability to pass it via options (see *example*). This approach allows you to explicitly control what you pass as an arguments and there would be no necessity to know about required order of arguments. It's acceptable to use *positional arguments* only inside internal functions of a script.

* Be careful with processing boolean conditions. There are distinctions between using a boolean variable in the *if/else* statement and using for instance a result of comparison between 2 strings (**give an example**).
