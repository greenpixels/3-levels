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

extends HTTPRequest

func _ready():
	var _is_ok : bool = request("https://raw.githubusercontent.com/greenpixels/3Levels/main/highscores.json", ["content-type: application/json"]);
	
