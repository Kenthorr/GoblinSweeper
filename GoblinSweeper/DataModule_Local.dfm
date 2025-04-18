object DMLocal: TDMLocal
  Height = 480
  Width = 980
  object MediaPlayerPelle: TMediaPlayer
    Left = 68
    Top = 56
  end
  object MediaPlayerAmbiance: TMediaPlayer
    Left = 188
    Top = 56
  end
  object MediaPlayerCriGoblin: TMediaPlayer
    Left = 316
    Top = 56
  end
  object TimerAmbiance: TTimer
    Enabled = False
    OnTimer = TimerAmbianceTimer
    Left = 304
    Top = 224
  end
  object MediaPlayerFeuArtifice: TMediaPlayer
    Left = 460
    Top = 56
  end
  object TimerFeuArtifice: TTimer
    Enabled = False
    OnTimer = TimerFeuArtificeTimer
    Left = 456
    Top = 224
  end
  object MediaPlayerDrapeau: TMediaPlayer
    Left = 68
    Top = 136
  end
end
