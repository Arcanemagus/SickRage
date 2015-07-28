#import sickbeard
#from sickbeard import classes
#from sickbeard.common import *
#from sickbeard.logger import reverseNames
#set global $header="Log File"
#set global $title="Logs"

#set global $sbPath = ".."

#set global $topmenu="errorlogs"#
#import os.path
#include $os.path.join($sickbeard.PROG_DIR, "gui/slick/interfaces/default/inc_top.tmpl")

<script type="text/javascript" charset="utf-8">
<!--
\$(document).ready(

function(){
    \$('#minLevel,#logFilter,#logSearch').change(function(){
        if ( \$('#logSearch').val().length > 0 ) {
            \$('#logSearch').prop('disabled', true);
            \$('#logFilter option[value=\\<NONE\\>]').prop('selected', true);
            \$('#minLevel option[value=5]').prop('selected', true);
        }
        \$('#minLevel').prop('disabled', true);
        \$('#logFilter').prop('disabled', true);
        \$('#logSearch').prop('disabled', true);
        document.body.style.cursor='wait'
        url = '$sbRoot/errorlogs/viewlog/?minLevel='+\$('select[name=minLevel]').val()+'&logFilter='+\$('select[name=logFilter]').val()+'&logSearch='+\$('#logSearch').val()
        window.location.href = url

    });

    \$(window).load(function(){

        if ( \$('#logSearch').val().length == 0 ) {
            \$('#minLevel').prop('disabled', false);
            \$('#logFilter').prop('disabled', false);
            \$('#logSearch').prop('disabled', false);
        } else {
            \$('#minLevel').prop('disabled', true);
            \$('#logFilter').prop('disabled', true);
            \$('#logSearch').prop('disabled', false);
        }

         document.body.style.cursor='default';
    });

    \$('#logSearch').keyup(function() {
        if ( \$('#logSearch').val().length == 0 ) {
            \$('#logFilter option[value=\\<NONE\\>]').prop('selected', true);
            \$('#minLevel option[value=20]').prop('selected', true);
            \$('#minLevel').prop('disabled', false);
            \$('#logFilter').prop('disabled', false);
            url = '$sbRoot/errorlogs/viewlog/?minLevel='+\$('select[name=minLevel]').val()+'&logFilter='+\$('select[name=logFilter]').val()+'&logSearch='+\$('#logSearch').val()
            window.location.href = url
        } else {
            \$('#minLevel').prop('disabled', true);
            \$('#logFilter').prop('disabled', true);
        }
    });
});
//-->
</script>

#if $varExists('header')
    <h1 class="header">$header</h1>
#else
    <h1 class="title">$title</h1>
#end if

<div class="h2footer pull-right">Minimum logging level to display: <select name="minLevel" id="minLevel" class="form-control form-control-inline input-sm">
#set $levels = $reverseNames.keys()
$levels.sort(lambda x,y: cmp($reverseNames[$x], $reverseNames[$y]))
#for $level in $levels:
    #if not $sickbeard.DEBUG and ($level == 'DEBUG' or $level == 'DB')
        #continue
    #end if
<option value="$reverseNames[$level]" #if $minLevel == $reverseNames[$level] then "selected=\"selected\"" else ""#>$level.title()</option>
#end for
</select>

Filter log by: <select name="logFilter" id="logFilter" class="form-control form-control-inline input-sm">
#for $logNameFilter in sorted($logNameFilters)
<option value="$logNameFilter" #if $logFilter == $logNameFilter then "selected=\"selected\"" else ""#>$logNameFilters[$logNameFilter]</option>
#end for
</select>
Search log by:
<input type="text" name="logSearch" placeholder="clear to reset" id="logSearch" value="#if $logSearch then $logSearch else ""#" class="form-control form-control-inline input-sm" />
</div>
<br />
<div class="align-left"><pre>
#filter WebSafe
$logLines
#end filter
</pre>
</div>
<br />
<script type="text/javascript" charset="utf-8">
<!--
window.setInterval( "location.reload(true)", 600000); // Refresh every 10 minutes
//-->
</script>

#include $os.path.join($sickbeard.PROG_DIR,"gui/slick/interfaces/default/inc_bottom.tmpl")
