@local @local_wunderbyte_table
Feature: Row controls functionality of wunderbyte_table works as expected

  Background:
    Given the following "users" exist:
      | username | firstname | lastname |
      | user1    | Username  | 1        |
      | user2    | Username  | 2        |
      | user3    | Username  | 3        |
      | user4    | Username  | 4        |
      | user5    | Username  | 5        |
      | user6    | Username  | 6        |
      | user7    | Username  | 7        |
      | user8    | Username  | 8        |
      | user9    | Username  | 9        |
      | user10   | Username  | 10       |
      | user11   | Username  | 11       |
      | user12   | Username  | 12       |
      | teacher1 | Teacher   | 1        |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | user1    | C1     | student        |
      | teacher1 | C1     | editingteacher |
    And the following "activities" exist:
      | activity | name       | intro      | course | idnumber |
      | page     | PageName1  | PageDesc1  | C1     | PAGE1    |

  @javascript
  Scenario: Press TriggersNoModal button in the rows on the different tabs of the table
    Given I log in as "admin"
    When I visit "/local/wunderbyte_table/demo.php"
    And I follow "Demo table 1"
    Then I should see "admin" in the "#fa5e95f7721ad449d1cdd30f461d1cec_r1" "css_element"
    And I click on "TriggersNoModal" "link" in the "#fa5e95f7721ad449d1cdd30f461d1cec_r1" "css_element"
    And I wait "1" seconds
    And I should see "Did work" in the "#user-notifications" "css_element"
    And I follow "Demo table 2"
    And I wait "1" seconds
    Then I should see "Course 1" in the "#d82aa03a37e6ab3d58369289ffadc665_r2" "css_element"
    And I click on "TriggersNoModal" "link" in the "#d82aa03a37e6ab3d58369289ffadc665_r2" "css_element"
    And I wait "1" seconds
    And I should see "Did work" in the "#user-notifications" "css_element"

  @javascript
  Scenario: Press TriggersModal button in the rows of the different tables on the different tabs
    Given I log in as "admin"
    When I visit "/local/wunderbyte_table/demo.php"
    And I follow "Demo table 1"
    Then I should see "admin" in the "#fa5e95f7721ad449d1cdd30f461d1cec_r1" "css_element"
    And I click on "TriggersModal" "link" in the "#fa5e95f7721ad449d1cdd30f461d1cec_r1" "css_element"
    And I wait "1" seconds
    And I should see "You are about to treat this rows:" in the ".show .modal-content" "css_element"
    And I should see "admin" in the ".show .modal-content" "css_element"
    And I click on ".show .modal-dialog .modal-footer .btn-primary" "css_element"
    And I wait "1" seconds
    And I should see "Did work" in the "#user-notifications" "css_element"
    And I follow "Demo table 2"
    And I wait "1" seconds
    Then I should see "Course 1" in the "#d82aa03a37e6ab3d58369289ffadc665_r2" "css_element"
    And I click on "TriggersModal" "link" in the "#d82aa03a37e6ab3d58369289ffadc665_r2" "css_element"
    And I should see "You are about to treat this rows:" in the ".show .modal-content" "css_element"
    ## And I should see "Course 1" in the ".show .modal-content" "css_element"
    And I click on ".show .modal-dialog .modal-footer .btn-primary" "css_element"
    And I wait "1" seconds
    And I should see "Did work" in the "#user-notifications" "css_element"

  @javascript
  Scenario: Set checkbox in the rows on the different tabs of the table
    Given I log in as "admin"
    When I visit "/local/wunderbyte_table/demo.php"
    And I follow "Demo table 1"
    Then I should see "admin" in the "#fa5e95f7721ad449d1cdd30f461d1cec_r1" "css_element"
    ##And I set the field with xpath "//*[@id='2']" to "checked"
    And I set the field "row-fa5e95f7721ad449d1cdd30f461d1cec-2" to "checked"
    And I set the field "togglecheckbox-fa5e95f7721ad449d1cdd30f461d1cec-2" to "checked"
    And I wait "1" seconds
    And I should see "checked" in the "#user-notifications" "css_element"
    And I follow "Demo table 2"
    And I wait "2" seconds
    Then I should see "Course 1" in the "#d82aa03a37e6ab3d58369289ffadc665_r2" "css_element"
    ## Only xpath useful because IDs have been changed on each update
    And I set the field with xpath "//*[contains(@id, 'd82aa03a37e6ab3d58369289ffadc665_r2')]//*[contains(@name, 'row-d82aa03a37e6ab3d58369289ffadc665-')]" to "checked"
    And I set the field with xpath "//*[contains(@id, 'd82aa03a37e6ab3d58369289ffadc665_r2')]//*[contains(@name, 'togglecheckbox-d82aa03a37e6ab3d58369289ffadc665-')]" to "checked"
    And I wait "1" seconds
    And I should see "checked" in the "#user-notifications" "css_element"
