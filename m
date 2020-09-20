Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358332716A8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgITSIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgITSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB8C061755;
        Sun, 20 Sep 2020 11:08:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so10343489wmm.2;
        Sun, 20 Sep 2020 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bjJ23k58orvOoas5tPG6uY/RuwdywojuGiQ1D/w8N0=;
        b=qBIfsDYD5/JKsxWIPdRjK+qZ4lFrYBChdA/RnSygqlpfXhw1HjW3puFGenp7FXcDtK
         8JcR32/g9bg8SdZj3ZjbAX3V8338NAH3rcfo7mF3H1MfSfrzpWvUrz7zX0Cb6iXL/7Fp
         0K2KEe0fDMVB89aKvKeR6BCUgzcezJl7hLrdJf/vqMqHs9x4BV0R4zPYxhc2PV+Hg+JX
         wjwWfmKFLir+pZfWdhU55q3kDXFdJr6x8mfovrVQnracYiYAvNTOlpaiAfGG2uZ8JWbd
         6S1ZNmEpOTG4Mj6aeCcNbqIwnDfgvk0bt5qIcQw2w6ygc8spMDo3xRseGKcIbrbTzP0B
         IjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bjJ23k58orvOoas5tPG6uY/RuwdywojuGiQ1D/w8N0=;
        b=SvYv1n7gpTZuQg8sPZxJeUKZKMWBrwvrpQkNcaixqFnLP8cVlO6e+OfOnqmKjDzIqm
         khM8qIb7iNTatZMRQubJnEeco9SWVKSKUJOnyPN0LpXXF/GbSYyoi/izf/rUbPXTopbS
         JjcuuMHQ/qx/1rSWodlMXgzeQ/x7sK1NCmM1/FxIz9vkoybS/lrPu0CfrWa5rXE87ruS
         0lYZQEXM24wZwd8S0HlBQ2R1xoToZ6nmcnRzVNubRC+R1ftFEKMLTQ5lYgEkpdJGhPmV
         D5/BYc5Tjwd6M8MHUwmT3MLH5LlOUQh3HL+9TYs0lj+lXHtaF8zz42MBJyanDxSkX55h
         7Acw==
X-Gm-Message-State: AOAM532tixM7ff/agng6bnyGTvJGr9GW+d7EGvuzULGcOg0MzZFAqGQX
        7h2QiTqh8BZxAzDPtyrt+ZE=
X-Google-Smtp-Source: ABdhPJzzyhYdkmF45p4diU+SwyS9+3TA9fZDgii7v35zNcFgW8gzz9KChmum8XF2qfU/Qw090t4zXw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr25828487wmi.186.1600625282949;
        Sun, 20 Sep 2020 11:08:02 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:01 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 00/19] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Sun, 20 Sep 2020 20:07:39 +0200
Message-Id: <20200920180758.592217-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

New test done by Maxime using TDM show that's LRCK is indeed inverted
so I drop the patch reverted in v2.

And HDMI requires an inverted LRCK so let's readd the frame-inversion
in the device-tree.

I have also added a patch to change set_chan_cfg.

Please note that I can't test TDM and only have a Allwinner H6.
So test and comment on other Allwinner chips are welcome!

Regards,
Clement

Change since v2:
- rebase on next-20200918
- drop revert LRCK polarity patch
- readd simple-audio-card,frame-inversion in dts
- Add patch for changing set_chan_cfg params

Change since v1:
- rebase on next-20200828
- add revert LRCK polarity
- remove all simple-audio-card,frame-inversion in dts
- add Ondrej patches for Orange Pi board
- Add arm64 defconfig patch

Clément Péron (4):
  ASoC: sun4i-i2s: Change set_chan_cfg params
  ASoC: sun4i-i2s: Fix sun8i volatile regs
  arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
  arm64: defconfig: Enable Allwinner i2s driver

Jernej Skrabec (3):
  ASoC: sun4i-i2s: Add support for H6 I2S
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  arm64: dts: allwinner: h6: Add HDMI audio node

Marcus Cooper (9):
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  arm: dts: sunxi: h3/h5: Add DAI node for HDMI
  arm: dts: sunxi: h3/h5: Add HDMI audio
  arm64: dts: allwinner: a64: Add DAI node for HDMI
  arm64: dts: allwinner: a64: Add HDMI audio
  arm: sun8i: h3: Add HDMI audio to Orange Pi 2
  arm: sun8i: h3: Add HDMI audio to Beelink X2
  arm64: dts: allwinner: a64: Add HDMI audio to Pine64

Ondrej Jirman (3):
  arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
  ARM: dts: sun8i-h3: Enable HDMI audio on Orange Pi PC/One
  arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts   |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    |   8 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  33 +++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  34 +++
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   8 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   8 +
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 +++
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 280 ++++++++++++++++--
 14 files changed, 427 insertions(+), 20 deletions(-)

-- 
2.25.1

