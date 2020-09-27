Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A460A27A295
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0T3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0T3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9659C0613CE;
        Sun, 27 Sep 2020 12:29:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so9550838wrt.3;
        Sun, 27 Sep 2020 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAAtSAinEwDD4No76XzUrrz89y+X5YI3Fkp3Qs1EF6A=;
        b=hbvgMZ9dkpTeaVc5x0SjPW7TzrNggvlPmhgOnG5tn1P+we5d6QPlFc+j3/1VysZ9EQ
         itQVPlgShHauuDhLCa4ba6QnClEIqkUdxuR9P9j0aTPkyR7BCqKbb6GqjL140WPeDQG8
         JtPAJBxtLNHk+LJTWELGvpHddzfpXVy4gvDa9+WY6GqeC1DIyJVUonyPYE/Hb45jonvl
         moMG66DTEghDqgNB+Zp+kxWjaJM/tSURPmU00oWqXm3AgwJ+UeVQDjEUuIwPVz5N+EmE
         JOqq56iTaGn3tEVUMpZuF2s7FXut0HXOuyADmAawW3zIdFmYPJvLVbDrKduLjVwi7xfU
         v40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAAtSAinEwDD4No76XzUrrz89y+X5YI3Fkp3Qs1EF6A=;
        b=n+sQ3wbnjGLy9kgTYaLuja7c2a83Kq8U4+H7wuZ0vqCP1KJJZMCzxRt0c3EwFBnC+Z
         pkYd4SkWYDUB9GEA3u+f6JQu9WePpMham9UgDVKBX/P9WeIU5UY8pH8mBkOo0Oess2EY
         v9HYsm7yHuT3M0rXPgSwkUg9WLkNNvR1BMc0MjgAaPYoYA0PJC6Tj9UoOuCQxLsc1xxe
         9o/pNIrpdzhOD6ieAEjoOENeP/sqwOxP/lexa0emXYZ16y8IB8fq/CTJ6G1KE/GPZH5R
         LFHYAv/q+eE1a8Zz3Pqy+/Lc5Kfjzzg0M8PhmGmetqtSFYSW8T5u/YqAvAGPre/pWGP5
         nFpA==
X-Gm-Message-State: AOAM530FsHf6oBoEGLsnkBW9FKrlik6rPU5PnUboAE7ZSFumblvAWaWU
        54jLgZMWIzg6JWcByABqy20=
X-Google-Smtp-Source: ABdhPJy0jlKkB+a7iXNGAIriN8xg5n6aV2MPg6E/rLpY9BkzWV0JjpJGSE0LpFuu38MPFaH6nUPSyQ==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr12159410wrv.229.1601234957454;
        Sun, 27 Sep 2020 12:29:17 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:16 -0700 (PDT)
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
Subject: [PATCH v5 00/20] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Sun, 27 Sep 2020 21:28:52 +0200
Message-Id: <20200927192912.46323-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is exactly the same as v4 but with more details in some commit log
and also device-tree soundcard and DAI node have been merged.

Regards,
Clement

Change since v4;
- add more comment on get_wss() and set_channel_cfg() patch
- merge soundcard and DAI HDMI patches

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
  arm64: dts: allwinner: h6: Add DAI node and soundcard for HDMI

Marcus Cooper (7):
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  arm: dts: sunxi: h3/h5: Add DAI node and soundcard for HDMI
  arm64: dts: allwinner: a64: Add DAI node and soundcard for HDMI
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

