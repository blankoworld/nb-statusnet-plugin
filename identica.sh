# identi.ca plugin to display the last status

## LICENCE

# Copyright 2009 by Olivier DOSSMANN (alias Blankoworld)
#
# A copy of this plugin is available at http://github.com/blankoworld/nb-statusnet-plugin

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.If not, see <http://www.gnu.org/licenses/>.

: ${STATUSNET_CMD:=`which curl`}
: ${STATUSNET_OPTS:="-s"}
: ${STATUSNET_USER:="blanko"}
: ${STATUSNET_URL:="https://quitter.se/api/users/show"}
: ${STATUSNET_FORMAT:="xml"}
: ${STATUSNET_TITLE:="quitter.se status"}
: ${STATUSNET_LINK:="https://quitter.se/$STATUSNET_USER"}

if [ "${#STATUSNET_CMD}" -ne 0 ]
then
  STATUSNET_STATUS=`$STATUSNET_CMD $STATUSNET_OPTS $STATUSNET_URL/$STATUSNET_USER.$STATUSNET_FORMAT | grep -E "<text>(.+)</text>" | sed "s/<[/]*text>//g"`
  STATUSNET_BADGE="$STATUSNET_STATUS<br /><a href=\"$STATUSNET_LINK#content\" title=\"Display $STATUSNET_USER StatusNet status\">$STATUSNET_USER</a>"
else
  die "$nb_plugin: $plugins_abort"
fi

## HOWTO by Denis BERNARD

# This plugin displays messages less than 140 characters provided from the microblogging site "identi.ca" .
#
# 1. Put this script inside the directory "plugins"
#
# 2. Enter: "nb -b /path/to/my/nanoblog/plugins configure"
#
# 3. Append lines bellow (uncomment and fill accordingly) to the setting file:
#
	# --- Identi.ca plugin settings ---
	#STATUSNET_CMD="curl" # program used to retrieve identi.ca status 
	#STATUSNET_OPTS="-s" # some options of the STATUSNET_CMD program
	#STATUSNET_URL="https://quitter.se/api/users/show" # url for having the last status
	#STATUSNET_FORMAT="xml" # format used on identi.ca
	#STATUSNET_LINK="https://quitter.se/$STATUSNET_USER"
	#STATUSNET_USER="foo" # your id on identi.ca
	#STATUSNET_TITLE="identi.ca status" # title to display on your homepage (or some else)
#
# 4. Explanations:
#
#  STATUSNET_CMD : command used for retrieving the web page holding your status' information status
#  STATUSNET_OPTS : list of parameters for the command (for example, the "-s" mean silent mode, no output)
#  STATUSNET_URL : address of the page to retrieve
#  STATUSNET_FORMAT : format of the file (could be XML, JSON or others)
#  STATUSNET_LINK : direct link to the page holding your whole status. This is to be displayed.
#  STATUSNET_USER : your nickname over the service called. Here:"foo".
#  STATUSNET_TITLE : title to give to introduce your status on your home's page.
#
# 5. Inside the template: "templates/main_index.htm"
#
# Insert:
#    <div class="sidetitle">                                                                                                       
#      $STATUSNET_TITLE                                                                                                       
#    </div>                                                                                                                        
#    <div class="side">                                                                                                            
#      $STATUSNET_BADGE                                                                                                       
#    </div>
#
# 6. Updating
#
# Your weblog can be update manually by the command "nb update main". But you could do it automatically with cron job:
#         crontab -e
#         00 9    *   *   *    /usr/share/nanoblogger/nb -b /path/to/your/nanoblog/ update main >&/dev/null
#
# 7. Customisation of your badge
#
#    You may want modify your badge, adding some picture or text:
# From the original setting:
#          "STATUSNET_BADGE="$STATUSNET_STATUS<br /><a href=\"$STATUSNET_LINK#content\" title=\"Display $STATUSNET_USER StatusNet status\">$STATUSNET_USER</a>"
# to your own's setting (if your are a french user):
#          "STATUSNET_BADGE="$STATUSNET_STATUS<br /><a href=\"$STATUSNET_LINK#content\" title=\"Visiter la page des status de $STATUSNET_USER\">Voir les autres statuts de $STATUSNET_USER</a>"
# Just add some HTML code inside the variable, and if possible, other variables. And the most important for you: the "STATUSNET_STATUS" variable.


