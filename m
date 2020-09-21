Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC432720E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIUK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCFC061755;
        Mon, 21 Sep 2020 03:27:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so12064112wmm.2;
        Mon, 21 Sep 2020 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2WLEdeeGcltAWo8WKHO00MVpZ/wRFMHljgIRKBGWy4=;
        b=Iz+Z733TJ1+3EQ02j3WYFm6pns0QaBjrQebc820NfBFhOCixG28nAEyxfY87Z2y+VY
         VHkmUoAEt3oGiaGtiPPKwRVEjQJuWRg/S3TcfRXAFkR7yFeZbSNzPHhS5g65WFK7dDXs
         bQPtHUg1KJo3xt3jkyWiIDMEcBO5RyHNQA3EOEpEwviaUDqJ3cqDHcOHzbESinW4JV2b
         BZUYom/D+V4v1i7yBtCWIOhcEURWhgcVkOwtDIVOzIuPSd9yPhIplpYPxBMTkgdVDsuB
         2wzvcQ34rm2vtfsfaZytDRTgyBjJ3QhmlVXtmi5CCL5/xOv7Wo49+qfQupsJavqEDGG2
         RENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2WLEdeeGcltAWo8WKHO00MVpZ/wRFMHljgIRKBGWy4=;
        b=mFwklvAKmHsS7mDkPLi1tOlLzNY2EWtVMw/ArSLbVo39OyyRP5L8qfQHxQzI6gS4jn
         Ato0NhwnlGcl/oRnN4hZHk2mobDx5NCCoC0V9fugraJi+BPFoZmxz1N0ghmF7QAzfUrZ
         j/JhcUSlz9H9LbN01HvCa9dx7PrOdOOO8Qo/nEzYoQu/tMfs76wr4e5mawrBNBU9L+cp
         Qrst832REb0yUj6jlZKZScSQwZOFIzlCwBQNIO+OgpjNtNH/Z7dUeLGP86ivkuiQlk1O
         1Um3MOBwmQwy0TpTg1YjB5vFoOwOtXa/jjX+dP7wNWthfKL+9ZUu38bbH/vgHzwCJzR9
         fBaw==
X-Gm-Message-State: AOAM531z3BihJzMz3sQUqvNyvxZT+vwsE4+XMqwMkuBg4Q+hbhn8ANug
        xglIJzqvE8dHChtsRRdcr3f1UxkpOrfSpTKc
X-Google-Smtp-Source: ABdhPJw0iTYMGy5cZtIp9s0Ds4et/1goix1pDoK1k9qkOojOrT/4rfrt/9Uh470FTX8QZVSXHHZH8A==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr29366124wmh.103.1600684054964;
        Mon, 21 Sep 2020 03:27:34 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:34 -0700 (PDT)
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
Subject: [PATCH v4 00/22] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Mon, 21 Sep 2020 12:27:09 +0200
Message-Id: <20200921102731.747736-1-peron.clem@gmail.com>
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

Change since v3:
- add Samuel Holland patch to reconfigure FIFO_TX_REG when suspend is enabled
- readd inversion to H6 LRCK sun50i_h6_i2s_set_soc_fmt()
- Fix get_wss() for sun4i
- Add a commit to fix checkpatch warning

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

Clément Péron (6):
  ASoC: sun4i-i2s: Change set_chan_cfg() params
  ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
  ASoC: sun4i-i2s: Fix sun8i volatile regs
  arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
  arm64: defconfig: Enable Allwinner i2s driver
  ASoC: sun4i-i2s: fix coding-style for callback definition

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

Samuel Holland (1):
  ASoC: sun4i-i2s: Fix setting of FIFO modes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   2 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts     |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts   |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    |   8 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  33 ++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  34 ++
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   8 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   8 +
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   8 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 ++
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 374 +++++++++++++++---
 14 files changed, 487 insertions(+), 54 deletions(-)

-- 
2.25.1

