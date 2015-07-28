#import sickbeard
<span id="sampleRootDir"></span>

#if $sickbeard.ROOT_DIRS:
#set $backend_pieces = $sickbeard.ROOT_DIRS.split('|')
#set $backend_default = 'rd-' + $backend_pieces[0]
#set $backend_dirs = $backend_pieces[1:]
#else:
#set $backend_default = ''
#set $backend_dirs = []
#end if

<input type="hidden" id="whichDefaultRootDir" value="$backend_default" />
<div class="rootdir-selectbox">
    <select name="rootDir" id="rootDirs" size="6">
    #for $cur_dir in $backend_dirs:
        <option value="$cur_dir">$cur_dir</option>
    #end for
    </select>
</div>
<div id="rootDirsControls" class="rootdir-controls">
    <input class="btn" type="button" id="addRootDir" value="New" />
    <input class="btn" type="button" id="editRootDir" value="Edit" />
    <input class="btn" type="button" id="deleteRootDir" value="Delete" />
    <input class="btn" type="button" id="defaultRootDir" value="Set as Default *" />
</div>
<input type="text" style="display: none" id="rootDirText" />
