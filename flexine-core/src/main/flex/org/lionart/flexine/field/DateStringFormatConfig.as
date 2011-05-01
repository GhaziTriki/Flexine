/*
   Copyright (C) 2011 Ghazi Triki <ghazi.nocturne@gmail.com>

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package org.lionart.flexine.field
{
    import mx.formatters.DateFormatter;
    import mx.resources.ResourceManager;

    /**
     * Configuration information for the {#DATE_STRING} type.
     */
    internal class DateStringFormatConfig
    {
        private var dateFormatStr : String;

        public function DateStringFormatConfig( dateFormatStr : String )
        {
            this.dateFormatStr = dateFormatStr;
        }

        public function getDateFormatter() : DateFormatter
        {
            var dateFormatter : DateFormatter = new DateFormatter();
            if (dateFormatStr == null)
            {
                dateFormatter.formatString = ResourceManager.getInstance().getString("SharedResources", "dateFormat");
            }
            else
            {
                dateFormatter.formatString = dateFormatStr;
            }
            return dateFormatter;
        }

        public function toString() : String
        {
            return dateFormatStr;
        }

    }
}

