require "hemi"

class Test01
  prepend Hemi::Engine

  LM     = Hemi::Event::LoopMachine
  Font   = Hemi::Render::Font
  Sprite = Hemi::Render::Sprite

  def run
    LM.register(:text, text_block, text_events)
    LM.register(:image, sprite_block, sprite_events)
  end

  def text_block
    proc {
      Font[:jost_32].render("quick brown fox jumped over the lazy dog", position: [20, 20])
      Font[:jost_16].render("press [space] to change LoopState", position: [20, 400])
      Font[:jost_16].render("press [q] or [esc] to quit", position: [20, 420])
      Font[:jost_16].render("press [F12] to start debug", position: [20, 440])
    }
  end

  def sprite_block
    proc {
      Sprite[:gem].render(position: { y: 220, x: 20 })
      Sprite[:gem].render(position: { y: 320, x: 220 }, size: { height: 64, width: 128 })
      Font[:jost_16].render("press [space] to change LoopState", position: [20, 400])
      Font[:jost_16].render("press [q] or [esc] to quit", position: [20, 420])
      Font[:jost_16].render("press [F12] to start debug", position: [20, 440])
    }
  end

  def text_events
    {
      escape: -> { exit },
      q: -> { exit },
      space: -> { LM.switch(:image) },
      f12: :debug!
    }
  end

  def sprite_events
    {
      escape: -> { exit },
      q: -> { exit },
      space: -> { LM.switch(:text) },
      f12: :debug!
    }
  end
end

Test01.instance.run
