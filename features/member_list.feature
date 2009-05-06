
Scenario: MemberList
  Feature: Make member list
    Given I am on the homepage
    Then I should see "イベントの名前"
    And I should see "新規作成"
    When I fill in "イベントの名前" with "飲み会"
    And I press "新規作成"
    Then I should be on setting page
    And I should see "飲み会"


  Feature: Setting need column for member info
    Given 
