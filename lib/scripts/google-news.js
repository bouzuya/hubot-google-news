module.exports = function(robot) {
  require('hubot-arm')(robot);
  return robot.respond(/google-news$/i, function(res) {
    var url;
    url = 'https://news.google.co.jp/';
    return res.robot.arm('request')({
      method: 'GET',
      url: url,
      format: 'html'
    }).then(function(r) {
      var articles;
      articles = [];
      r.$('.esc-lead-article-title a.article').each(function() {
        var article, e, href, title;
        e = r.$(this);
        href = e.attr('href');
        title = e.text();
        article = "" + title + " " + href;
        return articles.push(article);
      });
      return res.send(articles.filter(function(item, i) {
        return i < 10;
      }).join('\n'));
    });
  });
};
