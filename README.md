you-helper
==========

merges dash video and audio


* script forked from: http://www.youtube.com/watch?v=G7uztVbg7CQ
* video and audio merge tip from: http://blog.nightlyart.com/130


First install youtube-dl

    sudo curl https://yt-dl.org/downloads/2014.01.05.6/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+x /usr/local/bin/youtube-dl

Install MP4Box
    
    sudo apt-get install gpac

Usage:
    
    bash you-helper.sh G7uztVbg7CQ
    
    or
    bash you-helper.sh http://www.youtube.com/watch?v=G7uztVbg7CQ 137 140
    
    or
    bash you-helper.sh G7uztVbg7CQ 137 140
