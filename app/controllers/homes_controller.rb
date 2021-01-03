class HomesController < ApplicationController
  def top
  end

  def test
    @data = [
      { author: 'Pete Hunt', text: 'This is one comment' },
      { author: 'Jordan Walke', text: 'This is *another* comment' }
    ]
  end

end
