class DemoController < ApplicationController
  layout false
  def index
  end
  def hello
     @name = params['name']
     @page = params['page']
  end
  def other_hello
     render(:controller=>'demo',:action=>'hello')
  end

  def text_helpers
  end

  def number_helpers
  end

  def escape_output
  end

  def loggin
    logger.debug("this is a debug test")
    logger.info("this is a prodection test with info")
    logger.warn("this is a prodection test with warn")
    logger.error("this is a prodection test with error")
    logger.fatal("this is a prodection test with fatal")
    render(:text => 'looged')
  end
end
