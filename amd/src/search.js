
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/*
 * @package    local_wunderbyte_table
 * @copyright  Wunderbyte GmbH <info@wunderbyte.at>
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

import Templates from 'core/templates';
import {callLoadData} from 'local_wunderbyte_table/init';

import {getFilterObjects} from 'local_wunderbyte_table/filter';
import {getSortSelection} from 'local_wunderbyte_table/sort';

var lastsearchinputs = {};

/**
   * Render the checkboxes for the filer.
   * @param {string} idstring
   */
 export const renderSearchbox = (idstring) => {

    const selector = ".wunderbyte_table_container_" + idstring;
    const container = document.querySelector(selector);
    const searchcontainer = container.querySelector("input.search");

    if (searchcontainer) {
      return;
    }

    Templates.renderForPromise('local_wunderbyte_table/search', []).then(({html}) => {

        container.insertAdjacentHTML('afterbegin', html);

        initializeSearch(selector);

        return;
    }).catch(e => {
        // eslint-disable-next-line no-console
        console.log(e);
    });
};


/**
 * Function to initialize the search after rendering the searchbox.
 * @param {*} containerselector
 * @param {*} idstring
 * @param {*} encodedtable
 * @returns {*}
 */
 export function initializeSearch(containerselector, idstring, encodedtable) {

    const inputElement = document.querySelector(containerselector + ' input.search');

    if (!inputElement) {
        return;
    }

    if (!inputElement.dataset.initialized) {

      inputElement.dataset.initialized = true;

      inputElement.addEventListener('keyup', () => {

        let now = Date.now();

        lastsearchinputs[idstring] = now;

        setTimeout(() => {

          const searchstring = getSearchInput(idstring);

          // If the timevalue after the wait is the same as before, we didn't have another input.
          // we want to make sure we do no loading while we are waiting for the answer.
          // And the iput string must be longr than 3.
          if (lastsearchinputs[idstring] === now
              && searchstring !== null) {

            const filterobjects = getFilterObjects(idstring);
            const sort = getSortSelection(idstring);

            callLoadData(idstring,
              encodedtable,
              0, // We set page to 0 because we need to start the container anew.
              null,
              sort,
              null,
              null,
              null,
              filterobjects,
              searchstring);

          }
        }, 400);

        return;
      });
    }
}

/**
 * Function to read the searchstring from the input leement.
 * @param {*} idstring
 * @returns {null|string}
 */
export function getSearchInput(idstring) {

  const inputElement = document.querySelector(".wunderbyte_table_container_" + idstring + ' input.search');

  if (!inputElement) {
    return null;
  }

    let searchstring = null;

    if (inputElement.value.length > 2
        || inputElement.value.length === 0) {
      searchstring = inputElement.value;
    }

  return searchstring;
}
