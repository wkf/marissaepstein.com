# requirejs makes life a lot easier when dealing with more than one
# javascript file and any sort of dependencies, and loads faster.

# for more info on require config, see http://requirejs.org/docs/api.html#config
require.config
  paths:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min'
    lodash: '//cdnjs.cloudflare.com/ajax/libs/lodash.js/2.2.1/lodash.min'
    jribbble: '/js/jribbble.min'

require ['jquery', 'lodash'], ($, _) ->
  require ['jribbble'], ->
    $ ->

      navShown     = false
      headerHeight = $('body > header').height() || $('.project-hero').height() || 0
      $nav         = $('body > nav')

      toggleNav    = ->
        $nav.css left: -$(window).scrollLeft()

        navShouldBeShown = $(window).scrollTop() >= headerHeight

        if navShouldBeShown and not navShown
          navShown = true
          $nav.animate({height: "toggle", opacity: "toggle"}, queue: false)
        else if not navShouldBeShown and navShown
          navShown = false
          $nav.animate({height: "toggle", opacity: "toggle"}, queue: false)

      $(window).scroll _.throttle(toggleNav, 10)

      toggleNav()

      $('a[href*=#]:not([href=#])').click (event) ->
        name = $(event.target).attr('href').split('#')[1]

        $('html, body').animate({
          scrollTop: $("a[name='#{name}']").offset().top
        }, 500)
        return false

        $.trim(title).substring(0, 10).split(" ").slice(0, -1).join(" ") + "...";

      onShots = (shots) ->
        $('.shot').each (i, s) ->
          url   = shots[i].html_url
          thumb = shots[i].images.hidpi or shots[i].images.normal or shots[i].images.teaser
          title = $.trim(shots[i].title)

          $('img', s).attr 'src', thumb
          $('h4', s).text title
          $('a', s).attr 'href', url

      $.jribbble.setToken('19a48c8b842f4f1a6c630f0116209cba4b787dc6f42266f7a6fd0301d1610411')
      $.jribbble.users('marstoyship').shots({page: 1, per_page: 6}).then(onShots)

  $('.reveal-more-projects button').click (e) ->
    $('.bottom-6').toggle()
    $('.reveal-more-projects button').hide()
    e.preventDefault()
    false
