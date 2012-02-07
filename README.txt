My TVDB API classes!

What is it?
This set of classes allows the user to use the website thetvdb.com and its API to perform searches for shows in its database and then collect episode information for a certain season and episode number.

Show Search:
This is done using the TVDBShowSearch class and the only input for this is just the show name you would like to search for (i.e. "Peep Show").
This will then use the TVDB API and find all the shows in its database that match the words you typed in.
You are then free to pull out the show information in a number of ways:
• All at once. This returns an NSMutableArray containing all of the shows found. You can then look through these and find the element which is relevant to you. You would normally get the user to select the correct show at this point (if you like).
• Get a specific show. This returns the TVDBShow object that corresponds to the element number that you input.
• Get the first show from the list. This is usually the "top hit" when searching using the TVDB website, so you can be pretty sure that this is the show that you are looking for ;)

Episode Search:
This is done using the TVDBEpisodeSearch class and the inputs for this are:
• The SeriesID for the show you have previously found/
• The season number, and
• The episode number.
This TVDBEpisodeSearch object now contains all the info from the TVDB website for that specific episode. So you can now pull out all the data for it just by asking for it.

Note:
A lot of the methods and classes in this TVDB API are likely to change dramatically as this set of files is still in the pre-version one stage. So, if anything changes please don't cry too much as I warned you guys!

To Do:
• Adding all the fields in the TVDBEpisodeSearch class (as there are some little bits missing!) although some of the ones already missing are probably not needed.
• dealloc methods for all classes and all round better memory management.
• Changing TVDBEpisodeSearch.m/.h to TVDBEpisode as this seems more fitting as they will be holding the episode information.
   ⁃ Also on the other hand, maybe there should be a new class called TVDBEpisode which just holds episode information so that files that already contain information don't lose it when the class is created or whatever.
• Hide away all the parser methods as they are for XML parsing and shouldn't be called by the user of these classes directly.


