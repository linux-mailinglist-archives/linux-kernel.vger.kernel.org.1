Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59D2A0859
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgJ3OrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgJ3OrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:00 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD9C0613D4;
        Fri, 30 Oct 2020 07:46:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u127so6869425oib.6;
        Fri, 30 Oct 2020 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KelKv6QuhcXrOVTDysjuR2N/UDbFgkAgyB58VLYR2Cc=;
        b=i7AAld3nd1vqHbAt7c4ECVGFsPnExGyUiImnF0+1hZg5p/YfFnm41rF+FGn1sCvm5V
         ziFxRWKCd1kat1/C3nRghkBoIChBsRMY0gC7KfH5vahKRKoj3qA4sTCqTlWv+XByxGBq
         0VZ2Tvdt4SomDIhwyV9WGKqY+5TxuaBSGh+7SRXzrYAKVA/ZQKzWlOFpGrUiUWjJeojE
         ZGpD1GKchSAsgqexuCVM0h2yqK4KpzEuQyYDcGhhUJKjBtL8kZTOWQ/YwmHQVluChzU/
         lcMpjbLCL3m/WK5fRGImxp0sN9gzx5I+0aHMJ95bvWSXbpcprloz5ZxZrLFi45WC7di0
         DwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KelKv6QuhcXrOVTDysjuR2N/UDbFgkAgyB58VLYR2Cc=;
        b=SvtfXfzeeqJrHSVpiYv2JwbNosp/cHIcACUpC23t53Jq26gEMe+TWIBv+naJjVQw9b
         DQavevSaHbktnmZcGujDE8LsUOFKz/Mea9ql9Ll9t1doEWzMdTK0yLM4Z+DOU5JAY8Yy
         gE+IcMVxp9h0iQYnV0u5pthiqtLMw/KgB5+BSdHCEzoN+tMycCIyTlEqiQuRltFz8kYI
         eu8GPU5jqdBiMdwCOtjp3eY2Ks3dkwxQil98ekaOXpWTd4BEF/Yml6s0ZtuRJS61LTl3
         gpzf7svNeIaLYwTZCWmiVNhrRMizMk2OT/SnACTpTLwrxkvdyEBgSb8pYJPEa5F8wMeR
         3fYw==
X-Gm-Message-State: AOAM533gqIoie/tYUHm4PPWXlT9+aMpqNXI7eZ7m8sWY3EpW0yNiqNnj
        fWndyP0FB1sCLrl9DeAbbK4=
X-Google-Smtp-Source: ABdhPJyTUhg+1uuyzQZecKdw6YSoZcrR37SHffE66ksSbQGfyR8KC4fr5TfZ/52hNaEtGr2jD9Lssg==
X-Received: by 2002:a05:6808:9a9:: with SMTP id e9mr1753864oig.37.1604069215295;
        Fri, 30 Oct 2020 07:46:55 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:46:54 -0700 (PDT)
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
Subject: [PATCH v10 00/15] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Fri, 30 Oct 2020 15:46:33 +0100
Message-Id: <20201030144648.397824-1-peron.clem@gmail.com>
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

As we first use some TDM property to make the I2S working with the
simple soundcard. We have now drop this simple sound card and a
proper dedicated soundcard will be introduce later.

This make the title of this series wrong now but to be able to
follow the previous release I keep the same name.

Regards,
Clement

Change since v9:
- fix lrck_period computation for I2S justified mode

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

Clément Péron (7):
  ASoC: sun4i-i2s: Fix lrck_period computation for I2S justified mode
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
  ASoC: sun4i-i2s: Add 20 and 24 bit support
  arm64: dts: allwinner: a64: Add I2S2 node
  arm: dts: sunxi: h3/h5: Add I2S2 node

Samuel Holland (1):
  ASoC: sun4i-i2s: Fix setting of FIFO modes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   6 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  13 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  14 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  13 +
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 388 +++++++++++++++---
 6 files changed, 378 insertions(+), 57 deletions(-)

-- 
2.25.1

