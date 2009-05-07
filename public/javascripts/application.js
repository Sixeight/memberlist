
$(function() {
    $('table#list tr.member:odd').addClass('odd');
    $('.submit').click(function () {
      var button = $(this);
      button.hide();
      var values = new Array;
      $('input', button.parent().parent()).each(function() {
        var value = $(this).val();
        if (value == '') { value = '-' }
        values.push(value);
        $(this).val('');
      });
      var id = document.location.toString().replace(/.+\//, '');
      $.post('/add/member/to/' + id,
        { _method: 'put', data: values },
        function () { button.show(); });
      return false;
    });
    $('.delete').click(function() {
      var member = $(this);
      var id = member.attr('id').replace(/member_/, '');
      $.post('/delete/member/' + id,
        { _method: 'delete' },
        function() { member.parent().fadeOut(); });
      return false;
    });
});

