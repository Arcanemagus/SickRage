#import sickbeard
#import datetime
#from sickbeard.common import *
#from sickbeard import sbdatetime, network_timezones
#set global $title = 'Backlog Overview'
#set global $header = 'Backlog Overview'

#set global $sbPath = '..'

#set global $topmenu = 'manage'#
#import os.path
#include $os.path.join($sickbeard.PROG_DIR, 'gui/slick/interfaces/default/inc_top.tmpl')

<script type="text/javascript">
<!--
\$(document).ready(function()
{
    \$('#pickShow').change(function(){
        var id = \$(this).val();
        if (id) {
            \$('html,body').animate({scrollTop: \$('#show-' + id).offset().top -25},'slow');
        }
    });

    #set $fuzzydate = 'airdate'
    #if $sickbeard.FUZZY_DATING:
    fuzzyMoment({
        containerClass : '.${fuzzydate}',
        dateHasTime : false,
        dateFormat : '${sickbeard.DATE_PRESET}',
        timeFormat : '${sickbeard.TIME_PRESET}',
        trimZero : #if $sickbeard.TRIM_ZERO then "true" else "false"#
    });
    #end if

});
//-->
</script>

<div id="content960">

#if $varExists('header')
    <h1 class="header">$header</h1>
#else
    <h1 class="title">$title</h1>
#end if
#set $totalWanted = 0
#set $totalQual = 0

#for $curShow in $sickbeard.showList:
#set $totalWanted = $totalWanted + $showCounts[$curShow.indexerid][$Overview.WANTED]
#set $totalQual = $totalQual + $showCounts[$curShow.indexerid][$Overview.QUAL]
#end for

<div class="h2footer pull-right">
    <span class="listing-key wanted">Wanted: <b>$totalWanted</b></span>
    <span class="listing-key qual">Low Quality: <b>$totalQual</b></span>
</div><br/>

<div class="float-left">
Jump to Show
    <select id="pickShow" class="form-control form-control-inline input-sm">
    #for $curShow in sorted($sickbeard.showList, key = operator.attrgetter('name')):
    #if $showCounts[$curShow.indexerid][$Overview.QUAL] + $showCounts[$curShow.indexerid][$Overview.WANTED] != 0:
    <option value="$curShow.indexerid">$curShow.name</option>
    #end if
    #end for
</select>
</div>

<table class="sickbeardTable" cellspacing="0" border="0" cellpadding="0">

#for $curShow in sorted($sickbeard.showList, key = operator.attrgetter('name')):

#if $showCounts[$curShow.indexerid][$Overview.QUAL] + $showCounts[$curShow.indexerid][$Overview.WANTED] == 0:
#continue
#end if

    <tr class="seasonheader" id="show-$curShow.indexerid">
        <td colspan="3" class="align-left">
            <br/><h2><a href="$sbRoot/home/displayShow?show=$curShow.indexerid">$curShow.name</a></h2>
            <div class="pull-right">
                <span class="listing-key wanted">Wanted: <b>$showCounts[$curShow.indexerid][$Overview.WANTED]</b></span>
                <span class="listing-key qual">Low Quality: <b>$showCounts[$curShow.indexerid][$Overview.QUAL]</b></span>
                <a class="btn btn-inline forceBacklog" href="$sbRoot/manage/backlogShow?indexer_id=$curShow.indexerid"><i class="icon-play-circle icon-white"></i> Force Backlog</a>
            </div>
        </td>
    </tr>

    <tr class="seasoncols"><th>Episode</th><th>Name</th><th class="nowrap">Airdate</th></tr>

#for $curResult in $showSQLResults[$curShow.indexerid]:
    #set $whichStr = $str($curResult['season']) + 'x' + $str($curResult['episode'])
    #try:
        #set $overview = $showCats[$curShow.indexerid][$whichStr]
    #except Exception
        #continue
    #end try

    #if $overview not in ($Overview.QUAL, $Overview.WANTED):
        #continue
    #end if

    <tr class="seasonstyle $Overview.overviewStrings[$showCats[$curShow.indexerid][$whichStr]]">
        <td class="tableleft" align="center">$whichStr</td>
        <td>$curResult["name"]</td>
        <td class="tableright" align="center" class="nowrap"><div class="${fuzzydate}">#if int($curResult['airdate']) == 1 then 'never' else $sbdatetime.sbdatetime.sbfdate($sbdatetime.sbdatetime.convert_to_setting($network_timezones.parse_date_time($curResult['airdate'],$curShow.airs,$curShow.network)))#</div></td>
    </tr>
#end for

#end for

</table>
</div>

#include $os.path.join($sickbeard.PROG_DIR,'gui/slick/interfaces/default/inc_bottom.tmpl')
