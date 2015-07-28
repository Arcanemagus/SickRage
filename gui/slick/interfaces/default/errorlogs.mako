#import sickbeard
#from sickbeard import classes
#from sickbeard.common import *
#set global $header="Logs &amp; Errors"
#set global $title="Logs &amp; Errors"

#set global $sbPath = ".."

#set global $topmenu="errorlogs"#
#import os.path
#include $os.path.join($sickbeard.PROG_DIR, "gui/slick/interfaces/default/inc_top.tmpl")
#if $varExists('header')
    <h1 class="header">$header</h1>
#else
    <h1 class="title">$title</h1>
#end if
<div class="align-left"><pre>
#if $classes.ErrorViewer.errors:
    #for $curError in sorted($classes.ErrorViewer.errors, key=lambda error: error.time, reverse=True)[:500]:
        #filter WebSafe
$curError.time $curError.message
        #end filter
    #end for
#end if
</pre>
</div>

<script type="text/javascript" charset="utf-8">
<!--
window.setInterval( "location.reload(true)", 600000); // Refresh every 10 minutes
//-->
</script>

#include $os.path.join($sickbeard.PROG_DIR,"gui/slick/interfaces/default/inc_bottom.tmpl")
