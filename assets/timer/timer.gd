#    <one line to give the program's name and a brief idea of what it does.>
#    Copyright (C) 2022 Sven | greenpixels_
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends RichTextLabel

## Count the timer up and show it in the overlay
func _physics_process(delta):
	Global.time+=delta;
	bbcode_text="[center]%.3f sec/s[/center]" % (Global.time)
