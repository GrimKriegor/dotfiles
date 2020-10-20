# vedutils

Simple video editing utilities.

Just a bunch of wrappers for `ffmpeg` that help me edit video super fast and without unecessary re-encoding.

They are also great for automation!

Might polish and move this to a separate repository later on.


## vedclip

Snip clips out of videos

```
vedclip input_file start_time end_time [output_file]
```

 Example:

```
vedclip boring_2h_marathon.mkv 1:24:32 1:24:56 poggers_frag_clip.mkv
```


## vedcat

Concatenate videos

```
vedcat [video_file...]
```

 Example:

```
vedcat intro.mkv content.mkv advertisement.mkv outro.mkv
```

## vedamix

Mix an audio track into an audio/video file

```
vedamix video_file audio_file begining [ending] [audio_volume_percent] [output_file]
```
 Example:

```
vedamix cool_frag_vid.mkv awesome_soundtrack.ogg 0:32 5:45 80 cool_frag_vid_with_music.mkv
```
