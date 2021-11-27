# Introducing the playlist_creator gem

Usage:

    require 'playlist_creator' 

    s = "
    title: The Christmas Waltz
    location: Disc 3 - 14 - The Christmas Waltz.mp3

    title: We Three Kings
    location: Disc 3 - 23 - We Three Kings.mp3
    "

    pc = PlaylistCreator.new s
    puts pc.to_xspf

<pre>
&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;playlist xmlns="http://xspf.org/ns/0/" version="1"&gt;
  &lt;tracklist&gt;
    &lt;track xmlns=""&gt;
      &lt;title&gt;The Christmas Waltz&lt;/title&gt;
      &lt;location&gt;Disc 3 - 14 - The Christmas Waltz.mp3&lt;/location&gt;
    &lt;/track&gt;
    &lt;track xmlns=""&gt;
      &lt;title&gt;We Three Kings&lt;/title&gt;
      &lt;location&gt;Disc 3 - 23 - We Three Kings.mp3&lt;/location&gt;
    &lt;/track&gt;
  &lt;/tracklist&gt;
&lt;/playlist&gt;
</pre>

## Resources

* playlist_creator https://rubygems.org/gems/playlist_creator

xspf mp3 playlist creator playlist_creator playlistcreator m3u
