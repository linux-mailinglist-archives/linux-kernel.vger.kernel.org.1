Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1C1AF732
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 07:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 01:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgDSFiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:38:24 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584AC061A0C;
        Sat, 18 Apr 2020 22:38:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g10so4755869lfj.13;
        Sat, 18 Apr 2020 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OBR4WRUFWczbdU3xVNyI9eSmEplhWFtGL1aInpJgtYg=;
        b=BOg3j33lf0c1vwAylrk6BloplwvTcJVopaTfJJW8VS7+c3Ci6b7inILZAdbYc5mnk8
         XGtvrM8lmm015naWOdVjMwegO0if7vKhGNYz3whOG600DGl4oWQtBrvIHm+mE2jA8ZE2
         BgHKc+R5aOvXVJj0t63RUZxtkwPAB48izeY3NBFjxJZhL7nkbwc5KUU/1TsaZf40symU
         BEgu6/OEFpF+O38KEuhUNNCSoIreE0SS0KDsrRt1+q6WxbEND4qahP6oyDBTvbuFmxG4
         ACTq34ic/Am83XYTRQG23VNELMQJvHTEQrSP2LH51A9+st+NPGy9MuO0uyxJxIorGZz8
         LjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OBR4WRUFWczbdU3xVNyI9eSmEplhWFtGL1aInpJgtYg=;
        b=i1gGk22FLW0suj+vJHA8FGbCKa5nruQBCl/tf16E1aj+RfnOK2ZFtQrkEQq8v9iYPs
         9GZdDMpK436oqnkSo7K413GxKAxR88b2QIyJJIIFoeicKNlGYd2RAr30DzzmFfkRVbhS
         5mCpiEDhKB6xALaup2n+cmhVOVoNox4OWFNMAMZQ+AZQDImLaGo4k0G0kwL6Aw0sfDw0
         mbpOHy8PNRmXB3Fyvdp0dYLo4wM4M2iZdZSK10ZVDN0u8ULBRxWnaf5GoHHFudpjESTS
         an3+eiLMhlejUaPG2jCrqBX0EoYKNWB+4k7MhY12GUKPBfQXAq7MmYOyEILNxcp06FRF
         ZuPg==
X-Gm-Message-State: AGi0PuZgFWee/Vo4Ht1/3AwBqW0PMuzd90HwxM9DS9WipBPlWMegkSVe
        5eoSGrHrKWI6BJt8YQI3uQ4=
X-Google-Smtp-Source: APiQypLzklkGqk/+BSxL5MA3tlAC2LLW/5YlG90c6OQMMnWUKLZmZTC7oeElzqGG73Y6/Zw9AmOLtw==
X-Received: by 2002:a05:6512:242:: with SMTP id b2mr6816508lfo.92.1587274701603;
        Sat, 18 Apr 2020 22:38:21 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r23sm20416619ljh.34.2020.04.18.22.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:38:21 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/5] arm64: dts: meson: Simplify G12/SM1 Audio Configs
Date:   Sun, 19 Apr 2020 05:38:10 +0000
Message-Id: <20200419053815.15731-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series creates two new dtsi with the HDMI and HDMI+S/PDIF audio configs
used in most G12/SM1 Android box devices and some SBC's and switches most dts
to use them. I have not touched the SEI510/610 which have extra hardware
in their dts, and the U200 which does not currently have audio support, but
will likely receive an 'all possible routings' master config when Jerome
sends his next set of changes (looking at his WIP branch) so I leave U200
for him to address later.

One advantaage of common configs is that distros that need to embed alsa
conf files as part of their userspace support now only need to include two
confs that will automatically support more boards and boxes as they are
added, instead of needing to track and add confs or card aliases for every
new device.

Christian Hewitt (5):
  arm64: dts: meson: create common hdmi/hdmi-spdif audio dtsi
  arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
  arm64: dts: meson: convert odroid-n2 to hdmi dtsi
  arm64: dts: meson: convert khadas-vim3/vim3l to hdmi dtsi
  arm64: dts: meson: convert x96max to hdmi dtsi

 .../amlogic/meson-g12-audio-hdmi-spdif.dtsi   | 139 +++++
 .../dts/amlogic/meson-g12-audio-hdmi.dtsi     |  96 ++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 131 +----
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  85 ---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  89 +--
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 541 +-----------------
 .../boot/dts/amlogic/meson-g12b-w400.dtsi     | 423 ++++++++++++++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |   1 +
 8 files changed, 663 insertions(+), 842 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi-spdif.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-audio-hdmi.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi

-- 
2.17.1

