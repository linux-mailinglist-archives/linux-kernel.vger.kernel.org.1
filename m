Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4248E29C763
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828401AbgJ0Sb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:31:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828382AbgJ0Sbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:31:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id h5so3035586wrv.7;
        Tue, 27 Oct 2020 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u9KlF+y0OyiuKU/hfbRmYFsG2pmwDPw+7/oznvGoCI=;
        b=m0U8E4Wp1elMN898vGRbZYUMLzVIvaqipR8nK3gm1Rhe0PoQYdzIdFKES2aKPmfomS
         g1mQok3PsCL3QHSxuRwKpkT0FMcH2a8HZ1N+DPa3HSi6uVLfDJHTKPB53xgIUPcsONep
         iTzqk3VldAw85kFIAt8iVoees6SdZJ13xVwerq87YuQzjYRs/4vSQ77M6yLBKeLoiAOm
         T7foIBbIpnyG8kyud3+wyK23iK1GE7CmdvcKUOtO2bYNxiu7klW0tpkDNHj12HUCP1rh
         sopLKCf2vcZ9CGYegRdvT+8QQwfAYVy54vk/TMZ581Q/1nOufN13nkh6wHriNx8lVQ2P
         cKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7u9KlF+y0OyiuKU/hfbRmYFsG2pmwDPw+7/oznvGoCI=;
        b=AR6pXeDQsCxNXRUGysV5XktY3EDOC92BbD/iPoFkEHOhz5WUJjdVCNt0PYaHUMKIZ8
         Q4pifXHJFia8vJyCMpo6V0DSyiXAIFk4bKVM0Mlgs4JJNGosaGuKk9ysaZPmUMLqWahu
         AaLfEduB07PWbWYZGWSacXaf0HaVRbGIXByVSbwmbhqwgbJc/KLsS54CZV8K5YpoglBa
         MTqCC7/bwOsqpzZewBiTOFZOxMi933S9++jsAkyU3PELVswGMPZCVTu0OYeqQHNOMGOn
         CHWg5Kq7SZucC+LqEzhxHZXq/5WTxZoEJw2nXgNY0CO8gqOIZEbHnUX5zNlomRjnHAaV
         6ndA==
X-Gm-Message-State: AOAM531smM5BeK0rje+ggDOSI1z3TNFCYm2/lxCO1LwAITwlhSsd+m93
        QQxAERoKLGDPFUmkgQtFArMZrELnKSIzQg==
X-Google-Smtp-Source: ABdhPJxxBZ5wxOSwsnJUso/K1iFZaRYt3LJplJOMEmFBsSSBdqL+CoSH3Oj8ijg4eFnWClC5F5RUcg==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr4630755wrs.342.1603823512576;
        Tue, 27 Oct 2020 11:31:52 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:31:51 -0700 (PDT)
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
Subject: [PATCH v9 00/14] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Tue, 27 Oct 2020 19:31:35 +0100
Message-Id: <20201027183149.145165-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add H6 I2S support and the I2S node missing to support
HDMI audio in different Allwinner SoC.

As we first use some TDM property to make the I2S working we the
simple soundcard. We have now drop this simple sound card and a
proper dedicated soundcard will be introduce later.

This make the title of this series wrong now :/.

Regards,
Clement

Change since v8:
- move the comment near the function prototype
- collect Maxime Ripard tags

Change since v7:
- rebase on next-20201026
- comment about slots and slot_width

Change since v6:
- move set_channel_cfg() in first position
- convert return value to decimal

Change since v5:
- Drop HDMI simple soundcard
- Collect Chen-Yu Tsai tags
- Configure channels from 9 to 15.
- Remove DMA RX for H3/H5
- Fix Documentation for H3/H5

Change since v4:
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
  ASoC: sun4i-i2s: fix coding-style for callback definition
  arm64: defconfig: Enable Allwinner i2s driver
  dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel
    possibility

Jernej Skrabec (3):
  ASoC: sun4i-i2s: Add support for H6 I2S
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  arm64: dts: allwinner: h6: Add I2S1 node

Marcus Cooper (4):
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  arm64: dts: allwinner: a64: Add I2S2 node
  arm: dts: sunxi: h3/h5: Add I2S2 node

Samuel Holland (1):
  ASoC: sun4i-i2s: Fix setting of FIFO modes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   6 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  13 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  14 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  13 +
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 384 +++++++++++++++---
 6 files changed, 376 insertions(+), 55 deletions(-)

-- 
2.25.1

