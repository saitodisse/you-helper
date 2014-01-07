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
    
    # show all available formats
    bash you-helper.sh G7uztVbg7CQ
    
    or
    # download specific format
    bash you-helper.sh http://www.youtube.com/watch?v=G7uztVbg7CQ 137 140
    
    or
    # download specific format by id
    bash you-helper.sh G7uztVbg7CQ 137 140

    or
    # download better format that can get
    bash you-helper.sh G7uztVbg7CQ 137/136/135 141/140/139
