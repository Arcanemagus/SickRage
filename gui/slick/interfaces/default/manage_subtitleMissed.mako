#from sickbeard import subtitles
#import datetime
#import sickbeard
#from sickbeard import common
#set global $title="Episode Overview"
#set global $header="Episode Overview"

#set global $sbPath=".."

#set global $topmenu="manage"#
#import os.path
#include $os.path.join($sickbeard.PROG_DIR, "gui/slick/interfaces/default/inc_top.tmpl")
<div id="content960">
#if $varExists('header')
    <h1 class="header">$header</h1>
#else
    <h1 class="title">$title</h1>
#end if
#if $whichSubs:
#set subsLanguage = $subtitles.fromietf($whichSubs).name if not $whichSubs == 'all' else 'All'
#end if
#if not $whichSubs or ($whichSubs and not $ep_counts):

#if $whichSubs:
<h2>All of your episodes have $subsLanguage subtitles.</h2>
<br />
#end if

<form action="$sbRoot/manage/subtitleMissed" method="get">
Manage episodes without <select name="whichSubs" class="form-control form-control-inline input-sm">
<option value="all">All</option>
#for $sub_lang in [$subtitles.fromietf(x) for x in $subtitles.wantedLanguages]:
<option value="$sub_lang.opensubtitles">$sub_lang.name</option>
#end for
</select>
subtitles
<input class="btn" type="submit" value="Manage" />
</form>

#else

<script type="text/javascript" src="$sbRoot/js/manageSubtitleMissed.js?$sbPID"></script>
<input type="hidden" id="selectSubLang" name="selectSubLang" value="$whichSubs" />

<form action="$sbRoot/manage/downloadSubtitleMissed" method="post">
<h2>Episodes without $subsLanguage subtitles.</h2>
<br />
Download missed subtitles for selected episodes <input class="btn btn-inline" type="submit" value="Go" />
<div>
    <button type="button" class="btn btn-xs selectAllShows">Select all</a></button>
    <button type="button" class="btn btn-xs unselectAllShows">Clear all</a></button>
</div>
<br />
<table class="sickbeardTable manageTable" cellspacing="1" border="0" cellpadding="0">
#for $cur_indexer_id in $sorted_show_ids:
 <tr id="$cur_indexer_id">
  <th><input type="checkbox" class="allCheck" id="allCheck-$cur_indexer_id" name="$cur_indexer_id-all" checked="checked" /></th>
  <th colspan="3" style="width: 100%; text-align: left;"><a class="whitelink" href="$sbRoot/home/displayShow?show=$cur_indexer_id">$show_names[$cur_indexer_id]</a> ($ep_counts[$cur_indexer_id]) <input type="button" class="pull-right get_more_eps btn" id="$cur_indexer_id" value="Expand" /></th>
 </tr>
#end for
</table>
</form>

#end if
</div>
#include $os.path.join($sickbeard.PROG_DIR,"gui/slick/interfaces/default/inc_bottom.tmpl")
