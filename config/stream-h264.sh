gst-launch-1.0 \
  ximagesrc show-pointer=1 use-damage=0 ! \
    videoscale ! videorate ! video/x-raw,width=1280,height=720,framerate=30/1 ! \
    videoconvert ! queue ! \
    x264enc pass=cbr bitrate=4000 key-int-max=10 tune=zerolatency speed-preset=veryfast ! \
    video/x-h264,profile=baseline ! \
      rtph264pay pt=96 config-interval=1 ! queue ! \
      udpsink host=127.0.0.1 port=5004 \
  pulsesrc device=0 volume=1 ! \
    audioconvert ! audioresample ! queue ! \
    opusenc bitrate=48000 audio-type=generic bandwidth=fullband ! \
      rtpopuspay pt=111 ! queue ! \
      udpsink host=127.0.0.1 port=5002

    # nvh264enc bitrate=4000 rc-mode=cbr preset=low-latency ! \
      
    # openh264enc multi-thread=4 complexity=low bitrate=4000000 max-bitrate=4500000 ! \
      # capssetter caps="application/x-rtp,profile-level-id=(string)42e01f" ! \