{ config, pkgs, ... }: {
  sound.enable = true;                  # Enable sound support
  hardware.pulseaudio.enable = false;   # Disable PulseAudio
  security.rtkit.enable = true;         # Enable RealtimeKit for low-latency audio
  services.pipewire = {
    enable = true;                      # Enable PipeWire
    alsa.enable = true;                 # Enable ALSA support
    alsa.support32Bit = true;           # Enable 32-bit ALSA support
    pulse.enable = true;                # Enable PipeWire PulseAudio compatibility
  };
}
