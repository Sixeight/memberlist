
Scenario: Top page
  Feature: Make member list
    Given I am on the homepage
    Then I should see "イベントの名前"
    When I fill in "イベントの名前" with "飲み会"
    And I press "新規作成"
    Then I should be on setting page
    And I should see "飲み会"
    And I should see "リストに必要な情報"

Scenario: Create a new event
  Feature: Setting need column for member info
    Given I create a new event "飲み会"
    When I fill in "リストに必要な情報" with "名前 | 電話番号"
    And I press "確定"
    Then I should see "名前"
    And I should see "電話番号"

