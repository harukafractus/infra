{ config, pkgs, ... }: {
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        rime
        mozc
      ];
    };
  };
}