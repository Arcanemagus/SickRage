#import sickbeard
#from sickbeard.common import Quality, qualityPresets, qualityPresetStrings

<div class="field-pair">
    <label for="qualityPreset">
#set $overall_quality = $Quality.combineQualities($anyQualities, $bestQualities)
<span class="component-title">Preferred quality of episodes to be download</span>
<span class="component-desc">
#set $selected = None
<select id="qualityPreset" class="form-control form-control-inline input-sm">
<option value="0">Custom</option>
#for $curPreset in sorted($qualityPresets):
<option value="$curPreset" #if $curPreset == $overall_quality then "selected=\"selected\"" else ""# #if $qualityPresetStrings[$curPreset].endswith("0p") then "style=\"padding-left: 15px;\"" else ""#>$qualityPresetStrings[$curPreset]</option>
#end for
</select>
</span>

    </label>
</div>

<div id="customQualityWrapper">
    <div id="customQuality">
        <div class="component-group-desc">
            <p><b>Preferred</b> qualities will replace an <b>Allowed</b> quality if found, initially or in the future, even if it is a lower quality</p>
        </div>

        <div style="padding-right: 40px; text-align: left; float: left;">
            <h5>Allowed</h4>
            #set $anyQualityList = filter(lambda x: x > $Quality.NONE, $Quality.qualityStrings)
            <select id="anyQualities" name="anyQualities" multiple="multiple" size="$len($anyQualityList)" class="form-control form-control-inline input-sm">
            #for $curQuality in sorted($anyQualityList):
                <option value="$curQuality" #if $curQuality in $anyQualities then "selected=\"selected\"" else ""#>$Quality.qualityStrings[$curQuality]</option>
            #end for
            </select>
        </div>

        <div style="text-align: left; float: left;">
            <h5>Preferred</h4>
            #set $bestQualityList = filter(lambda x: x >= $Quality.SDTV and x < $Quality.UNKNOWN, $Quality.qualityStrings)
            <select id="bestQualities" name="bestQualities" multiple="multiple" size="$len($bestQualityList)" class="form-control form-control-inline input-sm">
            #for $curQuality in sorted($bestQualityList):
                <option value="$curQuality" #if $curQuality in $bestQualities then "selected=\"selected\"" else ""#>$Quality.qualityStrings[$curQuality]</option>
            #end for
            </select>
        </div>
    </div>
</div>
